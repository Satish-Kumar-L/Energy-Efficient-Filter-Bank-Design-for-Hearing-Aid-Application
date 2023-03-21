// Code your testbench here
// or browse Examples
module tb();
  reg clk,load,shift,count;
  wire [3:0] out;
  reg [3:0] in;
  counter C(clk,load,shift,count,in,out);
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    count = 1;
    in = 7;
    load = 0;
    shift = 0;
    #200 count = 0;
    load = 1;
    #20 shift = 1; #40 $finish;
  end
  initial 
    $monitor("%d %d",clk,out);
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule