`timescale 1ns/1ps

module tb_sequencedetector_1101;
  reg clk;
  reg rst;
  reg in;
  wire out;

  sequencedetector_1101 dut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
  );

  always begin
    #5 clk = ~clk;
  end

  task send_bit(input logic bit_val);
    begin
      @(posedge clk);
      #1;
      in = bit_val;
    end
  endtask

  initial begin
    clk = 0;
    rst = 1;
    in = 0;

    repeat (2) @(posedge clk);
    #1 rst = 0;
    $display("Reset Released. Starting Tests");

    $display("Testing Non-matching sequence: 101010");
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(0);
    send_bit(1);
    send_bit(0);
    
    @(posedge clk);
    #1;
    if (out !== 0) $error("ERROR: False detection during non-matching sequence!");
    $display("Testing standard sequence: 1101");
    send_bit(1);
    send_bit(1);
    send_bit(0);
    send_bit(1); 
    #2;
    if (out === 1'b1) begin
      $display("SUCCESS: '1101' detected successfully!");
    end else begin
      $error("ERROR: Failed to detect '1101'!");
    end

    $display("Testing overlapping sequence: 1101101");
    send_bit(1);
    send_bit(0);
    send_bit(1);
    if (out === 1'b1) begin
      $display("SUCCESS: Overlapping sequence '1101101' detected successfully!");
    end else begin
      $error("ERROR: Failed to detect overlapping sequence!");
    end

    repeat (5) @(posedge clk);
    $display("Testbench Completed");
    $finish;
  end

  initial begin
    $monitor("Time=%0t | rst=%b | in=%b | State=%b | out=%b", $time, rst, in, dut.state, out);
    
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule