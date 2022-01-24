`timescale 1ns/100ps

module lab1_2 (a, b, aluctr, d);
    input [3:0] a;
    input [1:0] b;
    input [1:0] aluctr;
    output reg [3:0] d;
    wire [3:0] OUT;
    
    lab1_1 c(.a(a), .b(b), .dir(aluctr), .d(OUT));

    always @(*) begin
        if(aluctr == 2'b00)
            d = OUT;
        else if(aluctr == 2'b01)
            d = OUT;
        else if(aluctr == 2'b10)
            d = a + b;
        else
            d = a - b;
    end
    
endmodule