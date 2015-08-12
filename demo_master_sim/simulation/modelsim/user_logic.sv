//
module user_logic #(
		    parameter ADDRESSWIDTH = 32 ,
		    parameter DATAWIDTH = 32,
		    parameter BYTEENABLEWIDTH = 4,
		    parameter NUMREGS = 32
)
(
 input logic 			 clk,
 input logic 			 reset_n,
 input logic [DATAWIDTH-1:0] 	 data,
 output logic [ADDRESSWIDTH-1:0] data_addr,
 output logic 			 r_fifo_read_enable,
 input logic [DATAWIDTH-1:0] 	 r_fifo_read_data,
 input logic 			 r_fifo_empty,

 input logic 			 add_data_sel,         // Interfaced to switch. Selects either Data or Address to be displayed on the Seven Segment Displays.
 input logic [15:0] 		 rdwr_address,         // read_address if required to be sent from another block. Can be unused if consecutive reads are required.
 output logic [DATAWIDTH-1:0] 	 display_data,         // Display data for the Seven Seg dislays.

 // user Control interface to write master
 input logic 			 write_control_done,                  // Asserted and held when Master is done writing last word.Start next request on the next cycle.
 input logic 			 write_abort,
 output logic 			 write_control_fixed_location,        // When set Master will not increment address
 output logic [ADDRESSWIDTH-1:0] write_control_write_base,            // Address to write data into
 output logic [ADDRESSWIDTH-1:0] write_control_write_length,          // Number of bytes to transfer. Must be multiple of DATAWIDTH
 output logic 			 write_control_go,                    // Start write 	
 output logic [2:0] 		 write_data_size,

 // user interface to write master fifo
 output logic 			 write_user_write_buffer,             // Write signal
 output logic [DATAWIDTH-1:0] 	 write_user_buffer_data,              // Write Data
 input logic 			 write_user_buffer_full,              // Buffer full signal. Don't write if asserted

 // user Control interface to read master
 input logic 			 read_control_done,                   //Asserted and held when Master is done writing last word.Start next request on the next cycle.	
 output logic 			 read_control_fixed_location,         //When set Master will not increment address
 output logic [ADDRESSWIDTH-1:0] read_control_read_base,              //Address to read Data from
 output logic [ADDRESSWIDTH-1:0] read_control_read_length,            //Number of bytes to read. Must be multiple of DATAWIDTH
 output logic 			 read_control_go,                     // Start read
 input logic 			 read_abort,
 output logic [2:0] 		 read_data_size,

 // user interface to read master fifo
 output logic 			 read_user_read_buffer,                // Read signal
 input logic [DATAWIDTH-1:0] 	 read_user_buffer_data,                // Valid data to be read when user_data_available is asserted
 input logic 			 read_user_data_available	       //Read data is available.Assert user_read_buffer only when this is asserted.
);

   localparam ADDRESS_BASE = 32'h00000000;  //base address user can set to the AHB masters
   localparam WDATA_ADDR_BASE = 32'h2;      //starting address of AHB slave register file that user wants to poll
   localparam COUNT_NUM = 4;
   localparam NUM_TRANSFER = 32;            //number of bytes to be transferred
   localparam START_BYTE = 32'hF00BF00B;    //start AHB write master command
   localparam STOP_BYTE = 32'hDEADF00B;     //start AHB read master command
   

   logic [DATAWIDTH-1:0] 	       rd_data;
   logic [ADDRESSWIDTH-1:0] 	       next_data_addr;
   logic [ADDRESSWIDTH-1:0] 	       length, nextlength; 
   logic 			       start_run_r, stop_run_r;
   logic [NUMREGS-1:0][DATAWIDTH-1:0]  read_data_registers;
   logic [DATAWIDTH-1:0] 	       index, next_index;
   logic 			       stop_run, start_run;

   typedef enum 	    {IDLE, WRITE, WRITE_WAIT, READ_REQ, READ_DATA} state_t;
   state_t state, nextState;

   
   //assign several control parameters to the AHB master IPs
   assign write_control_write_length = NUM_TRANSFER;
   assign write_control_fixed_location = 1'b0;   //must be zero for number of bytes larger than 4
   assign read_control_fixed_location = 1'b0;    //must be zero for number of bytes larger than 4
   assign read_control_read_length = NUM_TRANSFER;
   assign write_data_size = 2;
   assign read_data_size = 2;

   
   //top level conduits to display the internal registers of user logic on board LCD
   assign display_data = add_data_sel ? read_data_registers[rdwr_address[4:0]] : 2;

   //user reading the AHB buffer read for start and stop commands
   assign r_fifo_read_enable = (~r_fifo_empty);

   //user receives the data and decodes the commands
   assign start_run = (r_fifo_read_data == START_BYTE);
   assign stop_run = (r_fifo_read_data == STOP_BYTE);
   
     //edge detector of command signals
   always_ff @ (posedge clk or negedge reset_n) begin
      if (!reset_n) begin
	 start_run_r <= 0;
	 stop_run_r <= 0;
      end
      else begin
	 start_run_r <= start_run;
	 stop_run_r <= stop_run;
      end
   end

   assign start = (~start_run_r) & (start_run);
   assign stop = (~stop_run_r) & (stop_run);


   //registering several counters and the address to poll in the AHB slave register file
   always_ff @ (posedge clk or negedge reset_n) begin
      if(!reset_n) begin
	     state <= IDLE;	 
             length <= NUM_TRANSFER;
	     data_addr <= WDATA_ADDR_BASE;
	     read_data_registers <= '0;
	     index <= 0;
      end else begin
	     state <= nextState;
             length <= nextlength;
             data_addr <= next_data_addr;	 
	     index <= next_index;
	 
	     if (read_user_data_available) begin
	           read_data_registers[index] <= read_user_buffer_data;
	     end
      end
   end

   
  //read data from the AHB slave register file
   assign write_user_buffer_data = data;
 
  // Next State machine Logic  
   always_comb begin
      nextState = state;
      nextlength = length; //counter
   
      write_control_go = 1'b0;    //write master control signals
      write_user_write_buffer = 1'b0;
      write_control_write_base = 0;
      
      read_control_go = 1'b0;    //read master control signals
      read_control_read_base = 0;
      read_user_read_buffer = 1'b0;
		
      next_data_addr = data_addr;  //address to poll in the AHB slave register file
      next_index = index;
      
      case(state)
	IDLE: begin
	   if(start) begin
	          nextState = WRITE;
	          write_control_go = 1'b1;
	          write_user_write_buffer = 1'b1;		
	          write_control_write_base = ADDRESS_BASE;
	          next_data_addr = data_addr + 1;
	   end
	   
	   if(stop) begin
	          nextState = READ_REQ;
	   end
	end
	WRITE: begin
	   if (length == 4) begin
	          nextState = WRITE_WAIT;
	          nextlength = NUM_TRANSFER;
	   end
	   else begin
	          if (!write_user_buffer_full) begin
		       write_user_write_buffer = 1'b1;
	               next_data_addr = data_addr + 1;
		       nextlength = length - 4;
	          end
	   end
	end
	WRITE_WAIT: begin
	   if (write_control_done) begin
	          nextState = IDLE;
	          next_data_addr = WDATA_ADDR_BASE;
	   end
	end
	READ_REQ: begin
	   read_control_go = 1'b1;
	   read_control_read_base = ADDRESS_BASE;
	   nextState = READ_DATA;
	end
	READ_DATA: begin
	   if (length == 0) begin
	          nextState = IDLE;
	          nextlength = NUM_TRANSFER;
	          next_index = 0;
	   end
	   else begin
	          if (read_user_data_available) begin
	     	      read_user_read_buffer = 1'b1;		    
		      nextlength = length - 4;
		      next_index = index + 1;
	          end
	   end
	end
	default: begin
	end
      endcase	
   end


endmodule
