module Generic(input i_clk, i_reset, input signed [15:0] i_sample,output [31:0] o_result);
    parameter NTAPS = 41, IW=16, TW=IW;
    //wire [(IW-1):0] i_sample;
    reg signed	[(TW-1):0] tap		[0:NTAPS-1];
	reg signed	[(IW-1):0] sample	[0:NTAPS-1];
    wire signed	[(TW+IW-1):0]	product [0:NTAPS-1];
    wire signed [(TW+IW-1):0] acc [0:NTAPS-1];

    integer	k;
	
    always @(posedge i_clk ) 
    begin
        if (i_reset) 
            for(k=0; k<NTAPS; k=k+1)
                begin
                sample[k] <= 16'b0000000000000000;
                end
        else
            begin 
                sample[0] <= i_sample;
                for(k=1; k<NTAPS; k=k+1)
	                begin
                        sample[k] <= sample[k-1];
                    end
            end
    end
    
    genvar i;
    generate
        assign product[0] = sample[0]*tap[0];
       assign acc[0] = product[0];
    for(i=1; i<NTAPS; i=i+1)
        begin
            
            assign product[i] = sample[i]*tap[i];
            assign acc[i] = acc[i-1] + product[i];
            
        end
    endgenerate 

    assign o_result = acc[NTAPS-1];

    

endmodule


