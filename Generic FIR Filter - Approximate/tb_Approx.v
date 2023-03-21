



module tb;

    // Inputs
    reg Clk;
    reg reset;
    reg signed [15:0] Xin;
    integer f,f2,idx;

    // Outputs
    wire signed [31:0] Yout;
    integer i = 0;
   
    

    // Instantiate the Unit Under Test (UUT)
    GenericFIR uut (
       Clk,reset,Xin,Yout
    );
    
    //Generate a clock with 10 ns clock period.
    initial Clk = 0;
    initial reset = 0;
    initial Xin = 0;
    reg signed [15:0] inp [0:80];
    initial $readmemh("taps.hex", uut.tap);
    initial $readmemh("test.hex", inp);
    always #5 Clk =~Clk;
    
//Initialize and apply the inputs.
    initial begin
         #2 reset = 1;#20
          reset = 0;
          Xin = 0;  #20;

    forever begin
        #10 Xin = inp[i];
        i = i + 1;
        if (i == 80) begin
            $finish;
        end
        
    end /*
          Xin = 1; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0; #10;
          Xin = 0;  #10;
          Xin = 0;  #10;
          #400  $finish;*/

    end

    initial begin
    f = $fopen("output.txt","w");		
    f2 = $fopen("time.txt","w");	
    $dumpfile("dump.vcd"); 
    $dumpvars(0,tb);
    for (idx = 0; idx < 4; idx = idx + 1) begin
        $dumpvars(0, uut.sample[idx]);
        $dumpvars(0, uut.tap[idx]);
        $dumpvars(0, uut.product[idx]);
        $dumpvars(0, uut.acc[idx]);
        $dumpvars(0, inp[idx]);
    end
    
    
  end

  always@(posedge Clk)
  begin
    //$fwrite(f,"%d %d\n",Xin,Yout);
    $fwrite(f,"%d\n",Yout);
    //$display("%d\n",uut.tap[1]);
  end
      
endmodule