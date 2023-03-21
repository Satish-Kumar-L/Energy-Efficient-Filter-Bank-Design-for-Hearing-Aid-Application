// Code your testbench here
// or browse Examples
module tb();
  reg signed [7:0] A,B;
  wire signed [15:0] out;

   signedApproxMult X( A,B,out);
  
  initial begin
    A = 125; B = -69;
    #5 A = 75; B = -51;
    #5 A = -125; B = -101;
    
    #5  $finish;
  end
  initial 
    $monitor("%d",out);
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule