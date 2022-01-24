`timescale 1ns/100ps

module lab2_1_t;

    reg clk, rst;
    wire [5:0] out;
    
    lab2_1 c(.clk(clk), .rst(rst), .out(out));

    always #10 clk = ~clk;

    initial begin
        clk = 1'b1;
        rst = 1'b0;
        #75
        rst = 1'b1;
        #25 
        rst = 1'b0;
        #70
        rst = 1'b1;
        #60
        rst = 1'b0;

        //$monitor($time, " clk=%d, rst=%d, out=%d ", clk, rst, out);
    end

endmodule