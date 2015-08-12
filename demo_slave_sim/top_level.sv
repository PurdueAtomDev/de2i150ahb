//top level test bench

`define OVL_ASSERT_ON
`timescale 1ns / 10ps

module top_level;
   

   // AHB signals.
   logic           HCLK;
   logic           HRESETn;
   logic [31:0]    HADDR;
   logic [ 2:0]    HBURST;
   logic [ 3:0]    HPROT;
   logic [ 2:0]    HSIZE;
   logic [ 1:0]    HTRANS;
   logic [31:0]    HWDATA;
   logic           HWRITE;
   logic [31:0]    HRDATA;
   logic           HREADYOUT;
   logic [1:0] 	   HRESP;
   logic           HBUSREQ;
   logic           HLOCK;
   logic           HGRANT;

   //user interface signals
   logic [31:0]    wdata;
   logic 	   wrreq;
   logic 	   wrfull;
   logic [31:0]    rdata;
   logic 	   rdack;
   logic 	   rdempty;
   logic [31:0]    u_read_data;
   logic [31:0]    u_write_data;
   logic [31:0]    u_addr;
   logic 	   u_write;



//Instantiate a master module
   ahb_frbm #(
	      .MASTER_NAME ("Master"),
	      .TIC_CMD_FILE ("burst_test.tic")
	      )master_1(
			.HCLK(HCLK),
			.HRESETn(HRESETn),
			.HADDR(HADDR),
			.HBURST(HBURST),
			.HPROT(HPROT),
			.HSIZE(HSIZE),
			.HTRANS(HTRANS),
			.HWDATA(HWDATA),
			.HWRITE(HWRITE),
			.HRDATA(HRDATA),
			.HREADY(HREADYOUT),
			.HRESP(HRESP),
			.HGRANT(HGRANT)
			);
   

// Instantiate an AHB slave IP.
   AHB_slave custom_1 (
		       .clk        (HCLK),
		       .reset_n    (HRESETn),
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
		       .HSEL(1'b1),
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
		      .clk(HCLK),
		      .reset_n(HRESETn),
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

   // Generate a clock.
   initial begin
      HCLK = 1'b1;
      forever #5ns HCLK = ~HCLK;
   end

   // System reset.
   initial begin
      HRESETn = 1'b0;
      #4ns HRESETn = 1'b1;
   end

   // Grant
   initial begin
      HGRANT = 1'b0;
      #40ns HGRANT = 1'b1;
   end


endmodule

