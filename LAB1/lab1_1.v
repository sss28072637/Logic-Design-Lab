`timescale 1ns/100ps

module lab1_1 (a, b, dir, d);
    input [3:0] a;
    input [1:0] b;
    input dir;
    output reg [3:0] d;

    always @(*) begin
        if(dir == 0) begin
            d = a << b;
        end
        else
            d = a >> b;
    end
    
endmodule