//---------------------------------------------------
// Macro definition
//---------------------------------------------------
`define NUM_MASTERS  1
`define NUM_SLAVES   1

`define TB       $root.tb.dut
`define SLAVE0    $root.tb.dut.u0.mm_slave_bfm_0
`define MASTER0    $root.tb.dut.u0.mm_master_bfm_0


module test_program ();

	import verbosity_pkg::*;
	import avalon_mm_pkg::*;


//------------------------------------------------------------------
// Constants 
//-----------------------------------------------------------------
	localparam ADDR_W                   = 32;
        localparam MEMORY_DEPTH		    = 32;    
	localparam SYMBOL_W                 = 8;
	localparam NUM_SYMBOLS              = 4;
	localparam DATA_W                   = NUM_SYMBOLS * SYMBOL_W;
            
	localparam BURST_W                  = 4;
	localparam MAX_BURST                = 1;
   
	localparam SLAVE_SPAN               = 32'h1000;
   
	localparam MAX_COMMAND_IDLE         = 5;
	localparam MAX_COMMAND_BACKPRESSURE = 2;
	localparam MAX_DATA_IDLE            = 3;
	
//------------------------------------------------------------------
// Data Structures 
//-----------------------------------------------------------------
	typedef logic [BURST_W-1:0]	Burstcount;
	typedef enum bit
	{
		WRITE = 0,
		READ = 1
	} Transaction;

	typedef enum bit
	{
		NOBURST = 0,
		BURST = 1
	} Burstmode;

	typedef struct 
	{
       		Transaction                  trans;
       		Burstcount                   burstcount;
		logic [ADDR_W-1: 0]          addr;
		logic [DATA_W-1:0][MAX_BURST-1:0]           data  ;
		logic [NUM_SYMBOLS-1:0]      byteenable [MAX_BURST-1:0];
		bit [31:0]                   cmd_delay;
		bit [31:0]                   data_idles [MAX_BURST-1:0];
	} Command;

	logic [MEMORY_DEPTH-1:0][31:0] memory;
	typedef struct
	{
		Burstcount                    burstcount;
		logic [DATA_W-1:0]            data     [MAX_BURST-1:0];
		bit [31:0]                    latency  [MAX_BURST-1:0];
	} Response;	Response rsp;
	

	Command cmd;
        Command master_cmd;

	   integer j, delay;

        logic [ADDR_W-1:0] addrv;
        logic [DATA_W-1:0] datav;

//---------------------------------------------------
// Command and Response Queues
//---------------------------------------------------
// master command queue
Command  write_command_queue_master[`NUM_MASTERS][$];
Command  read_command_queue_master[`NUM_MASTERS][$];

// slave command queue
Command  write_command_queue_slave[`NUM_SLAVES][$];
Command  read_command_queue_slave[`NUM_SLAVES][$];

// slave response queue
Response read_response_queue_slave[`NUM_SLAVES][$];


//---------------------------------------------------
// Macro Definitions
//---------------------------------------------------
`define MACRO_CONFIGURE_AND_PUSH_COMMAND_TO_MASTER(MASTER_ID) \
   task automatic configure_and_push_command_to_master_``MASTER_ID ( \
      Command  cmd \
   ); \
      `MASTER``MASTER_ID.set_command_address(cmd.addr); \
      `MASTER``MASTER_ID.set_command_burst_count(cmd.burstcount); \
      `MASTER``MASTER_ID.set_command_burst_size(cmd.burstcount); \
      `MASTER``MASTER_ID.set_command_init_latency(cmd.cmd_delay); \
\
      if (cmd.trans == WRITE) begin \
         `MASTER``MASTER_ID.set_command_request(REQ_WRITE); \
         for (int i = 0; i < cmd.burstcount; i++) begin \
            `MASTER``MASTER_ID.set_command_data(cmd.data[i], i); \
            `MASTER``MASTER_ID.set_command_byte_enable(cmd.byteenable[i], i); \
            `MASTER``MASTER_ID.set_command_idle(cmd.data_idles[i], i); \
         end \
      end else begin \
         `MASTER``MASTER_ID.set_command_request(REQ_READ); \
         `MASTER``MASTER_ID.set_command_idle(cmd.data_idles[0], 0); \
      end \
\
      `MASTER``MASTER_ID.push_command(); \
   endtask

// Get command received by slave, verify command.
// If command is read command, send out response
`define MACRO_SLAVE_THREAD(SLAVE_ID) \
   always @(`SLAVE``SLAVE_ID.signal_command_received) begin \
\
      Command     actual_cmd, exp_cmd; \
      Response    rsp; \
\
      automatic int backpressure_cycles; \
\
      // set random backpressure cycles for next command \
      for (int i = 0; i < MAX_BURST; i++) begin \
         backpressure_cycles = $urandom_range(0, MAX_COMMAND_BACKPRESSURE); \
         `SLAVE``SLAVE_ID.set_interface_wait_time(backpressure_cycles, i); \
      end \
\
      actual_cmd = get_command_from_slave_``SLAVE_ID(); \
      exp_cmd = get_expected_command_for_slave(actual_cmd, ``SLAVE_ID); \
      verify_command(actual_cmd, exp_cmd); \
\
      // set read response \
      if (actual_cmd.trans == READ) begin \
         rsp = create_response(actual_cmd.burstcount); \
         configure_and_push_response_to_slave_``SLAVE_ID(rsp); \
         read_response_queue_slave[``SLAVE_ID].push_back(rsp); \
      end \
   end
   
`define MACRO_GET_COMMAND_FROM_SLAVE(SLAVE_ID) \
   function automatic Command get_command_from_slave_``SLAVE_ID (); \
\
      Command cmd; \
\
      `SLAVE``SLAVE_ID.pop_command(); \
      cmd.burstcount          = `SLAVE``SLAVE_ID.get_command_burst_count(); \
      cmd.addr                = `SLAVE``SLAVE_ID.get_command_address(); \
\
      if (`SLAVE``SLAVE_ID.get_command_request() == REQ_WRITE) begin \
         cmd.trans = WRITE; \
         for(int i = 0; i < cmd.burstcount; i++) begin \
            cmd.data[i]       =`SLAVE``SLAVE_ID.get_command_data(i); \
            cmd.byteenable[i] =`SLAVE``SLAVE_ID.get_command_byte_enable(i); \
         end \
      end else begin \
         cmd.trans = READ; \
      end \
\
      return cmd; \
   endfunction
   
`define MACRO_PENDING_READ_CYCLES(SLAVE_ID) \
   int pending_read_cycles_slave_``SLAVE_ID = 0; \
   always @(posedge `TB.clk_clk) begin \
      if (pending_read_cycles_slave_``SLAVE_ID > 0) begin \
         pending_read_cycles_slave_``SLAVE_ID--; \
      end \
   end

`define MACRO_CONFIGURE_AND_PUSH_RESPONSE_TO_SLAVE(SLAVE_ID) \
task automatic configure_and_push_response_to_slave_``SLAVE_ID ( \
      Response rsp \
   ); \
\
      int read_response_latency; \
\
      `SLAVE``SLAVE_ID.set_response_request(REQ_READ); \
      `SLAVE``SLAVE_ID.set_response_burst_size(rsp.burstcount); \
      for (int i = 0; i < rsp.burstcount; i++) begin \
         `SLAVE``SLAVE_ID.set_response_data(rsp.data[i], i); \
\
         if (i == 0) begin \
            `SLAVE``SLAVE_ID.set_response_latency(rsp.latency[i] + pending_read_cycles_slave_``SLAVE_ID, i); \
            read_response_latency = rsp.latency[i]; \
         end else begin \
            `SLAVE``SLAVE_ID.set_response_latency(rsp.latency[i], i); \
            read_response_latency = rsp.latency[i] + read_response_latency; \
         end \
\
      end \
      `SLAVE``SLAVE_ID.push_response(); \
      pending_read_cycles_slave_``SLAVE_ID = pending_read_cycles_slave_``SLAVE_ID + read_response_latency + rsp.burstcount + 2; \
   endtask

`define MACRO_MASTER_RESPONSE_THREAD(MASTER_ID) \
   // Get read response received by master and verify read response \
   always @(`MASTER``MASTER_ID.signal_read_response_complete) begin \
\
      Command  cmd; \
      Response actual_rsp, exp_rsp; \
\
      cmd = read_command_queue_master[``MASTER_ID].pop_front(); \
      actual_rsp = get_read_response_from_master_``MASTER_ID(); \
      exp_rsp = get_expected_read_response(cmd); \
      verify_response(actual_rsp, exp_rsp); \
   end \
\
   // Flush out response for write command created by master bfm \
   always @(`MASTER``MASTER_ID.signal_write_response_complete) begin \
      `MASTER``MASTER_ID.pop_response(); \
   end

`define MACRO_GET_READ_RESPONSE_FROM_MASTER(MASTER_ID) \
   function automatic Response get_read_response_from_master_``MASTER_ID (); \
\
      Response rsp; \
\
      `MASTER``MASTER_ID.pop_response(); \
      rsp.burstcount    = `MASTER``MASTER_ID.get_response_burst_size(); \
      for (int i = 0; i < rsp.burstcount; i++) begin \
         rsp.data[i]    = `MASTER``MASTER_ID.get_response_data(i); \
      end \
\
      return rsp; \
   endfunction

//---------------------------------------------------
// Macro Instantiations
//---------------------------------------------------
// master 0
//`MACRO_CONFIGURE_AND_PUSH_COMMAND_TO_MASTER(0)
//`MACRO_MASTER_RESPONSE_THREAD(0)
//`MACRO_GET_READ_RESPONSE_FROM_MASTER(0)

//---------------------------------------------------
// Test status checking
//---------------------------------------------------
bit test_success = 1;

//---------------------------------------------------
// Events
//---------------------------------------------------
event assert_fail;

   //slave bfm thread

	always @ (`SLAVE0.signal_command_received) begin
		$display("command received signalled");
		//get command data
		`SLAVE0.pop_command();
		cmd.burstcount = `SLAVE0.get_command_burst_count();
		cmd.addr = `SLAVE0.get_command_address();
	        cmd.data = `SLAVE0.get_command_data(0);
		if (`SLAVE0.get_command_request() == REQ_WRITE) begin
			cmd.trans = WRITE;
		end else begin
			cmd.trans = READ;
		end
		// create response for read---

	//   `SLAVE0.set_interface_wait_time(1,0);

	   j = 0;
	   
	   if (cmd.trans == READ) begin
	      $display("slave cmd was a read: (burscount, address, data) => (%x, %x, %x)", cmd.burstcount, cmd.addr, memory[cmd.addr]);
	      if (j == 0) begin
		 delay = 5;
	      end
	      else begin
		 delay = 1;
	      end
	      j = j + 1;
	      
	      `SLAVE0.set_interface_wait_time(0,0);
	      `SLAVE0.set_response_request(REQ_READ);
	      `SLAVE0.set_response_burst_size(cmd.burstcount);
	      `SLAVE0.set_response_data(memory[cmd.addr], 0);
	      `SLAVE0.set_response_latency(0, 0);
	      `SLAVE0.push_response();
	   end else begin
	      $display("slave cmd was a write: (burstcount, address, data) => (%x, %x, %x)", cmd.burstcount, cmd.addr, cmd.data);
	      `SLAVE0.set_interface_wait_time(0,0);
	      `SLAVE0.set_response_request(REQ_WRITE);
	      `SLAVE0.set_response_burst_size(1);
	      memory[cmd.addr] = cmd.data;
	   end
	end // always @ (`SLAVE.signal_command_received)


   //bfm master send the start byte write command
   initial begin

      set_verbosity(VERBOSITY_INFO);
      wait (`TB.reset_n == 1);
      repeat(10) @(posedge `TB.clock);
      
      
      $display("master send out write command: address 8");
      `MASTER0.set_command_address(8); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE); 
      `MASTER0.set_command_data(32'h1111F000, 0); 
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command();
      
      //repeat(1)@(posedge `TB.clock);
      $display("master send out write command: address 12");
      `MASTER0.set_command_address(12); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE); 
      `MASTER0.set_command_data(32'h2222F000, 0); 
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command();    

      //repeat(1)@(posedge `TB.clock);
      $display("master send out write command: address 16");
      `MASTER0.set_command_address(16); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE); 
      `MASTER0.set_command_data(32'h3333F000, 0); 
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command();     

       //repeat(1)@(posedge `TB.clock);
      $display("master send out write command: address 20");
      `MASTER0.set_command_address(20); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE); 
      `MASTER0.set_command_data(32'h4444F000, 0); 
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command(); 

      $display("master send out write command: address 24");
      `MASTER0.set_command_address(24); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE);
      `MASTER0.set_command_data(32'h5555F000, 0);
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command();

      $display("master send out write command: address 28");
      `MASTER0.set_command_address(28); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE);
      `MASTER0.set_command_data(32'h6666F000, 0);
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command();

      repeat(10)@(posedge `TB.clock);

      $display("master send out start_run write command: address 0");
      `MASTER0.set_command_address(0); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE);
      `MASTER0.set_command_data(32'hF00BF00B, 0);
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command(); 

      repeat(40)@(posedge `TB.clock);

      $display("master send out stOP_run write command: address 0");
      `MASTER0.set_command_address(0); 
      `MASTER0.set_command_burst_count(1); 
      `MASTER0.set_command_burst_size(1); 
      `MASTER0.set_command_init_latency(0); 
      `MASTER0.set_command_request(REQ_WRITE);
      `MASTER0.set_command_data(32'hDEADF00B, 0);
      `MASTER0.set_command_byte_enable({4{1'b1}}, 0); 
      `MASTER0.set_command_idle(0, 0);
      `MASTER0.push_command(); 
      
      $display("Master has sent out all command");
   end // initial begin
   
      
 
   
   task automatic verify_command (
      Command actual_cmd, exp_cmd
   );
   
      assert_equals("wrong address", exp_cmd.addr, actual_cmd.addr);
      assert_equals("wrong burstcount", exp_cmd.burstcount, actual_cmd.burstcount);
      
      if (actual_cmd.trans == WRITE) begin
         for (int i = 0; i < actual_cmd.burstcount; i++) begin
            assert_equals("wrong write data", exp_cmd.data[i], actual_cmd.data[i]);
            assert_equals("wrong byteenable", exp_cmd.byteenable[i], actual_cmd.byteenable[i]);
         end
      end
   
   endtask
   
   task automatic assert_equals(
      string message,
      logic [1023:0] expected_obj,
      logic [1023:0] actual_obj
   );
      string data_comparison_msg;

      begin
         if (actual_obj == expected_obj) begin
         // Success case.  Code it this way because in Verilog, 
         //   1) "!=" and "==" give 'x' if either operand contains 'x' or 'z'
         //   2) 'x' evaluated as a boolean is false
         end else begin
            $sformat(data_comparison_msg, "%s, expected %0x got %0x",
               message,
               expected_obj,
               actual_obj);
            print(VERBOSITY_ERROR, data_comparison_msg);
            test_success = 0;                
            -> assert_fail;
         end
      end
   endtask
   
   
   task automatic verify_response (
      Response actual_rsp, exp_rsp
   );
      
      assert_equals("wrong burstcount", exp_rsp.burstcount, actual_rsp.burstcount);
      for (int i = 0; i < actual_rsp.burstcount; i++) begin
         assert_equals("wrong read data", exp_rsp.data[i], actual_rsp.data[i]);
      end
      
   endtask

endmodule
