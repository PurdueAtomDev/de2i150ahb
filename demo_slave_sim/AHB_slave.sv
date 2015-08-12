// $Id: $
// File name:	AHB_slave.sv
// Created: 	6/12/2015
// Author: 	Nianpei Deng
// Version: 	2.0 
// ahb_slave module : AHB interface IP to your custom logic. Two registers of the registers files are mapped into buffer write and buffer read

module AHB_slave 
  #(
    parameter ADDRESSWIDTH = 32,                // specifies address width of AHB bus
    parameter DATAWIDTH = 32,    		// specifies the data width
    parameter NUMREGS = 32,       		// Number of registers in the register file
    parameter REGWIDTH = 32,       		// Data Width of registers in the register file
    parameter FIFO_DEPTH = 64,                  // FIFO depth
    parameter FIFO_DEPTH_LOG2 = 6               // log2(FIFO depth)
    )
   (
    input logic 		   clk,
    input logic 		   reset_n,


    //Bus Slave Interface
    input logic 		   HSEL,
    input logic [ADDRESSWIDTH-1:0] HADDR,
    input logic 		   HWRITE,
    input logic [2:0] 		   HSIZE,
    input logic [2:0] 		   HBURST,
    input logic [3:0] 		   HPROT,
    input logic [1:0] 		   HTRANS,
    input logic 		   HREADY,
    input logic [DATAWIDTH-1:0]    HWDATA,
    output logic 		   HREADYOUT,
    output logic [1:0] 		   HRESP,
    output logic [DATAWIDTH-1:0]   HRDATA,

    //User Logic Interface to buffer read and write
    input logic 		   w_fifo_write_enable, 
    input logic [DATAWIDTH-1:0]    w_fifo_write_data, 
    output logic 		   w_fifo_full, 
    input logic 		   r_fifo_read_enable, 
    output logic [DATAWIDTH-1:0]   r_fifo_read_data, 
    output logic 		   r_fifo_empty,
   
    //User logic interface to read and write access of register file
    input logic [ADDRESSWIDTH-1:0] u_addr,
    output logic [DATAWIDTH-1:0]   u_read_data,
    input logic 		   u_write,
    input logic [DATAWIDTH-1:0]    u_write_data

    );

   localparam BYTE_LANE_NUM = REGWIDTH / 8; //each register is split into several byte lanes
   
   logic [7:0] 			   csr_registers [NUMREGS-1:0][BYTE_LANE_NUM-1:0]; //command registers of the slave
   logic [7:0] 			   wire_zero [NUMREGS-1:0][BYTE_LANE_NUM-1:0];
   logic [1:0] 			   byte_index, byte_index_reg; //get the least two bits of haddr
   logic [ADDRESSWIDTH-3:0] 	   addr_reg;
   logic [ADDRESSWIDTH-3:0] 	   word_addr;
   logic 			   hwrite_reg;
   logic 			   buffer_write_reg, buffer_write;
   logic 			   buffer_read_reg, buffer_read;
   logic [2:0] 			   hsize_reg;
   logic [1:0] 			   htrans_reg;
   logic 			   error_reg, error;
   logic 			   r_fifo_write_enable;
   logic 			   r_fifo_full;
   logic [DATAWIDTH-1:0] 	   r_fifo_write_data;
   logic 			   w_fifo_read_enable;
   logic 			   w_fifo_empty;
   logic [DATAWIDTH-1:0] 	   w_fifo_read_data;  

   genvar 			   i, j;


   //address checker
   assign word_addr = HADDR >> 2;
   assign byte_index = HADDR[1:0];
   assign error = (HTRANS != 2'b00) & ((word_addr >= NUMREGS) | (HSIZE > 3'b10)); //respond error if not hitting actuall register

   
   //buffer read or write checker
   assign buffer_write = HSEL & HWRITE & ((HTRANS == 2'b10) || (HTRANS == 2'b11)) & (word_addr == 0); //register[0] is mapped to buffer write
   assign buffer_read = HSEL & (~HWRITE) & ((HTRANS == 2'b10) || (HTRANS == 2'b11)) & (word_addr == 1); //register[1] is mapped to buffer read
   
   
   //Pipeline registers: registering buffer_read, buffer_write, word_addr, and other control signals
   always_ff @ (posedge clk, negedge reset_n) begin
         if (!reset_n)
             begin
	              addr_reg <= 0;
		      byte_index_reg <= 0;
	              hwrite_reg <= 1'b0;
	              buffer_write_reg <= 1'b0;
	              buffer_read_reg <= 1'b0;
                      hsize_reg <= 3'b10; //default word access
	              htrans_reg <= 2'b00;
	              error_reg <= 1'b0;
             end
         else
             begin
	              if (HREADYOUT) begin
	                         addr_reg <= word_addr;
			         byte_index_reg <= byte_index;
	                         hwrite_reg <= HWRITE;
	                         buffer_write_reg <= buffer_write;
	                         buffer_read_reg <= buffer_read;
	                         hsize_reg <= HSIZE;
	                         htrans_reg <= HTRANS;
	                         error_reg <= error;
	              end
	     end
   end

   //slave buffer write operation (generate FIFO_EN Signal)
   assign r_fifo_write_enable = (buffer_write_reg & (!r_fifo_full)) ? 1'b1 : 1'b0;
   assign r_fifo_write_data = HWDATA;
   
   //stall logic
   assign HREADYOUT = ((buffer_write_reg & r_fifo_full) || (buffer_read_reg & w_fifo_empty)) ? 1'b0 : 1'b1;
   
   assign HRESP = {1'b0, error};

   //zero wires for initiating the command registers
   generate
      for (i = 0; i < NUMREGS; i++) begin : ZEROs
	    for (j = 0; j < BYTE_LANE_NUM; j++) begin : ZEROs_1
	           assign wire_zero[i][j] = 0;
	    end
      end
   endgenerate

   
   //write operation for non-buffer registers in the register file
   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n)
	   begin
	           csr_registers <= wire_zero;
	   end
      else
	   begin
	           if (HSEL & hwrite_reg & (!error_reg) & ((htrans_reg == 2'b10) || (htrans_reg == 2'b11)))
	              begin
	 	              if (hsize_reg == 3'b01) begin
		                     csr_registers[addr_reg][byte_index_reg] <= HWDATA[7:0];
		                     csr_registers[addr_reg][byte_index_reg + 1] <= HWDATA[15:8];
		              end
		              if (hsize_reg == 3'b00) begin
		                     csr_registers[addr_reg][byte_index_reg] <= HWDATA[7:0];
		              end
			      else begin
				     csr_registers[addr_reg][0] <= HWDATA[7:0];
		                     csr_registers[addr_reg][1] <= HWDATA[15:8];
		                     csr_registers[addr_reg][2] <= HWDATA[23:16];
		                     csr_registers[addr_reg][3] <= HWDATA[31:24];
			      end
	              end

	           if (u_write) //user write dual port
	              begin
		              csr_registers[u_addr][0] <= u_write_data[7:0];
		              csr_registers[u_addr][1] <= u_write_data[15:8];
		              csr_registers[u_addr][2] <= u_write_data[23:16];
		              csr_registers[u_addr][3] <= u_write_data[31:24];
	              end
	   end
   end

   
   //slave read operation (including both buffer read and other non-buffer reads)
   always_comb begin
      HRDATA = 0;
      w_fifo_read_enable = 1'b0;
      if (buffer_read_reg) begin   //for buffer read
	    if (!w_fifo_empty) begin
	           HRDATA = w_fifo_read_data;
	           w_fifo_read_enable = 1'b1;
	    end
      end
      else begin            // for non_buffer reads
	    if (HSEL & (!hwrite_reg) & (!error_reg) & ((htrans_reg == 2'b10) || (htrans_reg == 2'b11))) begin
	           if (hsize_reg == 3'b01) begin
	                 HRDATA[7:0] = csr_registers[addr_reg][byte_index_reg];
	                 HRDATA[15:8] = csr_registers[addr_reg][byte_index_reg + 1];
	                 HRDATA[23:16] = '0;
	                 HRDATA[31:24] = '0;
	           end
	           if (hsize_reg == 3'b00) begin
	                 HRDATA[7:0] = csr_registers[addr_reg][byte_index_reg];
	                 HRDATA[15:8] = '0;
	                 HRDATA[23:16] = '0;
	                 HRDATA[31:24] = '0;
	           end
	           else begin
		         HRDATA[7:0] = csr_registers[addr_reg][0];
	                 HRDATA[15:8] = csr_registers[addr_reg][1];
	                 HRDATA[23:16] = csr_registers[addr_reg][2];
	                 HRDATA[31:24] = csr_registers[addr_reg][3];
		   end
	    end
      end
   end

   //user read operation (read dual port)
   generate
      for (i = 0; i < BYTE_LANE_NUM; i++) begin : UREAD
	     assign u_read_data[8*i+7:8*i] = csr_registers[u_addr][i];
      end
   endgenerate

   //FIFO instantiation
     //user buffer read fifo
   fifo # (
	   .DATAWIDTH(DATAWIDTH),
	   .FIFO_DEPTH(FIFO_DEPTH),
	   .FIFO_DEPTH_LOG2(FIFO_DEPTH_LOG2)
	   ) r_fifo (
		     .rdclk(clk),
		     .wrclk(clk),
		     .aclr(~reset_n),
		     .rdreq(r_fifo_read_enable),
		     .wrreq(r_fifo_write_enable),
		     .data(r_fifo_write_data),
		     .q(r_fifo_read_data),
		     .rdempty(r_fifo_empty),
		     .wrfull(r_fifo_full)
		     );

     //user buffer write fifo
   fifo # (
	   .DATAWIDTH(DATAWIDTH),
	   .FIFO_DEPTH(FIFO_DEPTH),
	   .FIFO_DEPTH_LOG2(FIFO_DEPTH_LOG2)
	   ) w_fifo (
		     .rdclk(clk),
		     .wrclk(clk),
		     .aclr(~reset_n),
		     .rdreq(w_fifo_read_enable),
		     .wrreq(w_fifo_write_enable),
		     .data(w_fifo_write_data),
		     .q(w_fifo_read_data),
		     .rdempty(w_fifo_empty),
		     .wrfull(w_fifo_full)
		     );

   
endmodule
 
   
	   
      
	   
