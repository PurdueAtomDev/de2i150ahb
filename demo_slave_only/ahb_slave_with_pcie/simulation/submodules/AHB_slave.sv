// $Id: $
// File name:	ahb_master_slave.sv
// Created: 	6/12/2015
// Author: 	Nianpei Deng
// Version: 	2.0 
// ahb_slave module : support AHB writes and reads to the slave register files. Two registers of the registers files are mapped into buffer write and buffer read

module AHB_slave 
  #(
    parameter ADDRESSWIDTH = 32,
    parameter DATAWIDTH = 32,    		// DATAWIDTH specifies the data width. Default 32 bits
    parameter NUMREGS = 8,       		// Number of Internal Registers for Custom Logic
    parameter REGWIDTH = 32       		// Data Width for the Internal Registers. Default 32 bits
    )
   (
    input logic 		   clk,
    input logic 		   reset_n,

    //Interface to Top Level
    input logic 		   add_data_sel,
    input logic [ADDRESSWIDTH-1:0] rdwr_address,
    output logic [DATAWIDTH-1:0]   display_data,

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
    output logic [1:0]		   HRESP,
    output logic [DATAWIDTH-1:0]   HRDATA,
   

    //for user random read access
    input logic [ADDRESSWIDTH-1:0] u_addr,
    output logic [DATAWIDTH-1:0]   u_read_data

    );

   //User Logic Interface
   logic 			   w_fifo_write_enable;   
   logic [DATAWIDTH-1:0] 	   w_fifo_write_data;   
   logic 			   w_fifo_full;   
   logic 			   r_fifo_read_enable;   
   logic [DATAWIDTH-1:0] 	   r_fifo_read_data;  
   logic 			   r_fifo_empty;   
   
   logic [REGWIDTH/4-1:0] 	   csr_registers [NUMREGS-1:0][3:0]; //command registers of the slave
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
   


   //display read data registers on board LCDs
   //assign display_data = add_data_sel ? csr_registers[rdwr_address[4:0]] : 1;

   //address checker
   assign word_addr = HADDR >> 2;
   assign error = (HTRANS != 2'b00) & ((HADDR[1:0] != 2'b00) | (word_addr >= NUMREGS));
   //buffer read or write checker
   assign buffer_write = HWRITE & ((HTRANS == 2'b10) || (HTRANS == 2'b11)) & (word_addr == 0);
   assign buffer_read = (~HWRITE) & ((HTRANS == 2'b10) || (HTRANS == 2'b11)) & (word_addr == NUMREGS-1);
   
   
   //registering buffer_read, buffer_write, word_addr, and other control signals
   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n)
	begin
	   addr_reg <= 30'b0;
	   hwrite_reg <= 1'b0;
	   buffer_write_reg <= 1'b0;
	   buffer_read_reg <= 1'b0;
	   hsize_reg <= 3'b10;
	   htrans_reg <= 2'b00;
	   error_reg <= 1'b0;
	end
      else
	begin
	   if (HREADYOUT) begin
	      addr_reg <= word_addr;
	      hwrite_reg <= HWRITE;
	      buffer_write_reg <= buffer_write;
	      buffer_read_reg <= buffer_read;
	      hsize_reg <= HSIZE;
	      htrans_reg <= HTRANS;
	      error_reg <= error;
	   end
	end
   end

   //slave write operation
   assign r_fifo_write_enable = (buffer_write_reg & (!r_fifo_full)) ? 1'b1 : 1'b0;
   assign r_fifo_write_data = HWDATA;
   //data phase stall logic
   assign HREADYOUT = ((buffer_write_reg & r_fifo_full) || (buffer_read_reg & w_fifo_empty)) ? 1'b0 : 1'b1;
   assign HRESP = error;

   //write operation for non-buffer registers in the register file
   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n)
	begin
	   for (integer i = 0; i < NUMREGS; i++) begin
	      csr_registers[i][0] <= '0;
	      csr_registers[i][1] <= '0;
	      csr_registers[i][2] <= '0;
	      csr_registers[i][3] <= '0;
	   end
	end
      else
	begin
	   //register the address and hwrite signals as data phase is after the address phase
	   //write operations
	   if (hwrite_reg & (!error_reg) & ((htrans_reg == 2'b10) || (htrans_reg == 2'b11)))
	     begin
		if (hsize_reg == 3'b10) begin
		   csr_registers[addr_reg][0] <= HWDATA[7:0];
		   csr_registers[addr_reg][1] <= HWDATA[15:8];
		   csr_registers[addr_reg][2] <= HWDATA[23:16];
		   csr_registers[addr_reg][3] <= HWDATA[31:24];
		end
		if (hsize_reg == 3'b01) begin
		   csr_registers[addr_reg][0] <= HWDATA[7:0];
		   csr_registers[addr_reg][1] <= HWDATA[15:8];
		end
		if (hsize_reg == 3'b00) begin
		   csr_registers[addr_reg][0] <= HWDATA[7:0];
		end
	     end
	end
   end
   
   //slave read operation (including both buffer read and other non-buffer reads)
   always_comb begin
      HRDATA = 0;
      w_fifo_read_enable = 1'b0;
      if (buffer_read_reg) begin
	 if (!w_fifo_empty) begin
	    HRDATA = w_fifo_read_data;
	    w_fifo_read_enable = 1'b1;
	 end
      end
      else begin
	 if ((!hwrite_reg) & (!error_reg) & ((htrans_reg == 2'b10) || (htrans_reg == 2'b11))) begin
	    if (hsize_reg == 3'b10) begin
	       HRDATA[7:0] = csr_registers[addr_reg][0];
	       HRDATA[15:8] = csr_registers[addr_reg][1];
	       HRDATA[23:16] = csr_registers[addr_reg][2];
	       HRDATA[31:24] = csr_registers[addr_reg][3];
	    end
	    if (hsize_reg == 3'b01) begin
	       HRDATA[7:0] = csr_registers[addr_reg][0];
	       HRDATA[15:8] = csr_registers[addr_reg][1];
	       HRDATA[23:16] = '0;
	       HRDATA[31:24] = '0;
	    end
	    if (hsize_reg == 3'b00) begin
	       HRDATA[7:0] = csr_registers[addr_reg][0];
	       HRDATA[15:8] = '0;
	       HRDATA[23:16] = '0;
	       HRDATA[31:24] = '0;
	    end
	 end
      end
   end

   //user read operation
   assign u_read_data[7:0] = csr_registers[u_addr][0];
   assign u_read_data[15:8] = csr_registers[u_addr][1];
   assign u_read_data[23:16] = csr_registers[u_addr][2];
   assign u_read_data[31:24] = csr_registers[u_addr][3];

   //user_logic instantiation
   user_logic u_logic (
		       .clk(clk),
		       .reset_n(reset_n),
		       .wrreq(w_fifo_write_enable),
		       .wdata(w_fifo_write_data),
		       .wrfull(w_fifo_full),
		       .rdack(r_fifo_read_enable),
		       .rdata(r_fifo_read_data),
		       .rdempty(r_fifo_empty)
		       );

   //FIFO instantiation
   fifo r_fifo (
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

   fifo w_fifo (
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
 
   
	   
      
	   
