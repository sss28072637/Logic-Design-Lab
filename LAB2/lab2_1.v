`timescale 1ns/100ps

module lab2_1 (
    input clk,
    input rst,
    output reg [5:0] out);

    reg [5:0] An, Bn, tempA, tempB;
    reg [5:0] n;
    reg up_down; //up=0, down=1;

    initial begin
        An = 6'd0;
        Bn = 6'd63;
        n = 0;
        up_down = 0;
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            An = 0;
            Bn = 6'd63;
            n = 1;
            up_down = 0;
        end
        else begin
            if(!up_down) begin //up
                if(An > n) begin
                    tempA = An - n;
                    An = tempA;
                    n = n + 1;
                end
                else begin
                    tempA = An + n;
                    An = tempA;
                    n = n + 1;
                end 
            end
            else begin //down
                tempB = Bn - 2**(n-1);
                Bn = tempB;
                n = n + 1;
            end
        end
    end

    always @ (posedge clk) begin
        if(An == 6'd63) begin
            up_down <= 1;
            An <= 0;
            Bn <= 6'd63;
            n <= 1;
        end
        else if(Bn == 0) begin
            up_down <= 0;
            An <= 0;
            Bn <= 6'd63;
            n <= 1;
        end
        else begin
            up_down <= up_down;
            An <= An;
            Bn <= Bn;
            n <= n;
        end
    end

    always @ (*) begin
        if(!up_down) begin
            out <= An;
        end
        else begin
            out <= Bn;
        end
    end    
endmodule