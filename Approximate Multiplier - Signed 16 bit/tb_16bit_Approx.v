// Code your testbench here
// or browse Examples
module tb();
  reg signed [15:0] A,B;
  wire signed [31:0] out;

   signedApproxMult X( A,B,out);
  
  initial begin
    A = -12755; B = 32229;
    #5 A = 9975; B = -10051;
    #5 A = -2109; B = -208;
    
    #5  $finish;
  end
  initial 
    $monitor("%d",out);
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule