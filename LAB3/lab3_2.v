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

module lab3_2 (
    input clk,
    input rst,
    input en,
    input dir,
    output [15:0] led
);
    reg [2:0] state, next_state;
    parameter flash = 2'b00;
    parameter shift = 2'b01;
    parameter expand = 2'b11;

    wire CLK;
    clock_divider #(.n(25)) d(.clk(clk), .clk_div(CLK));

    reg [15:0] led_next, led_now;
    reg [3:0] cnt, cnt_next;
    reg [3:0] left1, right1, left1_nxt, right1_nxt;

    always @(posedge CLK, posedge rst) begin
        if(rst) begin
            state <= flash;
            led_now <= 16'b1111_1111_1111_1111;
            cnt <= 0;
            left1 <= 0;
            right1 <= 0;
        end
        else begin
            state <= next_state;
            led_now <= led_next;
            cnt <= cnt_next;
            left1 <= left1_nxt;
            right1 <= right1_nxt;
        end
    end

    always @* begin
        if(!en) begin
            next_state = state;
            led_next = led_now;
            cnt_next = cnt;
            left1_nxt = left1;
            right1_nxt = right1;
        end
        else begin
            next_state = state;
            led_next = led_now;
            cnt_next = cnt;
            left1_nxt = left1;
            right1_nxt = right1;
            case(state)
                flash : begin
                    left1_nxt = left1;
                    right1_nxt = right1;
                    if(cnt == 12) begin
                        next_state = shift;
                        led_next = 16'b1010_1010_1010_1010;
                        cnt_next = 0;
                    end
                    else begin
                        next_state = state;
                        led_next = ~led_next;
                        cnt_next = cnt + 1;
                    end
                end
                shift : begin
                    if(!led_now) begin //LED ALL OFF
                        next_state = expand;
                        led_next = 16'b0000_0001_1000_0000;
                        cnt_next = 0;
                        left1_nxt = left1;
                        right1_nxt = right1;
                    end
                    else begin 
                        if(!dir) begin //dir==0
                            next_state = state;
                            cnt_next = 0;
                            if(led_now[15] == 1'b0) begin
                                if(left1 > 0) begin
                                    led_next = 16'b1000_0000_0000_0000 + (led_now >> 1);
                                    left1_nxt = left1 - 1;
                                    right1_nxt = led_now[0] ? right1+1 : right1;
                                end
                                else begin
                                    led_next = led_now >> 1;
                                    left1_nxt = left1;
                                    right1_nxt = led_now[0] ? right1+1 : right1;
                                end
                            end
                            else begin 
                                led_next = led_now >> 1;
                                left1_nxt = left1;
                                right1_nxt = led_now[0] ? right1+1 : right1;
                            end
                        end
                        else begin //dir==1
                            next_state = state;
                            cnt_next = 0;
                            if(led_now[0] == 1'b0) begin
                                if(right1 > 0) begin
                                    led_next = (led_now << 1) + 16'b0000_0000_0000_0001;
                                    right1_nxt = right1 - 1;
                                    left1_nxt = led_now[15] ? left1+1 : left1;
                                end
                                else begin
                                    led_next = led_now << 1;
                                    right1_nxt = right1;
                                    left1_nxt = led_now[15] ? left1+1 : left1;
                                end
                            end
                            else begin
                                led_next = led_now << 1;
                                right1_nxt = right1;
                                left1_nxt = led_now[15] ? left1+1 : left1;
                            end
                        end
                    end
                end
                expand : begin
                    left1_nxt = left1;
                    right1_nxt = right1;
                    if(led_now == 16'b1111_1111_1111_1111) begin
                        next_state = flash;
                        led_next = ~led_now;
                        cnt_next = 1;
                    end
                    else if(led_now == 0) begin
                        if(!dir) begin
                            next_state = state;
                            led_next = 16'b0000_0001_1000_0000;
                            cnt_next = 0;
                        end
                        else begin
                            next_state = state;
                            led_next = 16'b0000_0000_0000_0000;
                            cnt_next = 0;
                        end
                    end
                    else begin
                        if(dir) begin
                            next_state = state;
                            led_next[7:0] = led_now[7:0] << 1;
                            led_next[15:8] = led_now[15:8] >> 1;
                            cnt_next = 0; 
                        end
                        else begin
                            next_state = state;
                            led_next[7:0] = 8'b1000_0000 + (led_now[7:0] >> 1);
                            led_next[15:8] = (led_now[15:8] << 1) + 8'b0000_0001;
                            cnt_next = 0; 
                        end
                    end
                end
            endcase
        end
    end

    assign led = led_now;

endmodule