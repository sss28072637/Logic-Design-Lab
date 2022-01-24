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

    assign next_num = (num==31'd10000000)?0:(num + 1);
    assign clk_div = (num==31'd10000000)?1:0;

endmodule

module lab4_2 (
    input clk,
    input rst,
    input en,
    input input_number,
    input enter,
    input count_down,
    output [3:0] DIGIT,
    output [6:0] DISPLAY,
    output led0
);

    wire CLK_DIV, CLK_DIv, fix_clk;
    clock_divider_extra clkdiv2(.clk(clk), .clk_div(CLK_DIV));
    clock_divider #(.n(15)) clkdiv3(.clk(clk), .clk_div(CLK_DIv));
    clock_divider #(.n(13)) clkdiv4(.clk(clk), .clk_div(fix_clk));

    parameter Direct_setting = 2'b00;
    parameter Number_setting = 2'b01;
    parameter Counting = 2'b10;


    reg [1:0] LED, LED_next, down, down_next, state, next_state, press_enter, press_enter_next, Input, Input_next;
    reg [3:0] BCD0, BCD0_next, BCD1, BCD1_next, BCD2, BCD2_next, BCD3, BCD3_next, cur, cur_next;
    reg [3:0] goal0, goal0_next, goal1, goal1_next, goal2, goal2_next, goal3, goal3_next;
    reg [3:0] DIGIT_now;
    reg [6:0] DISPLAY_now;
    reg [6:0] value;
    reg [3:0] set0, set0_next, set1, set1_next, set2, set2_next, set3, set3_next;
    reg [1:0] press_input, press_input_next;

    assign DIGIT = DIGIT_now;
    assign DISPLAY = DISPLAY_now;
    assign led0 = down?1:0;

    wire EN_temp, EN;
    debounce pbEN(.pb_debounced(EN_temp), .pb(en), .clk(fix_clk));
    onepulse opEN(.rst(rst), .clk(fix_clk), .pb_debounced(EN_temp), .pb_1pulse(EN));

    wire COUNT_DOWN_temp, COUNT_DOWN;
    debounce pbCOUNT(.pb_debounced(COUNT_DOWN_temp), .pb(count_down), .clk(fix_clk));
    onepulse opCOUNT(.rst(rst), .clk(fix_clk), .pb_debounced(COUNT_DOWN_temp), .pb_1pulse(COUNT_DOWN));

    wire ENTER_temp, ENTER;
    debounce pbENTER(.pb_debounced(ENTER_temp), .pb(enter), .clk(fix_clk));
    onepulse opENTER(.rst(rst), .clk(fix_clk), .pb_debounced(ENTER_temp), .pb_1pulse(ENTER));

    wire INPUT_temp, INPUT;
    debounce pbINPUT(.pb_debounced(INPUT_temp), .pb(input_number), .clk(fix_clk));
    onepulse opINPUT(.rst(rst), .clk(fix_clk), .pb_debounced(INPUT_temp), .pb_1pulse(INPUT));

    wire RST_temp, RST;
    debounce pbRST(.pb_debounced(RST_temp), .pb(rst), .clk(fix_clk));
    onepulse opRST(.rst(rst), .clk(fix_clk), .pb_debounced(RST_temp), .pb_1pulse(RST));

    //INPUT
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            press_input <= 0;
        end
        else begin
            press_input <= press_input_next;
        end
    end
    always @* begin
        if(INPUT) begin
            press_input_next = 1;
        end
        else begin
            press_input_next = 0;
        end
    end

    //ENTER
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            press_enter <= 0;
        end
        else begin
            press_enter <= press_enter_next;
        end
    end
    always @(*) begin
        if(ENTER) begin
            press_enter_next = 1;
        end
        else begin
            press_enter_next = 0;
        end
    end

    //state, cur, down
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            state <= Direct_setting;
            cur <= 3;
        end
        else begin
            state <= next_state;
            cur <= cur_next;
        end
    end
    always @* begin
        case(state)
            Direct_setting: begin
                if(ENTER) begin
                    next_state = Number_setting;
                    cur_next = cur;
                end
                else begin
                    next_state = state;
                    cur_next = cur;
                end
            end
            Number_setting: begin
                if(ENTER) begin
                    if(cur==0) begin
                        cur_next = 3;
                        next_state = Counting;
                    end
                    else begin
                        cur_next = cur - 1;
                        next_state = state;
                    end
                end
                else begin
                    cur_next = cur;
                    next_state = state;
                end
            end
            Counting: begin
                next_state = state;
                cur_next = 3;
            end
        endcase
    end

    //down
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            down <= 0;
        end
        else begin
            down <= down_next;
        end
    end
    always @* begin
        case(state)
            Direct_setting: begin
                if(COUNT_DOWN) begin
                    down_next = ~down;
                end
                else begin
                    down_next = down;
                end
            end
            Number_setting: begin
                down_next = down;
            end
            Counting: begin
                down_next = down;
            end
            default: begin
                down_next = 1'b0;
            end
        endcase
        
    end

    //goal
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            goal0 <= 4'd9;
            goal1 <= 4'd9;
            goal2 <= 4'd5;
            goal3 <= 4'd1;
        end
        else begin
            goal0 <= goal0_next;
            goal1 <= goal1_next;
            goal2 <= goal2_next;
            goal3 <= goal3_next;
        end
    end
    always @* begin
        case(state)
            Direct_setting: begin
                goal0_next = goal0;
                goal1_next = goal1;
                goal2_next = goal2;
                goal3_next = goal3;
            end
            Number_setting: begin
                goal0_next = set0;
                goal1_next = set1;
                goal2_next = set2;
                goal3_next = set3;
            end
            Counting: begin
                goal0_next = goal0;
                goal1_next = goal1;
                goal2_next = goal2;
                goal3_next = goal3;
            end
        endcase
    end

    //Input
    always @(posedge fix_clk or posedge RST) begin
        if(RST) begin
            Input <= 0;
        end
        else begin
            Input <= Input_next;
        end
    end
    always @* begin
        if(INPUT) 
            Input_next = 1;
        else 
            Input_next = ~Input;
    end

    //BCD
    always @(posedge CLK_DIV or posedge RST) begin
        if(RST) begin
            BCD0 <= 4'd0;
            BCD1 <= 4'd0;
            BCD2 <= 4'd0;
            BCD3 <= 4'd0;
        end
        else begin
            BCD0 <= BCD0_next;
            BCD1 <= BCD1_next;
            BCD2 <= BCD2_next;
            BCD3 <= BCD3_next;
        end
    end

    always @(posedge fix_clk, posedge RST) begin
        if(RST) begin
            set0 <= 4'd0;
            set1 <= 4'd0;
            set2 <= 4'd0;
            set3 <= 4'd0;
        end
        else begin
            set0 <= set0_next;
            set1 <= set1_next;
            set2 <= set2_next;
            set3 <= set3_next;
        end
    end

    always @(*) begin
        case(state)
            Direct_setting: begin
                set0_next = 4'd0;
                set1_next = 4'd0;
                set2_next = 4'd0;
                set3_next = 4'd0;
            end
            Number_setting: begin
                if(INPUT) begin
                    if(cur == 3) begin
                        if(set3==4'd1) begin
                            set3_next = 0;
                        end
                        else begin
                            set3_next = set3 + 1;
                        end
                        set0_next = set0;
                        set1_next = set1;
                        set2_next = set2;
                    end
                    else if(cur==2) begin
                        if(set2==4'd5) begin
                            set2_next = 0;
                        end
                        else begin
                            set2_next = set2 + 1;
                        end
                        set0_next = set0;
                        set1_next = set1;
                        set3_next = set3;
                    end
                    else if(cur==1) begin
                        if(set1==4'd9) begin
                            set1_next = 0;
                        end
                        else begin
                            set1_next = set1 + 1;
                        end
                        set0_next = set0;
                        set2_next = set2;
                        set3_next = set3;
                    end
                    else begin
                        if(set0==4'd9) begin
                            set0_next = 0;
                        end
                        else begin
                            set0_next = set0 + 1;
                        end
                        set1_next = set1;
                        set2_next = set2;
                        set3_next = set3;
                    end
                end
                else begin
                    set0_next = set0;
                    set1_next = set1;
                    set2_next = set2;
                    set3_next = set3;
                end
            end
            Counting: begin
                set0_next = set0;
                set1_next = set1;
                set2_next = set2;
                set3_next = set3;
            end
            default: begin
                set0_next = 4'd0;
                set1_next = 4'd0;
                set2_next = 4'd0;
                set3_next = 4'd0;
            end
        endcase
    end

    always @* begin
        case(state)
            Direct_setting: begin
                //switch to next case
                BCD0_next = 4'd0;
                BCD1_next = 4'd0;
                BCD2_next = 4'd0;
                BCD3_next = 4'd0;
            end
            Number_setting: begin
                //switch to next case
                if(down) begin
                    BCD0_next = goal0;
                    BCD1_next = goal1;
                    BCD2_next = goal2;
                    BCD3_next = goal3;
                end
                else begin
                    BCD0_next = 4'd0;
                    BCD1_next = 4'd0;
                    BCD2_next = 4'd0;
                    BCD3_next = 4'd0;
                end
            end
            Counting: begin
                if(en) begin
                    if(down) begin
                        if(BCD0 == 4'd0) begin
                            if(BCD1 == 4'd0) begin
                                if(BCD2 == 4'd0) begin
                                    if(BCD3 == 4'd0) begin
                                        BCD3_next = BCD3;
                                        BCD2_next = BCD2;
                                        BCD1_next = BCD1;
                                        BCD0_next = BCD0;
                                    end
                                    else begin
                                        BCD3_next = BCD3 - 1;
                                        BCD2_next = 4'd5;
                                        BCD1_next = 4'd9;
                                        BCD0_next = 4'd9;
                                    end
                                end
                                else begin
                                    BCD3_next = BCD3;
                                    BCD2_next = BCD2 - 1;
                                    BCD1_next = 4'd9;
                                    BCD0_next = 4'd9;
                                end
                            end
                            else begin
                                BCD3_next = BCD3;
                                BCD2_next = BCD2;
                                BCD1_next = BCD1 - 1;
                                BCD0_next = 4'd9;
                            end
                        end
                        else begin
                            BCD3_next = BCD3;
                            BCD2_next = BCD2;
                            BCD1_next = BCD1;
                            BCD0_next = BCD0 - 1;
                        end
                    end
                    else begin
                        if(BCD3==goal3 && BCD2==goal2 && BCD1==goal1 && BCD0==goal0) begin
                            BCD0_next = BCD0;
                            BCD1_next = BCD1;
                            BCD2_next = BCD2;
                            BCD3_next = BCD3;
                        end
                        else if(BCD3==goal3 && BCD2==goal2 && BCD1==goal1 && BCD0!=goal0) begin
                            BCD0_next = BCD0 + 1;
                            BCD1_next = BCD1;
                            BCD2_next = BCD2;
                            BCD3_next = BCD3;
                        end
                        else if(BCD3==goal3 && BCD2==goal2 && BCD1!=goal1 && BCD0!=goal0) begin
                            if(BCD0 == 9) begin
                                BCD0_next = 4'd0;
                                BCD1_next = BCD1 + 1;
                                BCD2_next = BCD2;
                                BCD3_next = BCD3;
                            end
                            else begin
                                BCD0_next = BCD0 + 1;
                                BCD1_next = BCD1;
                                BCD2_next = BCD2;
                                BCD3_next = BCD3;
                            end
                        end
                        else if(BCD3==goal3 && BCD2!=goal2 && BCD1!=goal1 && BCD0!=goal0) begin
                            if(BCD0 == 9) begin
                                if(BCD1 == 9) begin
                                    BCD0_next = 4'd0;
                                    BCD1_next = 4'd0;
                                    BCD2_next = BCD2 + 1;
                                    BCD3_next = BCD3;
                                end
                                else begin
                                    BCD0_next = 4'd0;
                                    BCD1_next = BCD1 + 1;
                                    BCD2_next = BCD2;
                                    BCD3_next = BCD3;
                                end
                            end
                            else begin
                                BCD0_next = BCD0 + 1;
                                BCD1_next = BCD1;
                                BCD2_next = BCD2;
                                BCD3_next = BCD3;
                            end
                        end
                        else begin
                            if(BCD0 == 9) begin
                                if(BCD1 == 9) begin
                                    if(BCD2 == 9) begin
                                        BCD0_next = 4'd0;
                                        BCD1_next = 4'd0;
                                        BCD2_next = 4'd0;
                                        BCD3_next = BCD3 + 1;
                                    end
                                    else begin
                                        BCD0_next = 4'd0;
                                        BCD1_next = 4'd0;
                                        BCD2_next = BCD2 + 1;
                                        BCD3_next = BCD3;
                                    end
                                end
                                else begin
                                    BCD0_next = 4'd0;
                                    BCD1_next = BCD1 + 1;
                                    BCD2_next = BCD2;
                                    BCD3_next = BCD3;
                                end
                            end
                            else begin
                                BCD0_next = BCD0 + 1;
                                BCD1_next = BCD1;
                                BCD2_next = BCD2;
                                BCD3_next = BCD3;
                            end
                        end
                    end
                end
                else begin
                    BCD3_next = BCD3;
                    BCD2_next = BCD2;
                    BCD1_next = BCD1;
                    BCD0_next = BCD0;
                end
            end
            default: begin
                BCD0_next = 4'd0;
                BCD1_next = 4'd0;
                BCD2_next = 4'd0;
                BCD3_next = 4'd0;
            end
        endcase
    end

    always @(posedge CLK_DIv) begin
        case (DIGIT)
            4'b1110: begin
                value/* _next */ = (state==Direct_setting)?4'd10:
                (state==Number_setting)?set1:BCD1;
                DIGIT_now = 4'b1101;
            end
            4'b1101: begin
                value/* _next */ = (state==Direct_setting)?4'd10:
                (state==Number_setting)?set2:BCD2;
                DIGIT_now = 4'b1011;
            end
            4'b1011: begin
                value/* _next */ = (state==Direct_setting)?4'd10:
                (state==Number_setting)?set3:BCD3;
                DIGIT_now = 4'b0111;
            end
            4'b0111: begin
                value/* _next */ = (state==Direct_setting)?4'd10:
                (state==Number_setting)?set0:BCD0;
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
            4'd10: DISPLAY_now = 7'b011_1111; //-
            default: DISPLAY_now = 7'b111_1111;
        endcase
    end




endmodule