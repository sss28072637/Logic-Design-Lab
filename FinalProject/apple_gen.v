module apple_gen(
    input can,
    output [9:0] APPLE
);
    reg [9:0] apple;
    assign APPLE = apple;
    
    reg dff_0, dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8, dff_9;
    wire in_0, in_1, in_2, in_3, in_4, in5, in_6, in_7, in_8, in_9;

    assign in_1 = dff_0;
    assign in_2 = dff_1;
    assign in_3 = dff_2;
    assign in_4 = dff_3;
    assign in_5 = dff_4;
    assign in_6 = dff_5;
    assign in_7 = dff_6;
    assign in_8 = dff_7;
    assign in_9 = dff_8;
    assign in_0 = dff_1 ^ dff_8;

    always @(posedge can) begin
        if({dff_0,dff_1,dff_2,dff_3,dff_4,dff_5,dff_6,dff_7,dff_8,dff_9}==10'b00000_00000) begin
            {dff_0,dff_1,dff_2,dff_3,dff_4,dff_5,dff_6,dff_7,dff_8,dff_9}<=10'b11111_11111;
        end
        else begin
            dff_0 <= in_0;
            dff_1 <= in_1;
            dff_2 <= in_2;
            dff_3 <= in_3;
            dff_4 <= in_4;
            dff_5 <= in_5;
            dff_6 <= in_6;
            dff_7 <= in_7;
            dff_8 <= in_8;
            dff_9 <= in_9;
        end
    end

    always @(can) begin
        if(can) begin
            apple={dff_0,dff_1,dff_2,dff_3,dff_4,{dff_5,dff_6,dff_7,dff_8,dff_9}%5'd23};
        end
        else begin
            apple = 10'b11111_11111; //不顯示在屏幕上
        end
    end 


endmodule