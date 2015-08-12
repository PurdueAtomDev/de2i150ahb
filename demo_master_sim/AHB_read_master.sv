//File name: AHB_read_master.sv
//Created:   7/12/2015
//Author:    Nianpei Deng
//Version:   1.0
/*Description: This module is modified from the Avalon read master template so that it has AHB master interface.
To understand its usage and connections to your user modules, please refer to https://www.altera.com/support/support-resources/design-examples/intellectual-property/embedded/nios-ii/exm-avalon-mm.html
*/



module AHB_read_master
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
    input logic [ADDRESSWIDTH-1:0]  control_read_base,
    input logic [ADDRESSWIDTH-1:0]  control_read_length,
    input logic 		    control_go,
    output logic 		    control_done,
    output logic 		    abort,
    input logic [2:0] 		    data_size,
		     
		     // user logic inputs and outputs
    input logic 		    user_read_buffer,
    output logic [DATAWIDTH-1:0]    user_buffer_data,
    output logic 		    user_data_available,
	
	// AHB master interface inputs and outputs
    output logic 		    HSEL,
    input logic 		    HREADY,
    input logic [1:0]		    HRESP,
    input logic [DATAWIDTH-1:0]     HRDATA,
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
   logic [FIFODEPTH_LOG-1:0] 	   fifo_used;
   logic [ADDRESSWIDTH-1:0] 	   address;
   logic [ADDRESSWIDTH-1:0] 	   length;
   logic 			   increment_address;
   logic 			   new_data_flag;
   logic [1:0] 			   HTRANS_r;
   logic 			   HRESP_r;
   logic 			   delay;
   logic [2:0] 			   addr_step, addr_step_r;
   

   typedef enum 		   {IDLE, NON_SEQ, SEQ, ERR, DELAY_1, DELAY_2} state_t;
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
		  address <= control_read_base;
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
		  length <= control_read_length;
	       end
	     else if(increment_address == 1)
	       begin
		  length <= length - addr_step_r;
	       end
	  end
     end

   //HBurst logic
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     HBURST <= 3'b000;
	  end
	else begin
	   if (control_go == 1)
	     begin
		if (control_read_length == 4) begin
		   HBURST <= 3'b000;
		end
		else if (control_read_length == 16) begin
		   HBURST <= 3'b011;
		end
		else if (control_read_length == 32) begin
		   HBURST <= 3'b101;
		end
		else if (control_read_length == 64) begin
		   HBURST <= 3'b111;
		end
		else begin
		   HBURST <= 3'b001;
		end
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
		     if (delay) begin
			state <= DELAY_1;
		     end
		     else begin
			state <= NON_SEQ;
		     end
		  end
	       end
	       DELAY_1: begin
		  if (!delay) begin
		     state <= NON_SEQ;
		  end
	       end
	       NON_SEQ: begin
		  if (HRESP[0]) begin
		     state <= ERR;
		  end
		  else if (HREADY) begin
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
	 	  else if (HREADY) begin
		     if (length == addr_step_r) begin
			state <= IDLE;
		     end
		     else if (delay) begin
			state <= DELAY_2;
		     end
		  end
	       end
	       ERR: begin
      		  if (control_go == 1) begin
		     if (delay) begin
			state <= DELAY_1;
		     end
		     else begin
			state <= NON_SEQ;
		     end
		  end
	       end
	       DELAY_2: begin
		  if (!delay) begin
		     state <= SEQ;
		  end
	       end
	     endcase 
	  end 
     end

   //generate HTRANS signal according to the FSM
   assign HTRANS = (state == NON_SEQ) ? 2'b10 : ((state == SEQ) ? 2'b11 : ((state == DELAY_2) ? 2'b01 : 2'b00));
   
   //registering HTRANS and HRESP
   always @ (posedge clk or negedge reset_n)
     begin
	if (reset_n == 0)
	  begin
	     HTRANS_r <= 2'b00;
	     HRESP_r <= 0;
	  end
	else
	  begin
	     if (HREADY) begin
		HTRANS_r <= HTRANS;
		HRESP_r <= HRESP[0];
	     end
	  end
     end

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

	
   // control logic
   assign HWRITE = 1'b0;
   assign increment_address = HREADY & (!HRESP[0]) & ((state == SEQ) | (state == NON_SEQ));
   assign control_done = (length == 0) & HREADY;  // master done posting reads and all reads have returned
   assign abort = (state == ERR);                 //due to error, the transfer is abort
   assign new_data_flag = (!HRESP_r) & ((HTRANS_r == 2'b10) | (HTRANS_r == 2'b11)) & HREADY;  //indicates read data is ready
   assign delay = (fifo_used >= (FIFODEPTH - 4));   //indicates that fifo is about to be full
   assign HSEL = 1'b1;

	
   // read data feeding user logic	
   assign user_data_available = !fifo_empty;
   fifo_r # (
	     .DATAWIDTH(DATAWIDTH),
	     .FIFO_DEPTH(FIFODEPTH),
	     .FIFO_DEPTH_LOG2(FIFODEPTH_LOG)
	     ) fifo_2 (
		       .rdclk(clk),
		       .wrclk(clk),
		       .aclr (~reset_n),
		       .data (HRDATA),
		       .rdempty (fifo_empty),
		       .wrusedw(fifo_used),
		       .q (user_buffer_data),
		       .rdreq (user_read_buffer),
		       .wrreq (new_data_flag)
		       );

endmodule
