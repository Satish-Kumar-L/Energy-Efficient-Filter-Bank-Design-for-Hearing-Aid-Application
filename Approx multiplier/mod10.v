module counter(clk,load,shift,count,in,out);
  input clk,shift,count;
  input [3:0] in;
  input load;
  output [3:0]out;
  reg [3:0] J,K;

  wire [3:0] j,k,Q;
  assign j = J;
  assign k = K;
  assign out = Q;
  JK F0(clk,J[0],K[0],Q[0]);
  JK F1(clk,J[1],K[1],Q[1]);
  JK F2(clk,J[2],K[2],Q[2]);
  JK F3(clk,J[3],K[3],Q[3]);
  always@(posedge clk) begin
    if(count == 1)
    begin
        if(Q == 0) begin J[0] <= 1; K[0] <= 0; J[1] <= 0; K[1] <= 1;J[2] <= 0; K[2] <= 1;J[3] <= 0; K[3] <= 1; end
        else if(Q == 1) begin J[0] <= 0; K[0] <= 1; J[1] <= 1; K[1] <= 0;J[2] <= 0; K[2] <= 1;J[3] <= 0; K[3] <= 1; end
        else if(Q == 2) begin J[0] <= 1; K[0] <= 0; J[1] <= 1; K[1] <= 0;J[2] <= 0; K[2] <= 1;J[3] <= 0; K[3] <= 1; end
        else if(Q == 3) begin J[0] <= 0; K[0] <= 1; J[1] <= 0; K[1] <= 1;J[2] <= 1; K[2] <= 0;J[3] <= 0; K[3] <= 1; end
        else if(Q == 4) begin J[0] <= 1; K[0] <= 0; J[1] <= 0; K[1] <= 1;J[2] <= 1; K[2] <= 0;J[3] <= 0; K[3] <= 1; end
        else if(Q == 5) begin J[0] <= 0; K[0] <= 1; J[1] <= 1; K[1] <= 0;J[2] <= 1; K[2] <= 0;J[3] <= 0; K[3] <= 1; end
        else if(Q == 6) begin J[0] <= 1; K[0] <= 0; J[1] <= 1; K[1] <= 0;J[2] <= 1; K[2] <= 0;J[3] <= 0; K[3] <= 1; end
        else if(Q == 7) begin J[0] <= 0; K[0] <= 1; J[1] <= 0; K[1] <= 1;J[2] <= 0; K[2] <= 1;J[3] <= 1; K[3] <= 0; end
        else if(Q == 8) begin J[0] <= 1; K[0] <= 0; J[1] <= 0; K[1] <= 1;J[2] <= 0; K[2] <= 1;J[3] <= 1; K[3] <= 0; end
        else if(Q == 9) begin J[0] <= 0; K[0] <= 1; J[1] <= 0; K[1] <= 1;J[2] <= 0; K[2] <= 1;J[3] <= 0; K[3] <= 1; end
        else  begin J[0] <= 0; K[0] <= 1; J[1] <= 0; K[1] <= 1;J[2] <= 0; K[2] <= 1;J[3] <= 0; K[3] <= 1; end
        end
    else if(count != 1 && shift == 1)
    begin
        J[0] <= Q[3]; K[0] <= ~Q[3]; 
        J[1] <= Q[0]; K[1] <= ~Q[0];
        J[2] <= Q[1]; K[2] <= ~Q[1];
        J[3] <= Q[2]; K[3] <= ~Q[2]; 
    end
    else if(count != 1 && load == 1)
    begin
        J[0] <= in[0]; K[0] <= ~in[0]; 
        J[1] <= in[1]; K[1] <= ~in[1];
        J[2] <= in[2]; K[2] <= ~in[2];
        J[3] <= in[3]; K[3] <= ~in[3]; 
    end
    else
    begin
        J <= 0; K <=0;
    end

    
    
  end
endmodule

module JK(clk,J,K,q);
input clk,J,K;
output reg q;
always @ (posedge clk)  
      case ({J,K})  
         2'b00 :  q <= q;  
         2'b01 :  q <= 0;  
         2'b10 :  q <= 1;  
         2'b11 :  q <= ~q;  
      endcase  
endmodule