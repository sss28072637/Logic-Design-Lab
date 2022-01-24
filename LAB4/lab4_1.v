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

module lab4_1 (
    input clk,
    input rst,
    input en,
    input dir,
    input speed_up,
    input speed_down,
    output [3:0] DIGIT,
    output [6:0] DISPLAY,
    output max,
    output min
);
    reg [1:0] state, next_state;
    parameter pulse = 1'b0;
    parameter start = 1'b1;
    
    reg [3:0] speed, speed_next;
    wire CLK_DIV0, CLK_DIV1, CLK_DIV2, CLK_DIv, clk_div, fix_clk;
    clock_divider #(.n(27)) clkdiv0(.clk(clk), .clk_div(CLK_DIV0));
    clock_divider #(.n(26)) clkdiv1(.clk(clk), .clk_div(CLK_DIV1));
    clock_divider #(.n(25)) clkdiv2(.clk(clk), .clk_div(CLK_DIV2));
    clock_divider #(.n(10)) clkdiv3(.clk(clk), .clk_div(CLK_DIv));
    clock_divider #(.n(13)) clkdiv4(.clk(clk), .clk_div(fix_clk));
    
    assign clk_div = (speed==4'd0) ? CLK_DIV0 : (speed==4'd1) ? CLK_DIV1 : CLK_DIV2;

    wire RST_temp, RST;
    debounce pbRST(.pb_debounced(RST_temp), .pb(rst), .clk(fix_clk));
    onepulse opRST(.rst(rst), .clk(fix_clk), .pb_debounced(RST_temp), .pb_1pulse(RST));
    
    wire DIR_temp, DIR;
    debounce pbDIR(.pb_debounced(DIR_temp), .pb(dir), .clk(fix_clk));
    onepulse opDIR(.rst(rst), .clk(fix_clk), .pb_debounced(DIR_temp), .pb_1pulse(DIR));

    wire EN_temp, EN;
    debounce pbEN(.pb_debounced(EN_temp), .pb(en), .clk(fix_clk));
    onepulse opEN(.rst(rst), .clk(fix_clk), .pb_debounced(EN_temp), .pb_1pulse(EN));

    wire SPEED_UP_temp, SPEED_UP;
    debounce pbUP(.pb_debounced(SPEED_UP_temp), .pb(speed_up), .clk(fix_clk));
    onepulse opUP(.rst(rst), .clk(fix_clk), .pb_debounced(SPEED_UP_temp), .pb_1pulse(SPEED_UP));

    wire SPEED_DOWN_temp, SPEED_DOWN;
    debounce pbDOWN(.pb_debounced(SPEED_DOWN_temp), .pb(speed_down), .clk(fix_clk));
    onepulse opDOWN(.rst(rst), .clk(fix_clk), .pb_debounced(SPEED_DOWN_temp), .pb_1pulse(SPEED_DOWN));

    reg [3:0] DIGIT_now;
    reg [6:0] DISPLAY_now, DISPLAY_next;
    reg [1:0] up_down, up_down_next; //up=1, down=0
    reg [3:0] value, value_next;
    reg [3:0] BCD0, BCD0_next, BCD1, BCD1_next;
    reg [1:0] max_now, min_now;

    assign DIGIT = DIGIT_now;
    assign DISPLAY = DISPLAY_now;
    assign max = max_now;
    assign min = min_now;

    //state
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            state <= start;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        if(EN) begin
            next_state = ~state;
        end
        else begin
            next_state = state;
        end
    end

    //up_down
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            up_down <= 1;
        end
        else begin
            up_down <= up_down_next;
        end
    end

    always @(*) begin
        if(DIR_temp) begin
            up_down_next = 0;
        end
        else begin
            up_down_next = 1;
        end
    end


    //speed
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            speed <= 0;
        end
        else begin
            speed <= speed_next;
        end
    end

    always @(*) begin
        if(SPEED_UP && state!=pulse) begin
            if(speed == 0) begin
                speed_next = 1;
            end
            else if(speed == 1) begin
                speed_next = 2;
            end
            else begin
                speed_next = speed;
            end
        end
        else if(SPEED_DOWN && state!=pulse) begin
            if(speed == 4'd2) begin
                speed_next = 4'd1;
            end
            else if(speed == 4'd1) begin
                speed_next = 4'd0;
            end
            else begin
                speed_next = speed;
            end
        end
        else begin
            speed_next = speed;
        end
    end

    //BCD0, BCD1
    always @(posedge clk_div or posedge RST) begin
        if(RST) begin
            BCD0 <= 0;
            BCD1 <= 0;
        end
        else begin
            BCD0 <= BCD0_next;
            BCD1 <= BCD1_next;
        end
    end 

    always @(*) begin
        max_now = 0;
        min_now = 0;
        case(state)
            pulse: begin
                BCD0_next = BCD0;
                BCD1_next = BCD1;
            end
            start: begin
                if(up_down) begin
                    if(BCD0 == 9 && BCD1 == 9) begin
                        BCD0_next = 9;
                        BCD1_next = 9;
                        max_now = 1;
                    end
                    else if(BCD0 == 9 && BCD1 != 9) begin
                        BCD0_next = 0;
                        BCD1_next = BCD1 + 1;
                        max_now = 0;
                    end
                    else begin
                        BCD0_next = BCD0 + 1;
                        BCD1_next = BCD1;
                        max_now = 0;
                    end
                end
                else begin
                    if(BCD0 == 0 && BCD1 == 0) begin
                        BCD0_next = 0;
                        BCD1_next = 0;
                        min_now = 1;
                    end
                    else if(BCD0 == 0 && BCD1 != 0) begin
                        BCD0_next = 9;
                        BCD1_next = BCD1 - 1;
                        min_now = 0;
                    end
                    else begin
                        BCD0_next = BCD0 - 1;
                        BCD1_next = BCD1;
                        min_now = 0;
                    end
                end
            end
        endcase
    end

    always @(posedge CLK_DIv) begin
        case (DIGIT)
            4'b1110: begin
                value/* _next */ = BCD1;
                DIGIT_now = 4'b1101;
            end
            4'b1101: begin
                value/* _next */ = (up_down==1 ? 4'd10 : 4'd11);
                DIGIT_now = 4'b1011;
            end
            4'b1011: begin
                value/* _next */ = speed;
                DIGIT_now = 4'b0111;
            end
            4'b0111: begin
                value/* _next */ = BCD0;
                DIGIT_now = 4'b1110;
            end
            default: begin
                value/* _next */ = 4'd2;
                DIGIT_now = 4'b1110;
            end
        endcase
    end

    always @* begin
        case (value)
            4'd0: DISPLAY_now = 7'b100_0000;
            4'd1: DISPLAY_now = 7'b111_1001;
            4'd2: DISPLAY_now = 7'b010_0100;
            4'd3: DISPLAY_now = 7'b011_0000;
            4'd4: DISPLAY_now = 7'b001_1001;
            4'd5: DISPLAY_now = 7'b001_0010;
            4'd6: DISPLAY_now = 7'b000_0010;
            4'd7: DISPLAY_now = 7'b111_1000;
            4'd8: DISPLAY_now = 7'b000_0000;
            4'd9: DISPLAY_now = 7'b001_0000;
            4'd10: DISPLAY_now = 7'b101_1100; //up
            4'd11: DISPLAY_now = 7'b110_0011; //down
            default: DISPLAY_now = 7'b111_1111;
        endcase
    end

endmodule