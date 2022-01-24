`timescale 1ns/100ps

module lab2_2 (
    input clk,
    input rst,
    input carA,
    input carB,
    output reg [2:0] lightA,
    output reg [2:0] lightB);

    parameter S0 = 2'b00; //A : green, B : red;
    parameter S1 = 2'b01; //A : yellow, B : red;
    parameter S2 = 2'b10; //A : red, B : green;
    parameter S3 = 2'b11; //A : red, B : yellow;
    parameter unknown = 3'b111;
    reg [2:0] state, next_state, pre_state;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            state <= S0;
            pre_state <= unknown;
        end
        else begin
            pre_state <= state;
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = S0;
        case (state)
            S0 : begin
                lightA = 3'b001;
                lightB = 3'b100;
                if(!carA && carB && pre_state == S0)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1 : begin
                lightA = 3'b010;
                lightB = 3'b100;
                next_state = S2;
            end
            S2 : begin
                lightA = 3'b100;
                lightB = 3'b001;
                if(carA && !carB && pre_state == S2)
                    next_state = S3;
                else
                    next_state = S2;
            end
            S3 : begin
                lightA = 3'b100;
                lightB = 3'b010;
                next_state = S0;
            end
            default : begin
                lightA = 3'b001;
                lightB = 3'b100;
                next_state = S0;
            end
        endcase
    end
    
endmodule