import switch_pkg::*;
// Top level testbench module to instantiate design, interface
// start clocks and run the test
module top;
  reg clk;
  int clk_cnt_between_rsts, cycles_waiting_rst, cycles_in_rst;
  
  always #10 clk =~ clk;
  switch_if 	_if (clk);
  switch u0 ( 	.clk(clk),
             .rstn(_if.rstn),
             .addr(_if.addr),
             .data(_if.data),
             .vld (_if.vld),
             .addr_a(_if.addr_a),
             .data_a(_if.data_a),
             .addr_b(_if.addr_b),
             .data_b(_if.data_b));
  test t0;
  
  initial begin
    clk_cnt_between_rsts <= 0;
    cycles_waiting_rst <= 0;
    cycles_in_rst <= 0;

    // Apply a initial reset
    _if.rstn <= 0;
    #20;
    _if.rstn <= 1;

    // Possibility of adding phase to the reset
    // (Asynchronous reset)
    forever begin
      clk_cnt_between_rsts = $urandom_range(5, 15);
      cycles_waiting_rst = $urandom_range(0, 19);
      cycles_in_rst = $urandom_range(1, 2);

      #(clk_cnt_between_rsts*20);
      #(cycles_waiting_rst);
      _if.rstn <= 0;
      #(cycles_in_rst*20);
      _if.rstn <= 1;
    end
  end

  initial begin
    clk <= 1;
    
    // Start the test
    t0 = new;
    t0.e0.vif = _if;
    t0.run();
    
    // Because multiple components and clock are running
    // in the background, we need to call $finish explicitly
    #50 $finish;
  end
  
  // System tasks to dump VCD waveform file
  initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
  end
endmodule