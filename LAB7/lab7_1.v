module clock_divider(clk1, clk, clk22);
    input clk;
    output clk1;
    output clk22;
    reg [21:0] num;
    wire [21:0] next_num;

    always @(posedge clk) begin
        num <= next_num;
    end

    assign next_num = num + 1'b1;
    assign clk1 = num[1];
    assign clk22 = num[21];
endmodule


module mem_addr_gen(
    input clk,
    input rst,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input up_down,
    input en,
    output [16:0] pixel_addr
);
    
    reg [7:0] position, position_next;

    assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1)+ position*320 )% 76800;  //640*480 --> 320*240 

    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            position <= 0;
        end
        else begin
            position <= position_next;
        end
    end
    always @ (*) begin
        if(en) begin
            case(up_down)
                1: begin
                    if(position < 239)
                        position_next = position + 1;
                    else
                        position_next = 0;
                end
                0: begin
                    if(position > 0)
                        position_next = position - 1;
                    else
                        position_next = 239;
                end
            endcase
        end
        else begin
            position_next = position;
        end
    end
    
endmodule

module lab7_1 (
    input clk,
    input rst,
    input en,
    input dir,
    input nf,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync
);
    wire [16:0] pixel_up, pixel_down;
    wire up_down;
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire EN;

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? (nf?~pixel:pixel):12'h0;

    clock_divider clk_wiz_0_inst(
        .clk(clk),
        .clk1(clk_25MHz),
        .clk22(clk_22)
    );

    assign up_down = dir ? 0 : 1;
    assign EN = en ? 1 : 0;

    mem_addr_gen mem_addr_gen_inst(
        .clk(clk_22),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .pixel_addr(pixel_addr),
        .up_down(up_down),
        .en(EN)
    );

    blk_mem_gen_0 blk_mem_gen_0_inst(
        .clka(clk_25MHz),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(pixel)
    ); 

    vga_controller   vga_inst(
        .pclk(clk_25MHz),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
    );

endmodule