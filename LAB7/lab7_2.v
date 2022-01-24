module clock_divider(clk1, clk);
    input clk;
    output clk1;

    reg [1:0] num;
    wire [1:0] next_num;

    always @(posedge clk) begin
        num <= next_num;
    end

    assign next_num = num + 1'b1;
    assign clk1 = num[1];

endmodule

module lab7_2(
    input clk,
    input rst,
    input hold,
    inout PS2_CLK,
    inout PS2_DATA,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync,
    output pass
);    
	reg [15:0] nums;
	reg [3:0] key_num;
	reg [9:0] last_key;
	
	wire shift_down;
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;

    KeyboardDecoder key_de (
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(been_ready),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);

    parameter [8:0] LEFT_SHIFT_CODES  = 9'b0_0001_0010;
	parameter [8:0] RIGHT_SHIFT_CODES = 9'b0_0101_1001;
	parameter [8:0] KEY_CODES [0:11] = {
		9'b0_0100_0100,	// O => 44
		9'b0_0100_1101,	// P => 4D
		9'b0_0101_0100,	// [{ => 54
		9'b0_0101_1011,	// }] => 5B
		9'b0_0100_0010,	// K => 42
		9'b0_0100_1011,	// L => 4B
		9'b0_0100_1100,	// :; => 4C
		9'b0_0101_0010,	// "' => 52
		9'b0_0011_1010,	// M => 3A
		9'b0_0100_0001,	// <, => 41
		9'b0_0100_1001, // >. => 49
		9'b0_0100_1010 // /? => 4A
	};
	
	assign shift_down = (key_down[LEFT_SHIFT_CODES] == 1'b1 || key_down[RIGHT_SHIFT_CODES] == 1'b1) ? 1'b1 : 1'b0;

    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

    clock_divider clk_wiz_0_inst(
        .clk(clk),
        .clk1(clk_25MHz)
    );

    vga_controller vga_inst(
        .pclk(clk_25MHz),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
    );

    blk_mem_gen_0 blk_mem_gen_0_inst(
        .clka(clk_25MHz),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(pixel)
    );

    wire [9:0] T180_H;
    assign T180_H = (h_cnt < 160 && v_cnt < 160) ? (160 - 1) - (h_cnt - 0) + 0 :
                    (h_cnt < 320 && v_cnt < 160) ? (160 - 1) - (h_cnt - 160) + 160 :
                    (h_cnt < 480 && v_cnt < 160) ? (160 - 1) - (h_cnt - 320) + 320 :
                    (h_cnt < 640 && v_cnt < 160) ? (160 - 1) - (h_cnt - 480) + 480 :
                    (h_cnt < 160 && v_cnt < 320) ? (160 - 1) - (h_cnt - 0) + 0 :
                    (h_cnt < 320 && v_cnt < 320) ? (160 - 1) - (h_cnt - 160) + 160 :
                    (h_cnt < 480 && v_cnt < 320) ? (160 - 1) - (h_cnt - 320) + 320 :
                    (h_cnt < 640 && v_cnt < 320) ? (160 - 1) - (h_cnt - 480) + 480 :
                    (h_cnt < 160 && v_cnt < 480) ? (160 - 1) - (h_cnt - 0) + 0 :
                    (h_cnt < 320 && v_cnt < 480) ? (160 - 1) - (h_cnt - 160) + 160 :
                    (h_cnt < 480 && v_cnt < 480) ? (160 - 1) - (h_cnt - 320) + 320 :
                    (h_cnt < 640 && v_cnt < 480) ? (160 - 1) - (h_cnt - 480) + 480 : h_cnt;

    wire [9:0] T180_V;
    assign T180_V = (h_cnt < 160 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 0 :
                    (h_cnt < 320 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 0 :
                    (h_cnt < 480 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 0 :
                    (h_cnt < 640 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 0 :
                    (h_cnt < 160 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 160 :
                    (h_cnt < 320 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 160 :
                    (h_cnt < 480 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 160 :
                    (h_cnt < 640 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 160 :
                    (h_cnt < 160 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 320 :
                    (h_cnt < 320 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 320 :
                    (h_cnt < 480 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 320 :
                    (h_cnt < 640 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 320 : v_cnt;

    wire [9:0] CW_H;
    assign CW_H =   (h_cnt < 160 && v_cnt < 160) ? (v_cnt + 0 - 0) :
                    (h_cnt < 320 && v_cnt < 160) ? (v_cnt + 160 - 0) :
                    (h_cnt < 480 && v_cnt < 160) ? (v_cnt + 320 - 0) :
                    (h_cnt < 640 && v_cnt < 160) ? (v_cnt + 480 - 0) :
                    (h_cnt < 160 && v_cnt < 320) ? (v_cnt + 0 - 160) :
                    (h_cnt < 320 && v_cnt < 320) ? (v_cnt + 160 - 160) :
                    (h_cnt < 480 && v_cnt < 320) ? (v_cnt + 320 - 160) :
                    (h_cnt < 640 && v_cnt < 320) ? (v_cnt + 480 - 160) :
                    (h_cnt < 160 && v_cnt < 480) ? (v_cnt + 0 - 320) :
                    (h_cnt < 320 && v_cnt < 480) ? (v_cnt + 160 - 320) :
                    (h_cnt < 480 && v_cnt < 480) ? (v_cnt + 320 - 320) :
                    (h_cnt < 640 && v_cnt < 480) ? (v_cnt + 480 - 320) : h_cnt;

    wire [9:0] CW_V;
    assign CW_V =   (h_cnt < 160 && v_cnt < 160) ? (160 - 1) - (h_cnt - 0) + 0 :
                    (h_cnt < 320 && v_cnt < 160) ? (160 - 1) - (h_cnt - 160) + 0 :
                    (h_cnt < 480 && v_cnt < 160) ? (160 - 1) - (h_cnt - 320) + 0 :
                    (h_cnt < 640 && v_cnt < 160) ? (160 - 1) - (h_cnt - 480) + 0 :
                    (h_cnt < 160 && v_cnt < 320) ? (160 - 1) - (h_cnt - 0) + 160 :
                    (h_cnt < 320 && v_cnt < 320) ? (160 - 1) - (h_cnt - 160) + 160 :
                    (h_cnt < 480 && v_cnt < 320) ? (160 - 1) - (h_cnt - 320) + 160 :
                    (h_cnt < 640 && v_cnt < 320) ? (160 - 1) - (h_cnt - 480) + 160 :
                    (h_cnt < 160 && v_cnt < 480) ? (160 - 1) - (h_cnt - 0) + 320 :
                    (h_cnt < 320 && v_cnt < 480) ? (160 - 1) - (h_cnt - 160) + 320 :
                    (h_cnt < 480 && v_cnt < 480) ? (160 - 1) - (h_cnt - 320) + 320 :
                    (h_cnt < 640 && v_cnt < 480) ? (160 - 1) - (h_cnt - 480) + 320 : v_cnt;

    wire [9:0] CCW_H;
    assign CCW_H =  (h_cnt < 160 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 0 :
                    (h_cnt < 320 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 160 :
                    (h_cnt < 480 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 320 :
                    (h_cnt < 640 && v_cnt < 160) ? (160 - 1) - (v_cnt - 0) + 480 :
                    (h_cnt < 160 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 0 :
                    (h_cnt < 320 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 160 :
                    (h_cnt < 480 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 320 :
                    (h_cnt < 640 && v_cnt < 320) ? (160 - 1) - (v_cnt - 160) + 480 :
                    (h_cnt < 160 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 0 :
                    (h_cnt < 320 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 160 :
                    (h_cnt < 480 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 320 :
                    (h_cnt < 640 && v_cnt < 480) ? (160 - 1) - (v_cnt - 320) + 480 : h_cnt;

    wire [9:0] CCW_V;
    assign CCW_V =  (h_cnt < 160 && v_cnt < 160) ? h_cnt - 0 + 0 :
                    (h_cnt < 320 && v_cnt < 160) ? h_cnt - 160 + 0 :
                    (h_cnt < 480 && v_cnt < 160) ? h_cnt - 320 + 0 :
                    (h_cnt < 640 && v_cnt < 160) ? h_cnt - 480 + 0 :
                    (h_cnt < 160 && v_cnt < 320) ? h_cnt - 0 + 160 :
                    (h_cnt < 320 && v_cnt < 320) ? h_cnt - 160 + 160 :
                    (h_cnt < 480 && v_cnt < 320) ? h_cnt - 320 + 160 :
                    (h_cnt < 640 && v_cnt < 320) ? h_cnt - 480 + 160 :
                    (h_cnt < 160 && v_cnt < 480) ? h_cnt - 0 + 320 :
                    (h_cnt < 320 && v_cnt < 480) ? h_cnt - 160 + 320 :
                    (h_cnt < 480 && v_cnt < 480) ? h_cnt - 320 + 320 :
                    (h_cnt < 640 && v_cnt < 480) ? h_cnt - 480 + 320 : v_cnt;

    wire [16:0] pixel_addr_origin;
    wire [16:0] pixel_addr_cw;
    wire [16:0] pixel_addr_ccw;
    wire [16:0] pixel_addr_T180;
    assign pixel_addr_origin = ((h_cnt>>1)+320*(v_cnt>>1)) % 76800;
    assign pixel_addr_cw = ((CW_H>>1)+320*(CW_V>>1)) % 76800;
    assign pixel_addr_ccw = ((CCW_H>>1)+320*(CCW_V>>1)) % 76800;
    assign pixel_addr_T180 = ((T180_H>>1)+320*(T180_V>>1)) % 76800;

    reg [3:0] flip1, flip2, flip3, flip4, flip5, flip6, flip7, flip8, flip9, flip10, flip11, flip12;
    reg [3:0] flip1_next, flip2_next, flip3_next, flip4_next, flip5_next, flip6_next, flip7_next, flip8_next, flip9_next, flip10_next, flip11_next, flip12_next;
    
    reg PASS;
    assign pass = PASS;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            PASS <= 0;
        end
        else begin
            if(!flip1 && !flip2 && !flip3 && !flip4 && !flip5 && !flip6) begin
                if(!flip7 && !flip8 && !flip9 && !flip10 && !flip11 && !flip12) begin
                    PASS <= 1;
                end
                else begin
                    PASS <= 0;
                end
            end
            else begin
                PASS <= PASS;
            end
        end
    end

    wire [16:0] INITIAL;
    assign INITIAL =    (h_cnt < 160 && v_cnt < 160) ? pixel_addr_ccw :
                        (h_cnt < 320 && v_cnt < 160) ? pixel_addr_cw :
                        (h_cnt < 480 && v_cnt < 160) ? pixel_addr_origin :
                        (h_cnt < 640 && v_cnt < 160) ? pixel_addr_ccw :
                        (h_cnt < 160 && v_cnt < 320) ? pixel_addr_cw :
                        (h_cnt < 320 && v_cnt < 320) ? pixel_addr_origin :
                        (h_cnt < 480 && v_cnt < 320) ? pixel_addr_ccw :
                        (h_cnt < 640 && v_cnt < 320) ? pixel_addr_origin :
                        (h_cnt < 160 && v_cnt < 480) ? pixel_addr_cw :
                        (h_cnt < 320 && v_cnt < 480) ? pixel_addr_ccw :
                        (h_cnt < 480 && v_cnt < 480) ? pixel_addr_cw :
                        (h_cnt < 640 && v_cnt < 480) ? pixel_addr_origin : pixel_addr_cw;

    wire [16:0] HINT;
    assign HINT =   (h_cnt < 160 && v_cnt < 160) ? pixel_addr_origin :
                    (h_cnt < 320 && v_cnt < 160) ? pixel_addr_origin :
                    (h_cnt < 480 && v_cnt < 160) ? pixel_addr_origin :
                    (h_cnt < 640 && v_cnt < 160) ? pixel_addr_origin :
                    (h_cnt < 160 && v_cnt < 320) ? pixel_addr_origin :
                    (h_cnt < 320 && v_cnt < 320) ? pixel_addr_origin :
                    (h_cnt < 480 && v_cnt < 320) ? pixel_addr_origin :
                    (h_cnt < 640 && v_cnt < 320) ? pixel_addr_origin :
                    (h_cnt < 160 && v_cnt < 480) ? pixel_addr_origin :
                    (h_cnt < 320 && v_cnt < 480) ? pixel_addr_origin :
                    (h_cnt < 480 && v_cnt < 480) ? pixel_addr_origin :
                    (h_cnt < 640 && v_cnt < 480) ? pixel_addr_origin : pixel_addr_origin;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            flip1 <= -1;
            flip2 <= 1;
            flip3 <= 0;
            flip4 <= -1;
            flip5 <= 1;
            flip6 <= 0;
            flip7 <= -1;
            flip8 <= 0;
            flip9 <= 1;
            flip10 <= -1;
            flip11 <= 1;
            flip12 <= 0;
        end
        else begin
            flip1 <= flip1_next;
            flip2 <= flip2_next;
            flip3 <= flip3_next;
            flip4 <= flip4_next;
            flip5 <= flip5_next;
            flip6 <= flip6_next;
            flip7 <= flip7_next;
            flip8 <= flip8_next;
            flip9 <= flip9_next;
            flip10 <= flip10_next;
            flip11 <= flip11_next;
            flip12 <= flip12_next;
        end
    end
    always @* begin
        if(!PASS && been_ready && key_down[last_change]==1'b1) begin
            if(shift_down) begin //counter-clockwise
                if(key_num == 4'b0000) begin
                    flip1_next = (flip1-1)%4;
                end
                else if(key_num == 4'b0001) begin
                    flip2_next = (flip2-1)%4;
                end
                else if(key_num == 4'b0010) begin
                    flip3_next = (flip3-1)%4;
                end
                else if(key_num == 4'b0011) begin
                    flip4_next = (flip4-1)%4;
                end
                else if(key_num == 4'b0100) begin
                    flip5_next = (flip5-1)%4;
                end
                else if(key_num == 4'b0101) begin
                    flip6_next = (flip6-1)%4;
                end
                else if(key_num == 4'b0110) begin
                    flip7_next = (flip7-1)%4;
                end
                else if(key_num == 4'b0111) begin
                    flip8_next = (flip8-1)%4;
                end
                else if(key_num == 4'b1000) begin
                    flip9_next = (flip9-1)%4;
                end
                else if(key_num == 4'b1001) begin
                    flip10_next = (flip10-1)%4;
                end
                else if(key_num == 4'b1010) begin
                    flip11_next = (flip11-1)%4;
                end
                else if(key_num == 4'b1011) begin
                    flip12_next = (flip12-1)%4;
                end
                else begin
                    flip1_next = flip1;
                    flip2_next = flip2;
                    flip3_next = flip3;
                    flip4_next = flip4;
                    flip5_next = flip5;
                    flip6_next = flip6;
                    flip7_next = flip7;
                    flip8_next = flip8;
                    flip9_next = flip9;
                    flip10_next = flip10;
                    flip11_next = flip11;
                    flip12_next = flip12;
                end
            end
            else begin
                if(key_num == 4'b0000) begin
                    flip1_next = (flip1+1)%4;
                end
                else if(key_num == 4'b0001) begin
                    flip2_next = (flip2+1)%4;
                end
                else if(key_num == 4'b0010) begin
                    flip3_next = (flip3+1)%4;
                end
                else if(key_num == 4'b0011) begin
                    flip4_next = (flip4+1)%4;
                end
                else if(key_num == 4'b0100) begin
                    flip5_next = (flip5+1)%4;
                end
                else if(key_num == 4'b0101) begin
                    flip6_next = (flip6+1)%4;
                end
                else if(key_num == 4'b0110) begin
                    flip7_next = (flip7+1)%4;
                end
                else if(key_num == 4'b0111) begin
                    flip8_next = (flip8+1)%4;
                end
                else if(key_num == 4'b1000) begin
                    flip9_next = (flip9+1)%4;
                end
                else if(key_num == 4'b1001) begin
                    flip10_next = (flip10+1)%4;
                end
                else if(key_num == 4'b1010) begin
                    flip11_next = (flip11+1)%4;
                end
                else if(key_num == 4'b1011) begin
                    flip12_next = (flip12+1)%4;
                end
                else begin
                    flip1_next = flip1;
                    flip2_next = flip2;
                    flip3_next = flip3;
                    flip4_next = flip4;
                    flip5_next = flip5;
                    flip6_next = flip6;
                    flip7_next = flip7;
                    flip8_next = flip8;
                    flip9_next = flip9;
                    flip10_next = flip10;
                    flip11_next = flip11;
                    flip12_next = flip12;
                end
            end
        end
        else begin
            flip1_next = flip1;
            flip2_next = flip2;
            flip3_next = flip3;
            flip4_next = flip4;
            flip5_next = flip5;
            flip6_next = flip6;
            flip7_next = flip7;
            flip8_next = flip8;
            flip9_next = flip9;
            flip10_next = flip10;
            flip11_next = flip11;
            flip12_next = flip12;
        end
    end

    reg [16:0] GAME, GAME_next;
    always @(posedge clk_25MHz or posedge rst) begin
        if(rst) begin
            GAME <= INITIAL;
        end
        else begin
            GAME <= GAME_next;
        end
    end
    always @* begin
        if(PASS) begin
            GAME_next = HINT;
        end
        else begin
            if(0 <= h_cnt && h_cnt < 160 && 0 <= v_cnt && v_cnt < 160) begin
                if(flip1==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip1==1 || flip1==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip1==2 || flip1==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip1==3 || flip1==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(160 <= h_cnt && h_cnt < 320 && 0 <= v_cnt && v_cnt < 160) begin
                if(flip2==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip2==1 || flip2==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip2==2 || flip2==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip2==3 || flip2==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(320 <= h_cnt && h_cnt < 480 && 0 <= v_cnt && v_cnt < 160) begin
                if(flip3==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip3==1 || flip3==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip3==2 || flip3==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip3==3 || flip3==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(480 <= h_cnt && h_cnt < 640 && 0 <= v_cnt && v_cnt < 160) begin
                if(flip4==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip4==1 || flip4==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip4==2 || flip4==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip4==3 || flip4==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(0 <= h_cnt && h_cnt < 160 && 160 <= v_cnt && v_cnt < 320) begin
                if(flip5==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip5==1 || flip5==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip5==2 || flip5==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip5==3 || flip5==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(160 <= h_cnt && h_cnt < 320 && 160 <= v_cnt && v_cnt < 320) begin
                if(flip6==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip6==1 || flip6==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip6==2 || flip6==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip6==3 || flip6==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(320 <= h_cnt && h_cnt < 480 && 160 <= v_cnt && v_cnt < 320) begin
                if(flip7==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip7==1 || flip7==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip7==2 || flip7==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip7==3 || flip7==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(480 <= h_cnt && h_cnt < 640 && 160 <= v_cnt && v_cnt < 320) begin
                if(flip8==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip8==1 || flip8==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip8==2 || flip8==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip8==3 || flip8==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(0 <= h_cnt && h_cnt < 160 && 320 <= v_cnt && v_cnt < 480) begin
                if(flip9==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip9==1 || flip9==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip9==2 || flip9==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip9==3 || flip9==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(160 <= h_cnt && h_cnt < 320 && 320 <= v_cnt && v_cnt < 480) begin
                if(flip10==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip10==1 || flip10==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip10==2 || flip10==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip10==3 || flip10==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(320 <= h_cnt && h_cnt < 480 && 320 <= v_cnt && v_cnt < 480) begin
                if(flip11==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip11==1 || flip11==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip11==2 || flip11==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip11==3 || flip11==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else if(480 <= h_cnt && h_cnt < 640 && 320 <= v_cnt && v_cnt < 480) begin
                if(flip12==0) begin
                    GAME_next = pixel_addr_origin;
                end
                else if(flip12==1 || flip12==(-3)) begin
                    GAME_next = pixel_addr_cw;
                end
                else if(flip12==2 || flip12==(-2)) begin
                    GAME_next = pixel_addr_T180;
                end
                else if(flip12==3 || flip12==(-1)) begin
                    GAME_next = pixel_addr_ccw;
                end
                else begin
                    GAME_next = INITIAL;
                end 
            end
            else begin
                GAME_next = INITIAL;
            end
        end
    end

    assign pixel_addr = hold ? HINT : GAME;
    
    always @ (*) begin
		case (last_change)
			KEY_CODES[00] : key_num = 4'b0000;
			KEY_CODES[01] : key_num = 4'b0001;
			KEY_CODES[02] : key_num = 4'b0010;
			KEY_CODES[03] : key_num = 4'b0011;
			KEY_CODES[04] : key_num = 4'b0100;
			KEY_CODES[05] : key_num = 4'b0101;
			KEY_CODES[06] : key_num = 4'b0110;
			KEY_CODES[07] : key_num = 4'b0111;
			KEY_CODES[08] : key_num = 4'b1000;
			KEY_CODES[09] : key_num = 4'b1001;
			KEY_CODES[10] : key_num = 4'b1010;
			KEY_CODES[11] : key_num = 4'b1011;
			default		  : key_num = 4'b1111;
		endcase
	end

endmodule