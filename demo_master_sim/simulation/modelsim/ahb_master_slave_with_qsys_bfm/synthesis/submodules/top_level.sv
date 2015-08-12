//

module top_level
  (
    //AHB slave interface signals.
    input logic 	HCLK,
    input logic 	HRESETn,
    input logic [31:0] 	slave_HADDR,
    input logic [ 2:0] 	slave_HBURST,
    input logic [ 3:0] 	slave_HPROT,
    input logic [ 2:0] 	slave_HSIZE,
    input logic [ 1:0] 	slave_HTRANS,
    input logic [31:0] 	slave_HWDATA,
    input logic 	slave_HWRITE,
    output logic [31:0] slave_HRDATA,
    output logic 	slave_HREADYOUT,
    output logic [1:0] 	slave_HRESP,
    input logic 	slave_HSEL,
    input logic 	slave_HREADY,

    //AHB master interface signals

    output logic [31:0] master_HADDR,
    output logic [ 2:0] master_HBURST,
    output logic [ 3:0] master_HPROT,
    output logic [ 2:0] master_HSIZE,
    output logic [ 1:0] master_HTRANS,
    output logic [31:0] master_HWDATA,
    output logic 	master_HWRITE,
    input logic [31:0] 	master_HRDATA,
    input logic 	master_HREADY,
    input logic [1:0] 	master_HRESP,
    output logic 	master_HREADYIN,
    output logic 	master_HSEL,

    //top_level conduits
    input logic 	add_data_sel,
    input logic [15:0] 	rdwr_address,
    output logic [31:0] display_data
    
   );

   logic [31:0]    HADDR_W, HADDR_R;
   logic [ 2:0]    HSIZE_W, HSIZE_R;
   logic [2:0] 	   HBURST_R;
   logic [ 1:0]    HTRANS_W, HTRANS_R;
   logic           HWRITE_W, HWRITE_R;
   logic           HREADY_W, HREADY_R;
   logic [1:0]	   HRESP_W, HRESP_R;

   logic 	   start_run, stop_run;
   logic [31:0]    u_read_data;
   logic [31:0]    u_addr;
   logic 	   write_control_fixed_location;   
   logic [31:0]    write_control_write_base;   
   logic [31:0]    write_control_write_length;   
   logic 	   write_control_go;   
   logic 	   write_control_done;   
   logic [2:0] 	   write_data_size;  
   logic 	   write_user_write_buffer;   
   logic [31:0]    write_user_buffer_data;   
   logic 	   write_user_buffer_full;   
   logic 	   read_control_fixed_location;   
   logic [31:0]    read_control_read_base;   
   logic [31:0]    read_control_read_length;   
   logic 	   read_control_go;  
   logic 	   read_control_done;  
   logic [2:0] 	   read_data_size;   
   logic 	   read_user_read_buffer;   
   logic [31:0]    read_user_buffer_data;   
   logic 	   read_user_data_available;
   logic 	   r_fifo_enable;
   logic [31:0]    r_fifo_data;
   logic 	   r_fifo_empty;
   


   logic 	   w_enable;
   typedef enum    {WRITE, READ} state_t;
   state_t state;
   

   //Instantiate an AHB slave IP
   AHB_slave slave_1(
		     .clk (HCLK),
		     .reset_n    (HRESETn),
		     .HADDR      (slave_HADDR),
		     .HBURST     (),
		     .HPROT      (),
		     .HSIZE      (slave_HSIZE),
		     .HTRANS     (slave_HTRANS),
		     .HWDATA     (slave_HWDATA),
		     .HWRITE     (slave_HWRITE),
		     .HRDATA     (slave_HRDATA),
		     .HREADYOUT     (slave_HREADYOUT),
		     .HRESP      (slave_HRESP),
		     .u_addr (u_addr),
		     .u_read_data (u_read_data),
		     .r_fifo_read_enable(r_fifo_enable),
		     .r_fifo_read_data(r_fifo_data),
		     .r_fifo_empty(r_fifo_empty),
		     .u_write (),
		     .u_write_data (),
		     .HSEL       (1'b1)
		     //.HREADY  (HREADY)
		     );
   

   // Instantiate both AHB read and write master IPs
   AHB_read_master custom_1 (
			     .clk        (HCLK),
			     .reset_n    (HRESETn),
			     .HADDR(HADDR_R),
			     .HBURST(HBURST_R),
			     .HPROT(),
			     .HSIZE(HSIZE_R),
			     .HTRANS(HTRANS_R),
			     .HWRITE(HWRITE_R),
			     .HRDATA(master_HRDATA),
			     .HREADY(HREADY_R),
			     .HRESP(HRESP_R),
			     .HSEL(master_HSEL),
			     .control_fixed_location(read_control_fixed_location),
			     .control_read_base(read_control_read_base),
			     .control_read_length(read_control_read_length),
			     .control_go(read_control_go),
			     .control_done(read_control_done),
			     .data_size(read_data_size),
			     .user_read_buffer(read_user_read_buffer),
			     .user_buffer_data(read_user_buffer_data),
			     .user_data_available(read_user_data_available)
			     );

   AHB_write_master custom_2 (
			      .clk        (HCLK),
			      .reset_n    (HRESETn),
			      .HADDR(HADDR_W),
			      .HBURST(),
			      .HPROT(),
			      .HSIZE(HSIZE_W),
			      .HTRANS(HTRANS_W),
			      .HWRITE(HWRITE_W),
			      .HWDATA(master_HWDATA),
			      .HREADY(HREADY_W),
			      .HRESP(HRESP_W),
			      .control_fixed_location(write_control_fixed_location),
			      .control_write_base(write_control_write_base),
			      .control_write_length(write_control_write_length),
			      .control_go(write_control_go),
			      .control_done(write_control_done),
			      .data_size(write_data_size),
			      .user_write_buffer(write_user_write_buffer),
			      .user_buffer_data(write_user_buffer_data),
			      .user_buffer_full(write_user_buffer_full)
			      );

   //instantiate demo user logic 
   user_logic inst_1 (
		      .clk(HCLK),
		      .reset_n(HRESETn),
		      .data(u_read_data),
		      .data_addr(u_addr),
		      .r_fifo_read_enable(r_fifo_enable),
		      .r_fifo_read_data(r_fifo_data),
		      .r_fifo_empty(r_fifo_empty),
		      .add_data_sel(add_data_sel),
		      .rdwr_address(rdwr_address),
		      .display_data(display_data),
		      .write_control_fixed_location(write_control_fixed_location),
		      .write_control_write_base(write_control_write_base),
		      .write_control_write_length(write_control_write_length),
		      .write_control_go(write_control_go),
		      .write_control_done(write_control_done),
		      .write_data_size(write_data_size),
		      .write_user_write_buffer(write_user_write_buffer),
		      .write_user_buffer_data(write_user_buffer_data),
		      .write_user_buffer_full(write_user_buffer_full),
		      .read_control_fixed_location(read_control_fixed_location),
		      .read_control_read_base(read_control_read_base),
		      .read_control_read_length(read_control_read_length),
		      .read_control_go(read_control_go),
		      .read_control_done(read_control_done),
		      .read_data_size(read_data_size),
		      .read_user_read_buffer(read_user_read_buffer),
		      .read_user_buffer_data(read_user_buffer_data),
		      .read_user_data_available(read_user_data_available)
		      );

   //master select state machine
   always_ff @ (posedge HCLK or negedge HRESETn)
     begin
	if (!HRESETn) begin
	   state <= WRITE;
	end
	else begin
	   case (state)
	     WRITE: begin
		if (read_control_go) begin
		   state <= READ;
		end
	     end
	     READ: begin
		if (write_control_go) begin
		   state <= WRITE;
		end
	     end
	   endcase 
	end 
     end 

   //master select logic
   assign w_enable = (state == WRITE);
   
   assign master_HADDR = w_enable ? HADDR_W : HADDR_R;
   assign master_HSIZE = w_enable ? HSIZE_W : HSIZE_R;
   assign master_HTRANS = w_enable ? HTRANS_W : HTRANS_R;
   assign master_HWRITE = w_enable ? HWRITE_W : HWRITE_R;
   assign HREADY_W = w_enable ? master_HREADY : 1'b1;
   assign HREADY_R = w_enable ? 1'b1 : master_HREADY;
   assign HRESP_W = w_enable ? master_HRESP : 1'b0;
   assign HRESP_R = w_enable ? 1'b0 : master_HRESP;
   assign master_HBURST = w_enable ? 0 : HBURST_R;

   

endmodule

