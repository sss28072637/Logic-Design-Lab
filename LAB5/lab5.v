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

module clock_divider_extra (
    input clk,
    output clk_div
);
    reg [30:0] num=0;
    wire [30:0] next_num;

    always @(posedge clk) begin
        num = next_num;
    end

    assign next_num = (num==31'd200000000)?0:(num + 1);
    assign clk_div = (num==31'd200000000)?1:0;

endmodule

module clock_divider_onesecond (
    input clk,
    output clk_div
);
    reg [30:0] num=0;
    wire [30:0] next_num;

    always @(posedge clk) begin
        num = next_num;
    end

    assign next_num = (num==31'd100000000)?0:(num + 1);
    assign clk_div = (num==31'd100000000)?1:0;

endmodule

module lab5 (
    input clk,
    input rst,
    input BTNL,
    input BTNR,
    input BTNU,
    input BTND,
    input BTNC,
    output wire [15:0] LED,
    output wire [3:0] DIGIT,
    output wire [6:0] DISPLAY
);
    wire count_clk, button_clk, display_clk, seven_clk;
    clock_divider_extra a(.clk(clk), .clk_div(led_clk));
    clock_divider_onesecond c(.clk(clk), .clk_div(count_clk));
    clock_divider #(.n(13)) b(.clk(clk), .clk_div(button_clk));
    clock_divider #(.n(15)) d(.clk(clk), .clk_div(seven_clk));

    wire BTNL_temp, btnl;
    debounce pbBTNL(.pb_debounced(BTNL_temp), .pb(BTNL), .clk(button_clk));
    onepulse opBTNL(.rst(rst), .clk(button_clk), .pb_debounced(BTNL_temp), .pb_1pulse(btnl));

    wire BTNU_temp, btnu;
    debounce pbBTNU(.pb_debounced(BTNU_temp), .pb(BTNU), .clk(button_clk));
    onepulse opBTNU(.rst(rst), .clk(button_clk), .pb_debounced(BTNU_temp), .pb_1pulse(btnu));

    wire BTNR_temp, btnr;
    debounce pbBTNR(.pb_debounced(BTNR_temp), .pb(BTNR), .clk(button_clk));
    onepulse opBTNR(.rst(rst), .clk(button_clk), .pb_debounced(BTNR_temp), .pb_1pulse(btnr));

    wire BTND_temp, btnd;
    debounce pbBTND(.pb_debounced(BTND_temp), .pb(BTND), .clk(button_clk));
    onepulse opBTND(.rst(rst), .clk(button_clk), .pb_debounced(BTND_temp), .pb_1pulse(btnd));

    wire BTNC_temp, btnc;
    debounce pbBTNC(.pb_debounced(BTNC_temp), .pb(BTNC), .clk(button_clk));
    onepulse opBTNC(.rst(rst), .clk(button_clk), .pb_debounced(BTNC_temp), .pb_1pulse(btnc));

    /* wire RST_temp, RST;
    debounce pbRST(.pb_debounced(RST_temp), .pb(rst), .clk(fix_clk));
    onepulse opRST(.rst(rst), .clk(fix_clk), .pb_debounced(RST_temp), .pb_1pulse(RST)); */

    parameter IDLE=4'b0000;
    parameter TYPE=4'b0001;
    parameter AMOUNT=4'b0010;
    parameter PAYMENT=4'b0011;
    parameter PREPARE=4'b1111;
    parameter RELEASE=4'b0100;
    parameter CHANGE=4'b0101;

    reg [5:0] state, next_state;
    reg [3:0] DIGIT_now;
    reg [6:0] DISPLAY_now;
    reg [6:0] value;
    reg [1:0] REACH_payment, REACH_payment_next, REACH_release, REACH_release_next, REACH_change, REACH_change_next, REACH_prepare, REACH_prepare_next;
    reg [3:0] IDLE0, IDLE0_next, IDLE1, IDLE1_next, IDLE2, IDLE2_next, IDLE3, IDLE3_next;
    reg [3:0] BCD0, BCD0_next, BCD1, BCD1_next, BCD2, BCD2_next, BCD3, BCD3_next;
    reg [3:0] SET0, SET0_next, SET1, SET1_next, SET2, SET2_next, SET3, SET3_next;
    reg [3:0] PAY0, PAY0_next, PAY1, PAY1_next, PAY2, PAY2_next, PAY3, PAY3_next;
    reg [3:0] CHA0, CHA0_next, CHA1, CHA1_next, CHA2, CHA2_next, CHA3, CHA3_next;
    reg [15:0] LED_now, LED_next;
    reg [1:0] press_btnl, press_btnl_next, press_btnu, press_btnu_next;
    reg [1:0] press_btnr, press_btnr_next, press_btnc, press_btnc_next;
    reg [1:0] press_btnd, press_btnd_next;
    reg [1:0] refund, refund_next;

    assign DIGIT = DIGIT_now;
    assign DISPLAY = DISPLAY_now;
    assign LED = (state==IDLE||state==RELEASE)?LED_now:16'b0000_0000_0000_0000;

    //press_button
    always @(posedge button_clk or posedge rst) begin
        if(rst) begin
            press_btnc <= 0;
            press_btnu <= 0;
            press_btnl <= 0;
            press_btnr <= 0;
            press_btnd <= 0;
        end
        else begin
            press_btnc <= press_btnc_next;
            press_btnu <= press_btnu_next;
            press_btnl <= press_btnl_next;
            press_btnr <= press_btnr_next;
            press_btnd <= press_btnd_next;
        end
    end
    always @* begin
        if(btnc) begin
            press_btnc_next = 1;
        end
        else begin
            press_btnc_next = 0;
        end

        if(btnu) begin
            press_btnu_next = 1;
        end
        else begin
            press_btnu_next = 0;
        end

        if(btnl) begin
            press_btnl_next = 1;
        end
        else begin
            press_btnl_next = 0;
        end

        if(btnr) begin
            press_btnr_next = 1;
        end
        else begin
            press_btnr_next = 0;
        end

        if(btnd) begin
            press_btnd_next = 1;
        end
        else begin
            press_btnd_next = 0;
        end
    end

    //state
    always @(posedge button_clk or posedge rst) begin
        if(rst) begin
            state <= IDLE;
            refund <= 0;
        end
        else begin
            state <= next_state;
            refund <= refund_next;
        end
    end
    always @(*) begin
        case(state)
            IDLE: begin
                refund_next = 0;
                if(press_btnl || press_btnc || press_btnr) begin
                    next_state = TYPE;
                end
                else begin
                    next_state = state;
                end
            end
            TYPE: begin
                refund_next = 0;
                if(press_btnu) begin
                    next_state = AMOUNT;
                end
                else if(press_btnd) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = state;
                end
            end
            AMOUNT: begin
                refund_next = 0;
                if(press_btnu) begin
                    next_state = PAYMENT;
                end
                else if(press_btnd) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = state;
                end
            end
            PAYMENT: begin
                if(REACH_payment) begin
                    next_state = RELEASE;
                    refund_next = 0;
                end
                else if(press_btnd) begin
                    refund_next = 1;
                    next_state = PREPARE;
                end
                else begin
                    next_state = state;
                    refund_next = 0;
                end
            end
            PREPARE: begin
                if(REACH_prepare) begin
                    next_state = CHANGE;
                end
                else begin
                    next_state = state;
                end
            end
            RELEASE: begin
                refund_next = refund;
                if(REACH_release) begin
                    next_state = CHANGE;
                end
                else begin
                    next_state = state;
                end
            end
            CHANGE: begin
                refund_next = 0;
                if(REACH_change) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = state;
                end
            end
        endcase
    end

    reg [16:0] CUR, CUR_next;

    //IDLE0, 1, 2, 3
    always @(posedge count_clk or posedge rst) begin
        if(rst) begin
            IDLE0 <= 4'd11;
            IDLE1 <= 4'd11;
            IDLE2 <= 4'd11;
            IDLE3 <= 4'd11;
            CUR <= 17'd0;
        end
        else begin
            IDLE0 <= IDLE0_next;
            IDLE1 <= IDLE1_next;
            IDLE2 <= IDLE2_next;
            IDLE3 <= IDLE3_next;
            CUR <= CUR_next;
        end
    end
    always @* begin
        case(state)
            IDLE: begin
                if(IDLE0 == 4'd11 && IDLE1 == 4'd11 && IDLE2 == 4'd11 && IDLE3 == 4'd11) begin
                    IDLE0_next = 4'd10;
                    IDLE1_next = 4'd10;
                    IDLE2_next = 4'd10;
                    IDLE3_next = 4'd10;
                    CUR_next = CUR + 1;
                end
                else if(CUR==17'd0) begin
                    IDLE0_next = 4'd10;
                    IDLE1_next = 4'd10;
                    IDLE2_next = 4'd10;
                    IDLE3_next = 4'd10;
                    CUR_next = CUR + 1;
                end
                else begin
                    IDLE0_next = 4'd11;
                    IDLE1_next = 4'd11;
                    IDLE2_next = 4'd11;
                    IDLE3_next = 4'd11;
                    CUR_next = CUR + 1;
                end
            end
            default: begin
                IDLE0_next = 4'd11;
                IDLE1_next = 4'd11;
                IDLE2_next = 4'd11;
                IDLE3_next = 4'd11;
                CUR_next = 17'd0;
            end
        endcase
    end

    //BCD0, 1, 2, 3
    always @(posedge button_clk or posedge rst) begin
        if(rst) begin
            BCD0 <= 4'd4;
            BCD1 <= 4'd3;
            BCD2 <= 4'd2;
            BCD3 <= 4'd1;
        end
        else begin
            BCD0 <= BCD0_next;
            BCD1 <= BCD1_next;
            BCD2 <= BCD2_next;
            BCD3 <= BCD3_next;
        end
    end
    always @(*) begin
        case(state)
            IDLE: begin
                if(press_btnl) begin //child
                    BCD0_next = 4'd5;
                    BCD1_next = 4'd0;
                    BCD2_next = 4'd11;
                    BCD3_next = 4'd13;
                end
                else if(press_btnc) begin //student
                    BCD0_next = 4'd0;
                    BCD1_next = 4'd1;
                    BCD2_next = 4'd11;
                    BCD3_next = 4'd5;
                end
                else if(press_btnr) begin //adult
                    BCD0_next = 4'd5;
                    BCD1_next = 4'd1;
                    BCD2_next = 4'd11;
                    BCD3_next = 4'd12;
                end
                else begin
                    BCD0_next = BCD0;
                    BCD1_next = BCD1;
                    BCD2_next = BCD2;
                    BCD3_next = BCD3;
                end
            end
            TYPE: begin
                if(press_btnl) begin //child
                    BCD0_next = 4'd5;
                    BCD1_next = 4'd0;
                    BCD2_next = 4'd11;
                    BCD3_next = 4'd13;
                end
                else if(press_btnc) begin //student
                    BCD0_next = 4'd0;
                    BCD1_next = 4'd1;
                    BCD2_next = 4'd11;
                    BCD3_next = 4'd5;
                end
                else if(press_btnr) begin //adult
                    BCD0_next = 4'd5;
                    BCD1_next = 4'd1;
                    BCD2_next = 4'd11;
                    BCD3_next = 4'd12;
                end
                else begin
                    BCD0_next = BCD0;
                    BCD1_next = BCD1;
                    BCD2_next = BCD2;
                    BCD3_next = BCD3;
                end
            end
            AMOUNT: begin
                BCD0_next = BCD0;
                BCD1_next = BCD1;
                BCD2_next = BCD2;
                BCD3_next = BCD3;
            end
            PAYMENT: begin
                BCD0_next = BCD0;
                BCD1_next = BCD1;
                BCD2_next = BCD2;
                BCD3_next = BCD3;
            end
            PREPARE: begin
                BCD0_next = BCD0;
                BCD1_next = BCD1;
                BCD2_next = BCD2;
                BCD3_next = BCD3;
            end
            RELEASE: begin
                BCD0_next = BCD0;
                BCD1_next = BCD1;
                BCD2_next = BCD2;
                BCD3_next = BCD3;
            end
            CHANGE: begin
                BCD0_next = BCD0;
                BCD1_next = BCD1;
                BCD2_next = BCD2;
                BCD3_next = BCD3;
            end
        endcase
    end

    //SET0, 1, 2, 3
    always @(posedge button_clk or posedge rst) begin
        if(rst) begin
            SET0 <= 4'd0;
            SET1 <= 4'd0;
            SET2 <= 4'd0;
            SET3 <= 4'd0;
        end
        else begin
            SET0 <= SET0_next;
            SET1 <= SET1_next;
            SET2 <= SET2_next;
            SET3 <= SET3_next;
        end
    end
    always @(*) begin
        case(state)
            IDLE: begin
                SET0_next = SET0;
                SET1_next = SET1;
                SET2_next = SET2;
                SET3_next = SET3;
            end
            TYPE: begin
                SET0_next = 4'd1;
                SET1_next = 4'd11;
                SET2_next = 4'd11;
                SET3_next = BCD3;
            end
            AMOUNT: begin
                if(press_btnr) begin
                    SET0_next = (SET0==4'd3)?SET0:SET0+1;
                end
                else if(press_btnl) begin
                    SET0_next = (SET0==4'd1)?SET0:SET0-1;
                end
                else begin
                    SET0_next = SET0;
                end
                SET1_next = 4'd11;
                SET2_next = 4'd11;
                SET3_next = SET3;
            end
            PAYMENT: begin
                SET0_next = SET0;
                SET1_next = SET1;
                SET2_next = SET2;
                SET3_next = SET3;
            end
            PREPARE: begin
                SET0_next = SET0;
                SET1_next = SET1;
                SET2_next = SET2;
                SET3_next = SET3;
            end
            RELEASE: begin
                SET0_next = SET0;
                SET1_next = SET1;
                SET2_next = SET2;
                SET3_next = SET3;
            end
            CHANGE: begin
                SET0_next = SET0;
                SET1_next = SET1;
                SET2_next = SET2;
                SET3_next = SET3;
            end
        endcase
    end

    //PAY1, 2, 3, 4
    always @(posedge button_clk or posedge rst) begin
        if(rst) begin
            PAY0 <= 4'd0;
            PAY1 <= 4'd0;
            PAY2 <= 4'd0;
            PAY3 <= 4'd0;
            REACH_payment <= 0;
        end
        else begin
            PAY0 <= PAY0_next;
            PAY1 <= PAY1_next;
            PAY2 <= PAY2_next;
            PAY3 <= PAY3_next;
            REACH_payment <= REACH_payment_next;
        end
    end
    always @* begin
        case(state)
            IDLE: begin
                PAY0_next = PAY0;
                PAY1_next = PAY1;
                PAY2_next = PAY2;
                PAY3_next = PAY3;
                REACH_payment_next = 0;
            end
            TYPE: begin
                PAY0_next = PAY0;
                PAY1_next = PAY1;
                PAY2_next = PAY2;
                PAY3_next = PAY3;
                REACH_payment_next = 0;
            end
            AMOUNT: begin
                if(SET3==4'd12) begin
                    if(SET0==4'd1) begin
                        PAY0_next = 4'd5;
                        PAY1_next = 4'd1;
                    end
                    else if(SET0==4'd2) begin
                        PAY0_next = 4'd0;
                        PAY1_next = 4'd3;
                    end
                    else if(SET0==4'd3) begin
                        PAY0_next = 4'd5;
                        PAY1_next = 4'd4;
                    end
                    else begin
                        PAY0_next = PAY0;
                        PAY1_next = PAY1;
                    end
                end
                else if(SET3==4'd13) begin
                    if(SET0==4'd1) begin
                        PAY0_next = 4'd5;
                        PAY1_next = 4'd0;
                    end
                    else if(SET0==4'd2) begin
                        PAY0_next = 4'd0;
                        PAY1_next = 4'd1;
                    end
                    else if(SET0==4'd3) begin
                        PAY0_next = 4'd5;
                        PAY1_next = 4'd1;
                    end
                    else begin
                        PAY0_next = PAY0;
                        PAY1_next = PAY1;
                    end
                end
                else if(SET3==4'd5) begin
                    if(SET0==4'd1) begin
                        PAY0_next = 4'd0;
                        PAY1_next = 4'd1;
                    end
                    else if(SET0==4'd2) begin
                        PAY0_next = 4'd0;
                        PAY1_next = 4'd2;
                    end
                    else if(SET0==4'd3) begin
                        PAY0_next = 4'd0;
                        PAY1_next = 4'd3;
                    end
                    else begin
                        PAY0_next = PAY0;
                        PAY1_next = PAY1;
                    end
                end
                else begin
                    PAY0_next = PAY0;
                    PAY1_next = PAY1;
                end
                PAY2_next = 4'd0;
                PAY3_next = 4'd0;
                REACH_payment_next = 0;
            end
            PAYMENT: begin
                PAY0_next = PAY0;
                PAY1_next = PAY1;
                if((PAY3 > PAY1) || (PAY3 == PAY1 && PAY2 >= PAY0)) begin
                    REACH_payment_next = 1;
                    PAY0_next = PAY0;
                    PAY1_next = PAY1;
                    PAY2_next = PAY2;
                    PAY3_next = PAY3;
                end
                else begin
                    if(press_btnl) begin //+1
                        if(PAY2!=9 && PAY3!=9) begin
                            PAY2_next = PAY2 + 1;
                            PAY3_next = PAY3;
                        end
                        else if(PAY2==9 && PAY3!=9) begin
                            PAY2_next = 4'd0;
                            PAY3_next = PAY3 + 1;
                        end
                        else begin
                            PAY2_next = PAY2;
                            PAY3_next = PAY3;
                        end
                    end
                    else if(press_btnc) begin //+5
                        if(PAY2<5 && PAY3!=9) begin
                            PAY2_next = PAY2 + 5;
                            PAY3_next = PAY3;
                        end
                        else if(PAY2>5 && PAY3!=9) begin
                            PAY2_next = 5 - (10 - PAY2);
                            PAY3_next = PAY3 + 1;
                        end
                        else if(PAY2==5 && PAY3!=9) begin
                            PAY2_next = 4'd0;
                            PAY3_next = PAY3 + 1;
                        end
                        else begin
                            PAY2_next = PAY2;
                            PAY3_next = PAY3;
                        end
                    end
                    else if(press_btnr) begin //+10
                        PAY2_next = PAY2;
                        PAY3_next = PAY3 + 1;
                    end
                    else begin
                        PAY2_next = PAY2;
                        PAY3_next = PAY3;
                    end
                    REACH_payment_next = 0;
                end
            end
            PREPARE: begin
                PAY0_next = PAY0;
                PAY1_next = PAY1;
                PAY2_next = PAY2;
                PAY3_next = PAY3;
                REACH_payment_next = 0;
            end
            RELEASE: begin
                PAY0_next = PAY0;
                PAY1_next = PAY1;
                PAY2_next = PAY2;
                PAY3_next = PAY3;
                REACH_payment_next = 0;
            end
            CHANGE: begin
                PAY0_next = PAY0;
                PAY1_next = PAY1;
                PAY2_next = PAY2;
                PAY3_next = PAY3;
                REACH_payment_next = 0;
            end
        endcase
    end

    reg [4:0] cur, cur_next;

    //LED
    always @(posedge count_clk or posedge rst) begin
        if(rst) begin
            LED_now <= 16'b0000_0000_0000_0000;
            cur <= 0;
            REACH_release <= 0;
        end
        else begin
            LED_now <= LED_next;
            cur <= cur_next;
            REACH_release <= REACH_release_next;
        end
    end
    always @(*) begin
        case(state)
            IDLE: begin
                if(cur==0) begin
                    LED_next = 16'b1111_1111_1111_1111;
                    cur_next = cur + 1;
                end
                else begin
                    LED_next = ~LED_now;
                    cur_next = cur + 1;
                end
                REACH_release_next = 0;
            end
            TYPE: begin
                LED_next = 16'b0000_0000_0000_0000;
                cur_next = 0;
                REACH_release_next = 0;
            end
            AMOUNT: begin
                LED_next = 16'b0000_0000_0000_0000;
                cur_next = 0;
                REACH_release_next = 0;
            end
            PAYMENT: begin
                LED_next = 16'b0000_0000_0000_0000;
                cur_next = 0;
                REACH_release_next = 0;
            end
            PREPARE: begin
                LED_next = 16'b0000_0000_0000_0000;
                cur_next = 0;
                REACH_release_next = 0;
            end
            RELEASE: begin
                if(cur == 5) begin
                    LED_next = 16'b0000_0000_0000_0000;
                    cur_next = 0;
                    REACH_release_next = 1;
                end
                else begin
                    LED_next = ~LED_now;
                    cur_next = cur + 1;
                    REACH_release_next = 0;
                end
            end
            CHANGE: begin
                LED_next = 16'b0000_0000_0000_0000;
                cur_next = 0;
                REACH_release_next = 0;
            end
        endcase
    end

    //CHA1, 2, 3, 4
    always @(posedge count_clk or posedge rst) begin
        if(rst) begin
            CHA0 <= 4'd0;
            CHA1 <= 4'd0;
            CHA2 <= 4'd0;
            CHA3 <= 4'd0;
            REACH_change <= 0;
            REACH_prepare <= 0;
        end
        else begin
            CHA0 <= CHA0_next;
            CHA1 <= CHA1_next;
            CHA2 <= CHA2_next;
            CHA3 <= CHA3_next;
            REACH_change <= REACH_change_next;
            REACH_prepare <= REACH_prepare_next;
        end
    end
    always @(*) begin
        case(state)
            IDLE: begin
                CHA0_next = CHA0;
                CHA1_next = CHA1;
                CHA2_next = CHA2;
                CHA3_next = CHA3;
                REACH_change_next = 0;
                REACH_prepare_next = 0;
            end
            TYPE: begin
                CHA0_next = CHA0;
                CHA1_next = CHA1;
                CHA2_next = CHA2;
                CHA3_next = CHA3;
                REACH_change_next = 0;
                REACH_prepare_next = 0;
            end
            AMOUNT: begin
                CHA0_next = CHA0;
                CHA1_next = CHA1;
                CHA2_next = CHA2;
                CHA3_next = CHA3;
                REACH_change_next = 0;
                REACH_prepare_next = 0;
            end
            PAYMENT: begin
                REACH_prepare_next = 0;
                REACH_change_next = 0;
                CHA0_next = CHA0;
                CHA1_next = CHA1;
                CHA2_next = CHA2;
                CHA3_next = CHA3;
            end
            PREPARE: begin
                CHA0_next = PAY2;
                CHA1_next = PAY3;
                CHA2_next = 4'd11;
                CHA3_next = 4'd11;
                REACH_change_next = 0;
                REACH_prepare_next = 1;
            end
            RELEASE: begin
                if(PAY2 < PAY0) begin
                CHA0_next = (4'd10-PAY0+PAY2);
                CHA1_next = (PAY3 - 4'd1) - PAY1;
                end
                else begin
                    CHA0_next = PAY2 - PAY0;
                    CHA1_next = PAY3 - PAY1;
                end
                CHA2_next = 4'd11;
                CHA3_next = 4'd11;
                REACH_change_next = 0;
            end
            CHANGE: begin
                if(CHA1 == 0 && CHA0 == 0) begin
                    CHA0_next = CHA0;
                    CHA1_next = CHA1;
                    CHA2_next = CHA2;
                    CHA3_next = CHA3;
                    REACH_change_next = 1;
                end
                else begin
                    if(CHA1 == 0 && CHA0 >= 5) begin
                    CHA0_next = CHA0 - 4'd5;
                    CHA1_next = CHA1;
                    end
                    else if(CHA1 > 0 && CHA0 < 5) begin
                        CHA0_next = 4'd5 + CHA0;
                        CHA1_next = CHA1 - 4'd1;
                    end
                    else if(CHA1 > 0 && CHA0 >= 5) begin
                        CHA0_next = CHA0 - 4'd5;
                        CHA1_next = CHA1;
                    end
                    else if(CHA1 == 0 && CHA0 < 5) begin
                        CHA0_next = CHA0 - 4'd1;
                        CHA1_next = CHA1;
                    end
                    else begin
                        CHA0_next = CHA0;
                        CHA1_next = CHA1;
                    end
                    REACH_change_next = 0;
                end
                CHA2_next = 4'd11;
                CHA3_next = 4'd11;
            end
        endcase
    end

    always @(posedge seven_clk) begin
        case (DIGIT)
            4'b1110: begin
                value/* _next */ = (rst==1)?4'd11:(state==IDLE)?IDLE1:
                (state==TYPE)?BCD1:(state==AMOUNT)?SET1:(state==PAYMENT)?PAY1:(state==RELEASE)?SET1:(state==CHANGE)?CHA1:PAY1;
                DIGIT_now = 4'b1101;
            end
            4'b1101: begin
                value/* _next */ = (rst==1)?4'd11:(state==IDLE)?IDLE2:
                (state==TYPE)?BCD2:(state==AMOUNT)?SET2:(state==PAYMENT)?PAY2:(state==RELEASE)?SET2:(state==CHANGE)?CHA2:PAY2;
                DIGIT_now = 4'b1011;
            end
            4'b1011: begin
                value/* _next */ = (rst==1)?4'd11:(state==IDLE)?IDLE3:
                (state==TYPE)?BCD3:(state==AMOUNT)?SET3:(state==PAYMENT)?PAY3:(state==RELEASE)?SET3:(state==CHANGE)?CHA3:PAY3;
                DIGIT_now = 4'b0111;
            end
            4'b0111: begin
                value/* _next */ = (rst==1)?4'd11:(state==IDLE)?IDLE0:
                (state==TYPE)?BCD0:(state==AMOUNT)?SET0:(state==PAYMENT)?PAY0:(state==RELEASE)?SET0:(state==CHANGE)?CHA0:PAY0;
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
            4'd5: DISPLAY_now = 7'b001_0010; //S
            4'd6: DISPLAY_now = 7'b000_0010;
            4'd7: DISPLAY_now = 7'b111_1000;
            4'd8: DISPLAY_now = 7'b000_0000;
            4'd9: DISPLAY_now = 7'b001_0000;
            4'd10: DISPLAY_now = 7'b011_1111; //-
            4'd11: DISPLAY_now = 7'b111_1111; //dark
            4'd12: DISPLAY_now = 7'b000_1000; //A
            4'd13: DISPLAY_now = 7'b100_0110; //C
        endcase
    end

endmodule