//Author: Nianpei Deng
//ahb to avalon bridge module

module ahb_avalon_bridge
(
 //avalon master side
  //chipselect is omitted since only one slave connected to the bridge
 input logic 	     clk,
 input logic 	     reset_n,
 output logic [31:0] address,
 output logic 	     write,
 output logic 	     read,
 output logic [31:0] writedata,
 input logic 	     waitrequest,
 input logic 	     readdatavalid,
 input logic [31:0]  readdata,
 input logic [1:0]   response,

 //ahb slave side
 output logic [31:0] HRDATA,
 input logic 	     HREADY,
 output logic [1:0]  HRESP,
 input logic [2:0]   HBURST,
 input logic [2:0]   HSIZE,
 input logic [1:0]   HTRANS,
 input logic [3:0]   HPROT,
 input logic [31:0]  HADDR,
 input logic [31:0]  HWDATA,
 input logic 	     HWRITE,
 output logic 	     HREADYOUT,
 input logic 	     HSEL 
 
 );

   logic [31:0] haddr_reg; //need to register the haddr

   typedef enum {IDLE, WRITE, READ, READ_STALL} state_t;
   state_t state, nextState;

   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n)
	begin
	   haddr_reg <= 32'h0;
	   state <= IDLE;
	end
      else
	begin
	   state <= nextState;
	   if (!waitrequest) //can send a new transaction only after waitrequest is deasserted
	     begin
	        haddr_reg <= HADDR;
	     end
	end
   end
    //here note that the address as well as write-data or read-data should be in the same bus cycle for the Avalon bus
   assign writedata = HWDATA;
   assign HRDATA = readdata;
   assign address = haddr_reg;
   assign HRESP = {1'b0, response[1]};

   //bridge next state logic
   always_comb begin
      nextState = state;
      HREADYOUT = 1'b1;
      case (state)
	IDLE: begin //only recognize the non-sequential transactions here
	   if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
	      if (HWRITE) begin
		 nextState = WRITE;
	      end
	      else begin
		 nextState = READ;
	      end
	   end
	end
	WRITE: begin
	   if (!waitrequest) begin //send new transaction only after waitrequest is deasserted
              if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
		 if (!HWRITE) begin
		    nextState = READ;
		 end
	      end
	      else begin
		 nextState = IDLE;
	      end
	   end
	   else begin //if waitrequest in high, use hreadyout to stall the AHB master
	      HREADYOUT = 1'b0;
	   end
	end
	READ: begin //for read operations in avalon bus, there will be two independent response signals of slave (readdatavalid, waitrequest)
	   if (readdatavalid) begin //allow AHB master to start a new transaction only after the read phase is complete
	      if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
		 if (HWRITE) begin
		    nextState = WRITE;
		 end
	      end
	      else begin
		 nextState = IDLE;
	      end
	   end
	   else begin
	      HREADYOUT = 1'b0; //stall AHB master
	      if (!waitrequest) begin //here needs to deal with the waitrequest signal
		 nextState = READ_STALL;
	      end
	   end
	end
	READ_STALL: begin //if waitrequest is deasserted before readdatavalid signal, needs to also deassert the read signal of current read transaction
	   if (readdatavalid) begin
	      if (HSEL & ((HTRANS == 2'b10) | (HTRANS == 2'b11))) begin
		 if (HWRITE) begin
		    nextState = WRITE;
		 end
		 else begin
		    nextState = READ;
		 end
	      end
	      else begin
		 nextState = IDLE;
	      end
	   end
	   else begin
	      HREADYOUT = 1'b0;
	   end
	end
      endcase
   end

   //bridge output logic
   always_comb begin
      read = 1'b0;
      write = 1'b0;
      case (state)
	IDLE: begin
	end
	WRITE: begin
	   write = 1'b1;
	end
	READ: begin
	   read = 1'b1;
	end
      endcase
   end

endmodule
