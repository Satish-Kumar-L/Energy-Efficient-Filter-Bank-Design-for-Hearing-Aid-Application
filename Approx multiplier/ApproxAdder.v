module unsignedApproxMult (
    A,B,Y
);
input [7:0] A,B;
output [15:0] Y;
reg [1:0] peA,peB;
wire [2:0] xs1A,xs1B;
wire selA,selB;

always @(*) begin
if(A[7] == 1) peA = 2'b11;
else if(A[6] == 1) peA = 2'b10;
else if(A[5] == 1) peA = 2'b01;
else if(A[4] == 1) peA = 2'b00;
else peA = 2'b00;
    
end

always @(*) begin
if(B[7] == 1) peB = 2'b11;
else if(B[6] == 1) peB = 2'b10;
else if(B[5] == 1) peB = 2'b01;
else if(B[4] == 1) peB = 2'b00;
else peB = 2'b00;
    
end

assign xs1A = peA + 1;
assign xs1B = peB + 1;

assign selA = A[7]|A[6]|A[5]|A[4];
assign selB = B[7]|B[6]|B[5]|B[4];

wire [2:0] shiftA, shiftB;
assign shiftA = selA?xs1A:3'b000;
assign shiftB = selB?xs1B:3'b000;

wire [7:0] Anew,Bnew;

assign Anew = (A>>shiftA);
assign Bnew = (B>>shiftB);

wire [7:0] Yuncorr;
assign Yuncorr = Anew[3:0] * Bnew[3:0];
assign Y = Yuncorr<<(shiftA+shiftB);
    
endmodule