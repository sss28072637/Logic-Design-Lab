module game(
    input origin_clk,
    input clk,
    input rst,
    input enter,
    input esc,
    input one,
    input two,
    input three,
    input [4:0] State,
    input [5:0] length,
    input [9:0] snake0,
    input [9:0] snake1,
    input [9:0] snake2,
    input [9:0] snake3,
    input [9:0] snake4,
    input [9:0] snake5,
    input [9:0] snake6,
    input [9:0] snake7,
    input [9:0] snake8,
    input [9:0] snake9,
    output [5:0] SCORE,
    output [4:0] STATE,
    output finish,
    output [1:0] Choose
);
    

    parameter INITIAL = 5'd0;
    parameter GAMING = 5'd1;
    parameter END = 5'd2;
    parameter WIN = 5'd3;
    parameter OVER = 5'd4;
    parameter CHOOSE = 5'd5;

    reg [5:0] score, next_score;
    reg [4:0] state, next_state;
    parameter GAME = 2'd2;

    assign SCORE = score;
    assign STATE = state;

    always @(posedge origin_clk) begin
        score <= length;
    end

    reg [1:0] choose, choose_next;
    assign Choose = choose;
    always @(posedge origin_clk or posedge rst) begin
        if(rst) begin
            state <= INITIAL;
            choose <= 2'd0;
        end
        else begin
            state <= next_state;
            choose <= choose_next;
        end
    end
    always @* begin
        case(state)
            INITIAL: begin
                if(enter==1 && State==GAME) begin
                    choose_next = 2'd0;
                    next_state = CHOOSE;
                end
                else begin
                    choose_next = 2'd0;
                    next_state = state;
                end
            end
            CHOOSE: begin
                if(one) begin
                    choose_next = 2'd1;
                    next_state = GAMING;
                end
                else if(two) begin
                    choose_next = 2'd2;
                    next_state = GAMING;
                end
                else if(three) begin
                    choose_next = 2'd3;
                    next_state = GAMING;
                end
                else begin
                    choose_next = choose;
                    next_state = state;
                end
            end
            GAMING: begin
                if(score == 6'd10) begin
                    choose_next = choose;
                    next_state = WIN;
                end
                else if(score == 6'd0) begin
                    choose_next = choose;
                    next_state = OVER;
                end
                else if((snake0==snake4 && length>6'd4) || (snake0==snake5 && length>6'd5) || (snake0==snake6 && length>6'd6) || (snake0==snake7 && length>6'd7)
                || (snake0==snake8 && length>6'd8) || (snake0==snake9 && length>6'd9) || (snake0[4:0]>5'd23) || (snake0[9:5]==5'd31 && snake1[9:5]==5'd0)
                || (snake0[9:5]==5'd0 && snake1[9:5]==5'd31)) begin
                    choose_next = choose;
                    next_state = OVER;
                end
                else begin
                    choose_next = choose;
                    next_state = state;
                end
            end
            WIN: begin
                if(esc) begin
                    choose_next = choose;
                    next_state = END;
                end
                else begin
                    choose_next = choose;
                    next_state = state;
                end
            end
            OVER: begin
                if(esc) begin
                    choose_next = choose;
                    next_state = END;
                end 
                else begin
                    choose_next = choose;
                    next_state = state;
                end
            end
            END: begin
                choose_next = choose;
                next_state = INITIAL;
            end
            default: begin
                choose_next = choose;
                next_state = state;
            end
        endcase
    end

    reg Finish, finish_next;
    always @(posedge origin_clk or posedge rst) begin
        if(rst) begin
            Finish <= 0;
        end
        else begin
            Finish <= finish_next;
        end
    end
    always @* begin
        case(state) 
            OVER: begin
                finish_next = 1;
            end
            default: finish_next = 0;
        endcase
    end

    assign finish = Finish;

endmodule

