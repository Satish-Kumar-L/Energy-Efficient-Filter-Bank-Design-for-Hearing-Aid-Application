module signedApproxMult (
    A,B,Y
);
input signed [15:0] A,B;
output signed [31:0] Y;
wire signed [15:0] Anew,Bnew;
wire signed [31:0] Ynew;

twoComplement16bit Ab(A,Anew);
twoComplement16bit Ac(B,Bnew);
unsignedApproxMult16bit Ad(Anew,Bnew,Ynew);
twoComplement32bit Ae(A[15],B[15],Ynew,Y);

    
endmodule

module twoComplement16bit (A,Y);
input signed [15:0] A;
output reg signed [15:0] Y;
always @(*) begin
    if (A[15]==1) begin
        Y <= ~A + 1;
    end
    else Y<=A;
    
end
endmodule

module twoComplement32bit (M,N,A,Y);
input signed [31:0] A;
input M,N;
output reg signed [31:0] Y;
always @(*) begin
    if (M^N) begin
        Y <= ~A + 1;
    end
    else Y<=A;
    
end
endmodule

module unsignedApproxMult16bit (
    A,B,Y
);
input [15:0] A,B;
output [31:0] Y;
reg [2:0] peA,peB;
wire [3:0] xs1A,xs1B;
wire selA,selB;

// N/2 bit priority encoder stage

always @(*) begin
if(A[15] == 1) peA = 3'b111;
else if(A[14] == 1) peA = 3'b110;
else if(A[13] == 1) peA = 3'b101;
else if(A[12] == 1) peA = 3'b100;
else if(A[11] == 1) peA = 3'b011;
else if(A[10] == 1) peA = 3'b010;
else if(A[9] == 1) peA = 3'b001;
else if(A[8] == 1) peA = 3'b000;
else peA = 3'b000;    
end

always @(*) begin
if(B[15] == 1) peB = 3'b111;
else if(B[14] == 1) peB = 3'b110;
else if(B[13] == 1) peB = 3'b101;
else if(B[12] == 1) peB = 3'b100;
else if(B[11] == 1) peB = 3'b011;
else if(B[10] == 1) peB = 3'b010;
else if(B[9] == 1) peB = 3'b001;
else if(B[8] == 1) peB = 3'b000;
else peB = 3'b000;   
end

// excess one conversion stage
assign xs1A = peA + 1;
assign xs1B = peB + 1;

assign selA = A[15]|A[14]|A[13]|A[12]|A[11]|A[10]|A[9]|A[8];
assign selB = B[15]|B[14]|B[13]|B[12]|B[11]|B[10]|B[9]|B[8];

// shift selection
wire [3:0] shiftA, shiftB;
assign shiftA = selA?xs1A:4'b0000;
assign shiftB = selB?xs1B:4'b0000;

//barrel shifter
wire [15:0] Anew,Bnew;
assign Anew = (A>>shiftA);
assign Bnew = (B>>shiftB);

// N/2 bit exact multiplier 
wire [15:0] Yuncorr;
assign Yuncorr = Anew[7:0] * Bnew[7:0];

// Correction logic
wire [4:0] Fshift;
assign Fshift = shiftA + shiftB;
assign Y = Yuncorr<<Fshift;
    
endmodule