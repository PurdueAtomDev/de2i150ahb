//top level module to connect AHB slave interface to your user logic designs. The input/output signals of this module are pure AHB bus signals so that this module can be integrated in your Qsys design.

module top_level
  (
   input clk,
   input reset_n,
   //Bus Slave Interface
   input logic 		   HSEL,
   input logic [31:0]      HADDR,
   input logic 		   HWRITE,
   input logic [2:0] 	   HSIZE,
   input logic [2:0] 	   HBURST,
   input logic [3:0] 	   HPROT,
   input logic [1:0] 	   HTRANS,
   input logic 		   HREADY,
   input logic [31:0]      HWDATA,
   output logic 	   HREADYOUT,
   output logic [1:0]	   HRESP,
   output logic [31:0]     HRDATA
   );

   logic [31:0] 	 wdata;
   logic 		 wrreq;
   logic 		 wrfull;
   logic [31:0] 	 rdata;
   logic 		 rdack;
   logic 		 rdempty;
   logic [31:0] 	 u_read_data;
   logic [31:0] 	 u_write_data;
   logic [31:0] 	 u_addr;
   logic 		 u_write;

   // Instantiate an AHB_slave interface
   AHB_slave slave_1 (
		      .clk        (clk),
		      .reset_n    (reset_n),
		      .HSEL(HSEL),
		      .HADDR(HADDR),
		      .HBURST(HBURST),
		      .HPROT(HPROT),
		      .HSIZE(HSIZE),
		      .HTRANS(HTRANS),
		      .HWDATA(HWDATA),
		      .HWRITE(HWRITE),
		      .HRDATA(HRDATA),
		      .HREADYOUT(HREADYOUT),
		      .HRESP(HRESP),
		      .HREADY(), //not used in current AHB slave design
		      .w_fifo_write_enable(wrreq),
		      .w_fifo_write_data(wdata),
		      .w_fifo_full(wrfull),
		      .r_fifo_read_enable(rdack),
		      .r_fifo_read_data(rdata),
		      .r_fifo_empty(rdempty),
		      .u_addr(u_addr),
		      .u_read_data(u_read_data),
		      .u_write(u_write),
		      .u_write_data(u_write_data)
		      );
   //Instantiate demo user logic
   user_logic inst_1 (
		      .clk(clk),
		      .reset_n(reset_n),
		      .wrreq(wrreq),
		      .wdata(wdata),
		      .wrfull(wrfull),
		      .rdack(rdack),
		      .rdata(rdata),
		      .rdempty(rdempty),
		      .u_write(u_write),
		      .u_addr(u_addr),
		      .u_wdata(u_write_data),
		      .u_data(u_read_data)
		      );


endmodule

