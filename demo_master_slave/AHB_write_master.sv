//File name: AHB_write_master.sv
//Created:   7/12/2015
//Author:    Nianpei Deng
//Version:   1.0
/*Description: This module is modified from the Avalon read write template so that it has AHB master interface.
To understand its usage and connections to your user modules, please refer to https://www.altera.com/support/support-resources/design-examples/intellectual-property/embedded/nios-ii/exm-avalon-mm.html
*/



module AHB_write_master
#(
  parameter ADDRESSWIDTH = 32,
  parameter DATAWIDTH = 32,
  parameter FIFODEPTH = 32,
  parameter FIFODEPTH_LOG = 5
  )
   (
    input logic 		    clk,
    input logic 		    reset_n,
		     
    // control inputs and outputs
    input logic 		    control_fixed_location,
    input logic [ADDRESSWIDTH-1:0]  control_write_base,
    input logic [ADDRESSWIDTH-1:0]  control_write_length,
    input logic 		    control_go,
    output logic 		    control_done,
    output logic 		    abort,
    input logic [2:0] 		    data_size,
    
    // user logic inputs and outputs
    input logic 		    user_write_buffer,
    input logic [DATAWIDTH-1:0]     user_buffer_data,
    output logic 		    user_buffer_full,
	
	// AHB master interface inputs and outputs
    output logic 		    HSEL,
    input logic 		    HREADY,
    input logic [1:0]		    HRESP,
    output logic [DATAWIDTH-1:0]    HWDATA,
    output logic [ADDRESSWIDTH-1:0] HADDR,
    output logic 		    HWRITE,
    output logic [2:0] 		    HSIZE,
    output logic [2:0] 		    HBURST,
    output logic [3:0] 		    HPROT,
    output logic [1:0] 		    HTRANS,
    output logic 		    HREADYIN
    );

   // internal control signals
   reg 				   control_fixed_location_r;
   logic 			   fifo_empty;
   logic [ADDRESSWIDTH-1:0] 	   address;
   logic [ADDRESSWIDTH-1:0] 	   length;
   logic 			   increment_address;
   logic 			   read_fifo;
   logic [DATAWIDTH-1:0] 	   write_data;
   logic [2:0] 			   addr_step, addr_step_r;

   typedef enum 		   {IDLE, NON_SEQ, SEQ, ERR} state_t;
   state_t state;
  

   // decode data_size
   always_comb begin
      addr_step = 4;
      case (data_size)
	   3'b000: begin
	         addr_step = 1;
	   end
	   3'b001: begin
	         addr_step = 2;
	   end
	   3'b010: begin
	         addr_step = 4;
	   end
	   default: begin
	   end
      endcase 
   end 

   // registering the control_fixed_location bit and addr_step
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     control_fixed_location_r <= 0;
	     addr_step_r <= 4;
	  end
	else
	  begin
	     if (control_go == 1)
	       begin
		  control_fixed_location_r <= control_fixed_location;
		  addr_step_r <= addr_step;
	       end
	  end
     end


   // master address logic 
   assign HADDR = address;
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     address <= 0;
	  end
	else
	  begin
	     if(control_go == 1)
	       begin
		  address <= control_write_base;
	       end
	     else if((increment_address == 1) & (control_fixed_location_r == 0))
	       begin
		  address <= address + addr_step_r;
	       end
	  end
     end

	
   // master length logic or counter
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     length <= 0;
	  end
	else
	  begin
	     if(control_go == 1)
	       begin
		  length <= control_write_length;
	       end
	     else if(increment_address == 1)
	       begin
		  length <= length - addr_step_r; 
	       end
	  end
     end	

   //finite state machine
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     state <= IDLE;
	  end
	else
	  begin
	     case (state)
	       IDLE: begin
		  if (control_go == 1) begin
		     state <= NON_SEQ;
		  end
	       end
	       NON_SEQ: begin
		  if (HRESP[0]) begin
		     state <= ERR;
		  end
		  else if (HREADY & (!fifo_empty)) begin
		     if (control_fixed_location_r) begin
			state <= IDLE;
		     end
		     else begin
			state <= SEQ;
		     end
		  end
	       end
	       SEQ: begin
		  if (HRESP[0]) begin
		     state <= ERR;
		  end
		  else if (HREADY & (!fifo_empty)) begin
		     if (length == addr_step_r) begin
			state <= IDLE;
		     end
		  end
	       end
	       ERR: begin
		  if (control_go == 1) begin
		     state <= NON_SEQ;
		  end
	       end
	     endcase 
	  end 
     end

   //HTRANS logic
   always_comb begin
      HTRANS = 2'b00;
      case (state)
	SEQ: begin
	   if (fifo_empty) begin
	      HTRANS = 2'b01;
	   end
	   else begin
	      HTRANS = 2'b11;
	   end
	end
	NON_SEQ: begin
	   if (!fifo_empty) begin
	      HTRANS = 2'b10;
	   end
	end
      endcase 
   end 
      
   //HWRITE logic
   assign HWRITE = ((state == NON_SEQ) | (state == SEQ)) & (!fifo_empty);
   
   assign read_fifo = increment_address;

   //hsize registering
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     HSIZE <= 3'b10;
	  end
	else begin
	   if (control_go == 1)
	     begin
		HSIZE <= data_size;
	     end
	end
     end 
		  
   //registering write_data
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     HWDATA <= 0;
	  end
	else begin
	   if (HREADY) begin
	      if (HSIZE == 3'b001) begin
		 HWDATA[7:0] <= write_data[7:0];
		 HWDATA[15:8] <= write_data[15:8];
		 HWDATA[DATAWIDTH-1:16] <= 0;
	      end
	      if (HSIZE == 3'b000) begin
		 HWDATA[7:0] <= write_data[7:0];
		 HWDATA[DATAWIDTH-1:8] <= 0;
	      end
	      else begin
		 HWDATA <= write_data;
	      end
	   end
	end
     end 
	
   // control logic
   assign increment_address = HREADY & (!HRESP[0]) & HWRITE;
   assign control_done = (length == 0) & HREADY;  // master done posting reads and all reads have returned
   assign abort = (state == ERR);
   assign HSEL = 1'b1;

	
   //instantiate FIFO	
   fifo_w # (
	     .DATAWIDTH(DATAWIDTH),
	     .FIFO_DEPTH(FIFODEPTH),
	     .FIFO_DEPTH_LOG2(FIFODEPTH_LOG)
	     ) fifo_1 (
		       .rdclk(clk),
		       .wrclk(clk),
		       .aclr (~reset_n),
		       .data (user_buffer_data),
		       .rdempty (fifo_empty),
		       .wrfull(user_buffer_full),
		       .q (write_data),
		       .rdreq (read_fifo),
		       .wrreq (user_write_buffer)
		       );

endmodule
