module clock_divider #(parameter n=25) (
    input clk,
    output clk_div
);

    reg [n-1:0] num=0;
    wire [n-1:0] next_num;

    always @(posedge clk) begin
        num = next_num;
    end

    assign next_num = num + 1;
    assign clk_div = num[n-1];

endmodule


module lab3_1(
    input clk,
    input rst,
    input en,
    input speed,
    output [15:0] led
);

    wire CLK_OUT_27, CLK_OUT_24, clk_div;
    clock_divider #(.n(27)) a(.clk(clk), .clk_div(CLK_OUT_27));
    clock_divider #(.n(24)) b(.clk(clk), .clk_div(CLK_OUT_24));

    wire [15:0] led_next;
    reg [15:0] led_now;

    assign clk_div = (speed ? CLK_OUT_27 : CLK_OUT_24);

    always @(posedge clk_div, posedge rst) begin
        if(rst) begin
            led_now = 16'b1111_1111_1111_1111;
        end
        else begin
            led_now = led_next;
        end
    end

    assign led = led_now;
    assign led_next = en ? !led_now : led_now; 


endmodule