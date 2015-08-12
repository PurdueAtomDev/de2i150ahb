//Author: Nianpei Deng
//ahb to avalon bridge module SUPPORTS burst functionality
//keep in mind waitrequest is idle high in multi master network!!!!!!!!!!!!!
module ahb_avalon_bridge_with_burst
  #(
    parameter ADDRESSWIDTH = 32,
    parameter DATAWIDTH = 32,
    parameter FIFODEPTH = 32,
    parameter FIFODEPTH_LOG = 5,
    parameter MAXBURSTCOUNT = 8
    )
   (
    //avalon master side
    input logic 		    clk,
    input logic 		    reset_n,
    output logic [ADDRESSWIDTH-1:0] address,
    output logic 		    write,
    output logic 		    read,
    output logic [3:0] 		    byteenable,
    output logic [DATAWIDTH-1:0]    writedata,
    input logic 		    waitrequest,
    input logic 		    readdatavalid,
    input logic [DATAWIDTH-1:0]     readdata,
    output logic [3:0] 		    burstcount,

    //ahb slave side
    output logic [DATAWIDTH-1:0]    HRDATA,
    input logic 		    HREADY,
    output logic [1:0] 		    HRESP,
    input logic [2:0] 		    HBURST,
    input logic [2:0] 		    HSIZE,
    input logic [1:0] 		    HTRANS,
    input logic [3:0] 		    HPROT,
    input logic [ADDRESSWIDTH-1:0]  HADDR,
    input logic [DATAWIDTH-1:0]     HWDATA,
    input logic 		    HWRITE,
    output logic 		    HREADYOUT,
    input logic 		    HSEL 
   
    );

   logic [ADDRESSWIDTH-1:0]  haddr_reg; //need to register the haddr
   logic [ADDRESSWIDTH-1:0]  HBURST_length, hburst_length_reg, count, nextcount;
   logic 		     burst_flag;
   logic 		     fifo_empty;
   logic [FIFODEPTH_LOG-1:0] fifo_used;
   logic 		     read_fifo;
   logic 		     wrreq;
   logic [DATAWIDTH-1:0]     q_out;
   logic [ADDRESSWIDTH-1:0]  address_r;
   logic 		     control_fixed_location;
   logic [ADDRESSWIDTH-1:0]  control_read_base;
   logic [ADDRESSWIDTH-1:0]  control_read_length;
   logic 		     control_go;
   logic 		     read_burst_received, read_burst_received_reg;
   logic [3:0] 		     burstcount_r;
   logic 		     write_hold;
   logic [1:0] 		     htrans_reg;
   

   typedef enum 	     {IDLE, WRITE, READ_REQ, READ_BURST} state_t;
   state_t state, nextState;

   //registers (use write_hold instead of waitrequest)
   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n)
	begin
	       haddr_reg <= 0;
	       hburst_length_reg <= 4;
	       state <= IDLE;
	       count <= 0;
	       read_burst_received_reg <= 0;
	       htrans_reg <= 0;
	end
      else
	begin
	       state <= nextState;
	       count <= nextcount;
	       hburst_length_reg <= HBURST_length;
	       read_burst_received_reg <= read_burst_received;
	       if (HREADYOUT) begin
	            htrans_reg <= HTRANS;
	       end
	   
               if (write_hold) begin
	            haddr_reg <= HADDR;
	       end
	end
   end

   //hburst decode
   always_comb begin
      HBURST_length = 4;
      burst_flag = 0;
      case (HBURST)
	3'b011: begin
	      HBURST_length = 16;
	      burst_flag = 1;
	end
	3'b101: begin
	      HBURST_length = 32;
	      burst_flag = 1;
	end
	3'b111: begin
	      HBURST_length = 64;
	      burst_flag = 1;
	end
	default: begin
	end
      endcase 
   end 

   //burst read logic
   assign read_burst_received = (~HWRITE) & (HTRANS == 2'b10) & burst_flag;
   
   //assign HRESP = {1'b0, response[1]};
   assign HRESP = 0;

   //bridge state machine next logic
   always_comb begin
      nextState = state;
      HREADYOUT = 1'b1;
      read_fifo = 1'b0;
      write = 1'b0;
      nextcount = count;

      control_fixed_location = 1'b0;
      control_read_base = 0;
      control_read_length = 4;
      control_go = 0;

      write_hold = 1'b1;
      
      case (state)
	IDLE: begin 
	   if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
	         if (HWRITE) begin
		     nextState = WRITE;
	         end
	         else begin
		     nextState = READ_REQ;
	         end
	   end
	end
	WRITE: begin
	   write = 1'b1;
	   if (!waitrequest) begin 
                 if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
		     if (!HWRITE) begin
		        nextState = READ_REQ;
		     end
	         end
	         else begin
		     nextState = IDLE;
	         end
	   end
	   else begin //if waitrequest in high, use hreadyout to stall the AHB master
	         HREADYOUT = 1'b0;
	         write_hold = 1'b0;
	   end
	end 
	READ_REQ: begin
	   HREADYOUT = 1'b0;
	   if (read_burst_received_reg) begin   //read burst of length more than 1 word
	          control_fixed_location = 1'b0;
	          control_read_base = haddr_reg;
	          control_read_length = hburst_length_reg;
	          control_go = 1;
	          nextState = READ_BURST;
	          nextcount = hburst_length_reg;
	   end
	   else begin
	          control_fixed_location = 1'b1;  //read burst of length of 1 word
	          control_read_base = haddr_reg;
	          control_read_length = 4;
	          control_go = 1;
	          nextState = READ_BURST;
	          nextcount = 4;
	   end
	end
	READ_BURST: begin
	   if ((htrans_reg == 2'b10) || (htrans_reg == 2'b11)) begin  //no need to do anything in the data phase of a BUSY state
                 if (~fifo_empty) begin
		     read_fifo = 1'b1;
		     nextcount = count - 4;
		     if (count == 4) begin  //indicates this is the last transfer
		             if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
		                 if (HWRITE) begin
			              nextState = WRITE;
		                 end
		                 else begin
			              nextState = READ_REQ;
		                 end
		             end
		             else begin
		                 nextState = IDLE;
		             end 
		     end
	         end 
	         else begin
		     HREADYOUT = 1'b0;
	         end
	   end
	end 
      endcase
   end

   assign HRDATA = q_out;
   
   assign wrreq = readdatavalid;

   //address mux
   assign address = (state == WRITE) ? haddr_reg : address_r;

   //burstcount mux
   assign burstcount = (state == READ_BURST) ? burstcount_r : 1;
   
   assign writedata = HWDATA;

/*   latency_aware_read_master latency_r_master (
					       .clk(clk),
					       .reset_n(reset_n),
					       .control_fixed_location(control_fixed_location),
					       .control_read_base(control_read_base),
					       .control_read_length(control_read_length),
					       .control_go(control_go),
					       .control_done(),
					       .master_address(address_r),
					       .master_read(read),
					       .master_waitrequest(waitrequest),
					       .master_readdatavalid(readdatavalid),
					       .fifo_used(fifo_used)
					       );*/

   //instantiate the Altera IP
   burst_read_master # (
			.DATAWIDTH(DATAWIDTH),
			.ADDRESSWIDTH(ADDRESSWIDTH),
			.FIFODEPTH(FIFODEPTH),
			.FIFODEPTH_LOG2(FIFODEPTH_LOG),
			.MAXBURSTCOUNT(MAXBURSTCOUNT)
			) burst_r_master (
					  .clk(clk),
					  .reset(~reset_n),
					  .control_fixed_location(control_fixed_location),
					  .control_read_base(control_read_base),
					  .control_read_length(control_read_length),
					  .control_go(control_go),
					  .control_done(),
					  .master_address(address_r),
					  .master_read(read),
					  .master_byteenable(byteenable),
					  .master_burstcount(burstcount_r),
					  .master_waitrequest(waitrequest),
					  .master_readdatavalid(readdatavalid),
					  .fifo_used(fifo_used)
					  );
   
      
   
   fifo_r # (
	     .DATAWIDTH(DATAWIDTH),
	     .FIFO_DEPTH(FIFODEPTH),
	     .FIFO_DEPTH_LOG2(FIFODEPTH_LOG)
	     )fifo (
		    .rdclk(clk),
		    .wrclk(clk),
		    .aclr (~reset_n),
		    .data (readdata),
		    .rdempty (fifo_empty),
		    .wrusedw(fifo_used),
		    .q (q_out),
		    .rdreq (read_fifo),
		    .wrreq (wrreq)
		    );

endmodule
