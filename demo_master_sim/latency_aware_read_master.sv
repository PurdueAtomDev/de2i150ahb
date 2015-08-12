//
/*
  Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
  use of Altera Corporation's design tools, logic functions and other
  software and tools, and its AMPP partner logic functions, and any
  output files any of the foregoing (including device programming or
  simulation files), and any associated documentation or information are
  expressly subject to the terms and conditions of the Altera Program
  License Subscription Agreement or other applicable license agreement,
  including, without limitation, that your use is for the sole purpose
  of programming logic devices manufactured by Altera and sold by Altera
  or its authorized distributors.  Please refer to the applicable
  agreement for further details.
*/

/*

	Author:  JCJB
	Date:  11/04/2007
	
	This latency aware read master is passed a word aligned address, length in bytes,
	and a 'go' bit.  The master will continue to post reads until the length register
	reaches a value of zero.  When all the reads return the done bit will be asserted. 

	To use this master you must simply drive the control signals into this block,
	and also read the data from the exposed read FIFO.  To read from the exposed FIFO
	use the 'user_read_buffer' signal to pop data from the FIFO 'user_buffer_data'.
	The signal 'user_data_available' is asserted whenever data is available from the
	exposed FIFO.
	
*/

// altera message_off 10230


module latency_aware_read_master (
	clk,
	reset_n,

	// control inputs and outputs
	control_fixed_location,
	control_read_base,
	control_read_length,
	control_go,
	control_done,
	control_early_done,
	
	// user logic inputs and outputs
        fifo_used,
	
	// master inputs and outputs
	master_address,
	master_read,
	master_waitrequest,
        master_readdatavalid
);

	parameter DATAWIDTH = 32;
	parameter ADDRESSWIDTH = 32;
	parameter FIFODEPTH = 32;
	parameter FIFODEPTH_LOG2 = 5;
	
	input clk;
	input reset_n;


	// control inputs and outputs
	input control_fixed_location;
	input [ADDRESSWIDTH-1:0] control_read_base;
	input [ADDRESSWIDTH-1:0] control_read_length;
	input control_go;
	output wire control_done;
	output wire control_early_done;  // don't use this unless you know what you are doing!
	
	// user logic inputs and outputs
	input [4:0] fifo_used;
	
	// master inputs and outputs
	input master_waitrequest;
	output wire [ADDRESSWIDTH-1:0] master_address;
	output wire master_read;
   input 	    master_readdatavalid;
	
	// internal control signals
	reg control_fixed_location_d1;
	reg [ADDRESSWIDTH-1:0] address;
	reg [ADDRESSWIDTH-1:0] length;
	reg [FIFODEPTH_LOG2-1:0] reads_pending;
	wire increment_address;
	wire too_many_pending_reads;
	reg too_many_pending_reads_d1;




	// registering the control_fixed_location bit
	always @ (posedge clk or negedge reset_n)
	begin
		if (reset_n == 0)
		begin
			control_fixed_location_d1 <= 0;
		end
		else
		begin
			if (control_go == 1)
			begin
				control_fixed_location_d1 <= control_fixed_location;
			end
		end
	end



	// master address logic 
	assign master_address = address;
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
			else if((increment_address == 1) & (control_fixed_location_d1 == 0))
			begin
				address <= address + 4;  // always performing word size accesses
			end
		end
	end

	
	
	// master length logic
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
				length <= length - 4;  // always performing word size accesses
			end
		end
	end	
	
	
	
	// control logic
	assign too_many_pending_reads = (fifo_used + reads_pending) >= (FIFODEPTH - 4);
	assign master_read = (length != 0) & (too_many_pending_reads_d1 == 0);
	assign increment_address = (length != 0) & (too_many_pending_reads_d1 == 0) & (master_waitrequest == 0);
	assign control_done = (reads_pending == 0) & (length == 0);  // master done posting reads and all reads have returned
	assign control_early_done = (length == 0);  // if you need all the pending reads to return then use 'control_done' instead of this signal


	always @ (posedge clk)
	begin
		if (reset_n == 0)
		begin
			too_many_pending_reads_d1 <= 0;
		end
		else
		begin
			too_many_pending_reads_d1 <= too_many_pending_reads;
		end
	end

	

	always @ (posedge clk or negedge reset_n)
	begin
		if (reset_n == 0)
		begin
			reads_pending <= 0;
		end
		else
		begin
			if(increment_address == 1)
			begin
				if(master_readdatavalid == 0)
				begin
					reads_pending <= reads_pending + 1;
				end
				else
				begin
					reads_pending <= reads_pending;  // a read was posted, but another returned
				end			
			end
			else
			begin
				if(master_readdatavalid == 0)
				begin
					reads_pending <= reads_pending;  // read was not posted and no read returned
				end
				else
				begin
					reads_pending <= reads_pending - 1;  // read was not posted but a read returned
				end				
			end
		end
	end


endmodule

