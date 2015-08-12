//Author: Nianpei Deng
//avalon to ahb bridge module

module avalon_ahb_bridge
  #(
    parameter AVALON_ADDRESSWIDTH = 5,  //needs to reflect the number of registers in the slave this bridge is connected to. For example, its value is set to 5 for 32 registers.
    parameter ADDRESSWIDTH = 32,
    parameter DATAWIDTH = 32
    )
   (
    //avalon slave side
    input logic 			  clk,
    input logic 			  reset_n,
    input logic [AVALON_ADDRESSWIDTH-1:0] address,
    input logic 			  write,
    input logic 			  read,
    input logic [DATAWIDTH-1:0] 	  writedata,
    output logic 			  waitrequest,
    output logic 			  readdatavalid,
    output logic [DATAWIDTH-1:0] 	  readdata,

    //ahb master side
    input logic [DATAWIDTH-1:0] 	  HRDATA,
    input logic 			  HREADY,
    input logic [1:0] 			  HRESP,
    output logic [2:0] 			  HBURST,
    output logic [2:0] 			  HSIZE,
    output logic [1:0] 			  HTRANS,
    output logic 			  HSEL,
    output logic [3:0] 			  HPROT,
    output logic [ADDRESSWIDTH-1:0] 	  HADDR,
    output logic [DATAWIDTH-1:0] 	  HWDATA,
    output logic 			  HWRITE,
    output logic 			  HREADYIN //hreadyin is tied to the hready signal with only one slave
   
    );

   logic [DATAWIDTH-1:0] hwdata_reg;
   typedef enum {IDLE, READ_DATA} state_t;
   state_t state, nextState;
   logic [ADDRESSWIDTH-1:0] 	byte_address; 
   //since avalon interconnect will translate master byte address to slave word address, here translate the word
   //address back to byte address for AHB bus
   assign byte_address = address << 2;

   always_ff @ (posedge clk, negedge reset_n) begin
      if (!reset_n)
	begin
	      hwdata_reg <= 0;
              state <= IDLE;
	end
      else
	begin
	      if (HREADY) begin
	            hwdata_reg <= writedata; //register the writedata since AHB bus requires it to be after address cycle
	      end
              state <= nextState;
	end
   end

   //state machine
   always_comb begin
      
      nextState = state;
      readdatavalid = 1'b0;
      
      case (state)
	   IDLE: begin
	       if (read) begin
	           if (HREADY) begin
		       nextState = READ_DATA;
	           end
	       end
	   end
  	   READ_DATA: begin //for AHB slave, read-data may be avalible only after address phase, here readdatavalid is used to signal the completion of read phase
	       readdatavalid = HREADY;
	       if (HREADY) begin
	           if (!read) begin
		      nextState = IDLE;
	           end
	       end
	   end
      endcase
   end
   
   assign readdata = HRDATA;
   
   assign HADDR = byte_address;
   
   assign HWRITE = write;
   
   assign HTRANS = (write | read) ? 2'b10 : 2'b00;
   
   assign waitrequest = (~HREADY);
   
   assign HWDATA = hwdata_reg;
   
   assign HREADYIN = HREADY;
   
   assign HSEL = 1'b1;    //for one slave, hsel will always be high
   assign HSIZE = 2'b10;  //if your Avalon master requests non-32 bits data transfers, change here. 
   
endmodule
