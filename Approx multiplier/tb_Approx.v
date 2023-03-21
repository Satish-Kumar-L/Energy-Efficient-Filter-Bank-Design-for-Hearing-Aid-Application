// Code your testbench here
// or browse Examples
module tb();
  reg [7:0] A,B;
  wire [15:0] out;

   unsignedApproxMult X( A,B,out);
  
  initial begin
    A = 125; B = 69;
    #5 A = 75; B = 51;
    #5 A = 210; B = 208;
    
    #5  $finish;
  end
  initial 
    $monitor("%d",out);
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule