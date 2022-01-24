module snake_ctrl(
    input clk,
    input CLK,
    input rst,
    input Up,
    input Left,
    input Right,
    input Down,
    input [9:0] apple,
    output [5:0] Length,
    output Can,
    output reg [4:0] frequency,
    output [9:0] Snake0,
    output [9:0] Snake1,
    output [9:0] Snake2,
    output [9:0] Snake3,
    output [9:0] Snake4,
    output [9:0] Snake5,
    output [9:0] Snake6,
    output [9:0] Snake7,
    output [9:0] Snake8,
    output [9:0] Snake9
);
    
    parameter UP = 3'd0;
    parameter DOWN = 3'd1;
    parameter LEFT = 3'd2;
    parameter RIGHT = 3'd3;

    reg [9:0] snake_head;
    reg can, can_next;

    assign Can = can;

    //counter for making apple
    reg [3:0] count, next_count;
    always@(posedge CLK or posedge rst) begin
        if(rst) count<=1'b0;
        else count<=next_count+1'b1;
    end
    always@(*) begin
        next_count=count;
        can_next=can;
    end

    always @(posedge CLK) begin
        if(snake_head[4:0] == apple[4:0] && snake_head[9:5] == apple[9:5]) begin
            can <= 0;
        end
        else begin
            if(can==0 && count==4'd10) begin
                can <= 1;
            end
            else begin
                can <= can_next;
            end
        end
    end


    reg [5:0] length, length_next;

    always @* begin
        if(3 <= length && length <= 9) begin
            frequency = length + 5'd3;
        end
        else begin
            frequency = 5'd3;
        end
    end 

    assign Length = length;

    reg [9:0] snake0, snake1, snake2, snake3, snake4, snake5, snake6, snake7, snake8, snake9;

    always @(posedge CLK or posedge rst) begin
        if(rst) begin
            length <= 5'b1;
        end
        else begin
            length <= length_next;
        end
    end
    always @(snake_head[4:0] or snake_head[9:5]) begin
        if(snake_head[4:0]==apple[4:0] && snake_head[9:5]==apple[9:5]) begin
            length_next = length + 5'd1;
        end
        else begin
            length_next = length;
        end
    end

    assign Snake0 = snake0;
    assign Snake1 = snake1;
    assign Snake2 = snake2;
    assign Snake3 = snake3;
    assign Snake4 = snake4;
    assign Snake5 = snake5;
    assign Snake6 = snake6;
    assign Snake7 = snake7;
    assign Snake8 = snake8;
    assign Snake9 = snake9;

    reg [2:0] d, d_next;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            d <= RIGHT;
        end
        else begin
            d <= d_next;
        end
    end
    always @(Up or Down or Right or Left) begin
        if(Right && snake0[9:5]!=snake1[9:5]-1'b1 && d!=LEFT) begin
            d_next = RIGHT;
        end
        else if(Left && snake0[9:5]!=snake1[9:5]+1'b1 && d!=RIGHT) begin
            d_next = LEFT;
        end
        else if(Down && snake0[4:0]!=snake1[4:0]-1'b1 && d!=UP) begin
            d_next = DOWN;
        end
        else if(Up && snake0[4:0]!=snake1[4:0]+1'b1 && d!=DOWN) begin
            d_next = UP;
        end
        else begin
            d_next = d;
        end
    end

    always @(posedge CLK or posedge rst) begin
        if(rst) begin
            snake0[9:5] <= 10'd10;
            snake0[4:0] <= 10'd0;
            snake1 <= 10'b1111111111;
            snake2 <= 10'b1111111111;
            snake3 <= 10'b1111111111;
            snake4 <= 10'b1111111111;
            snake5 <= 10'b1111111111;
            snake6 <= 10'b1111111111;
            snake7 <= 10'b1111111111;
            snake8 <= 10'b1111111111;
            snake9 <= 10'b1111111111;
        end
        else begin
            snake0 <= snake_head;
            snake1 <= snake0;
            snake2 <= snake1;
            snake3 <= snake2;
            snake4 <= snake3;
            snake5 <= snake4;
            snake6 <= snake5;
            snake7 <= snake6;
            snake8 <= snake7;
            snake9 <= snake8;
        end
    end

    always @* begin
        case(d)
            UP: begin
                snake_head[4:0] = snake0[4:0] - 1;
                snake_head[9:5] = snake0[9:5]; 
            end
            DOWN: begin
                snake_head[4:0] = snake0[4:0] + 1;
                snake_head[9:5] = snake0[9:5];
            end
            RIGHT: begin
                snake_head[4:0] = snake0[4:0];
                snake_head[9:5] = snake0[9:5] + 1;
            end
            LEFT: begin
                snake_head[4:0] = snake0[4:0];
                snake_head[9:5] = snake0[9:5] - 1;
            end
            default: begin
                snake_head[4:0] = snake0[4:0];
                snake_head[9:5] = snake0[9:5];
            end
        endcase
    end

endmodule