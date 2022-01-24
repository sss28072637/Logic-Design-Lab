`define sil 32'd50000000 // slience

module Clock_divider #(parameter n=25) (
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

module debounce (pb_debounced, pb, clk);

    output pb_debounced;
    input pb;
    input clk;

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        shift_reg[3:1] <= shift_reg[2:0];
        shift_reg[0] <= pb;
    end

    assign pb_debounced = ((shift_reg == 4'b1111) ? 1'b1 : 1'b0);

endmodule

module onepulse(
    input wire rst,
    input wire clk,
    input wire pb_debounced,
    output reg pb_1pulse
);

    reg pb_1pulse_next;
    reg pb_debounced_delay;

    always @(*) begin
        pb_1pulse_next = pb_debounced & ~pb_debounced_delay;
    end

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            pb_1pulse <= 1'b0;
            pb_debounced_delay <= 1'b0;
        end
        else begin
            pb_1pulse <= pb_1pulse_next;
            pb_debounced_delay <= pb_debounced;
        end
    end
endmodule

module note_gen(
    clk, // clock from crystal
    rst, // active high reset
    vol, 
    note_div_left, // div for note generation
    note_div_right,
    audio_left,
    audio_right
);

    // I/O declaration
    input clk; // clock from crystal
    input rst; // active low reset
    input [2:0] vol;
    input [21:0] note_div_left, note_div_right; // div for note generation
    output [15:0] audio_left, audio_right;

    // Declare internal signals
    reg [21:0] clk_cnt_next, clk_cnt;
    reg [21:0] clk_cnt_next_2, clk_cnt_2;
    reg b_clk, b_clk_next;
    reg c_clk, c_clk_next;

    // Note frequency generation
    // clk_cnt, clk_cnt_2, b_clk, c_clk
    always @(posedge clk or posedge rst)
        if (rst == 1'b1)
            begin
                clk_cnt <= 22'd0;
                clk_cnt_2 <= 22'd0;
                b_clk <= 1'b0;
                c_clk <= 1'b0;
            end
        else
            begin
                clk_cnt <= clk_cnt_next;
                clk_cnt_2 <= clk_cnt_next_2;
                b_clk <= b_clk_next;
                c_clk <= c_clk_next;
            end
    
    // clk_cnt_next, b_clk_next
    always @*
        if (clk_cnt == note_div_left)
            begin
                clk_cnt_next = 22'd0;
                b_clk_next = ~b_clk;
            end
        else
            begin
                clk_cnt_next = clk_cnt + 1'b1;
                b_clk_next = b_clk;
            end

    // clk_cnt_next_2, c_clk_next
    always @*
        if (clk_cnt_2 == note_div_right)
            begin
                clk_cnt_next_2 = 22'd0;
                c_clk_next = ~c_clk;
            end
        else
            begin
                clk_cnt_next_2 = clk_cnt_2 + 1'b1;
                c_clk_next = c_clk;
            end

    // Assign the amplitude of the note
    // Volume is controlled here
    assign audio_left = (note_div_left == 22'd1 || vol==0) ? 16'h0000 : 
                                (b_clk == 1'b0) ? (vol==1) ? 16'hE000 : 
                                                  (vol==2) ? 16'hD000 :
                                                  (vol==3) ? 16'hC000 :
                                                  (vol==4) ? 16'hB000 : 16'hA000 : (vol==1) ? 16'h2000 :
                                                                                   (vol==2) ? 16'h3000 :
                                                                                   (vol==3) ? 16'h4000 :
                                                                                   (vol==4) ? 16'h5000 : 16'h6000;
    assign audio_right = (note_div_right == 22'd1 || vol==0) ? 16'h0000 : 
                                (c_clk == 1'b0) ? (vol==1) ? 16'hE000 : 
                                                  (vol==2) ? 16'hD000 :
                                                  (vol==3) ? 16'hC000 :
                                                  (vol==4) ? 16'hB000 : 16'hA000 : (vol==1) ? 16'h2000 :
                                                                                   (vol==2) ? 16'h3000 :
                                                                                   (vol==3) ? 16'h4000 :
                                                                                   (vol==4) ? 16'h5000 : 16'h6000;
                        
endmodule

module player_control (
	input clk, 
	input reset,
    input state,
    output reg [3:0] cnt,
	output reg [11:0] ibeat
);
	parameter LEN = 4095;
    reg [11:0] next_ibeat;
    reg [3:0] next_cnt;
    reg now_state;
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			ibeat <= 0;
            cnt <= 0;
            now_state <= 0;
		end else begin
            ibeat <= next_ibeat;
            cnt <= next_cnt;
            now_state <= state;
		end
	end
	always @* begin
        if(now_state != state) begin
            next_ibeat = 0;
            next_cnt = 0;
        end
        else if(state) begin
            if(ibeat + 1 < LEN) begin
                next_ibeat = ibeat + 1;
                next_cnt = cnt;
            end
            else begin
                next_ibeat = 0;
                next_cnt = cnt + 1;
            end
        end
        else begin
            next_ibeat = 0;
            next_cnt = 0;
        end
    end

endmodule

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
    output [16:0] pixel_addr
);

    assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1))% 76800;  //640*480 --> 320*240 
    
endmodule

module final_project (
    input clk,
    input rst,
    input money_up,
    input echo1,
    input echo5,
    input echo10,
    input btnU,
    inout PS2_CLK,
    inout PS2_DATA,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    output [3:0] DIGIT,
    output [6:0] DISPLAY,
    output [15:0] led,
    output trig1,
    output trig5,
    output trig10
);

    parameter MENU = 2'd0;
    parameter INSERT = 2'd1;
    parameter GAME = 2'd2;
    
    wire [11:0] data0, data1;
    wire clk_25MHz;
    wire clk_22;
    wire [16:0] pixel_addr;
    wire [11:0] menu, setting, choose;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

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

    parameter [8:0] KEY_CODES [0:4] = {
		9'b0_0001_0110, //4D => 1
        9'b0_0001_1110, //5A => 2
        9'b0_0010_0110, //21 => 3
        9'b0_0100_1001, //49 => >
        9'b0_0100_1010  //4A => /
	};

    always @ (*) begin
		case (last_change)
			KEY_CODES[00] : key_num = 4'b0000;
			KEY_CODES[01] : key_num = 4'b0001;
            KEY_CODES[02] : key_num = 4'b0010;
            KEY_CODES[03] : key_num = 4'b0011;
            KEY_CODES[04] : key_num = 4'b0100;
			default		  : key_num = 4'b1111;
		endcase
	end

    wire [15:0] audio_in_left, audio_in_right;
    wire [11:0] ibeatNum;
    wire [21:0] freq_outL, freq_outR;
    wire [31:0] freqL, freqR, freqL_havana, freqR_havana, freqL_105, freqR_105, freqL_LR, freqR_LR;
    reg [2:0] vol, vol_next;

    wire [19:0] distance1, distance5, distance10;

    sonic_top Five(
        .clk(clk), 
        .rst(rst), 
        .Echo(echo5), 
        .Trig(trig5),
        .distance(distance5)
    );

    sonic_top One(
        .clk(clk), 
        .rst(rst), 
        .Echo(echo1), 
        .Trig(trig1),
        .distance(distance1)
    );  

    sonic_top Ten(
        .clk(clk), 
        .rst(rst), 
        .Echo(echo10),
        .Trig(trig10),
        .distance(distance10)
    );      

    speaker_control sc(
        .clk(clk), 
        .rst(rst), 
        .audio_in_left(audio_in_left),      // left channel audio data input
        .audio_in_right(audio_in_right),    // right channel audio data input
        .audio_mclk(audio_mclk),            // master clock
        .audio_lrck(audio_lrck),            // left-right clock
        .audio_sck(audio_sck),              // serial clock
        .audio_sdin(audio_sdin)             // serial audio data input
    );

    note_gen noteGen_00(
        .clk(clk), 
        .rst(rst), 
        .vol(vol),
        .note_div_left(freq_outL), 
        .note_div_right(freq_outR), 
        .audio_left(audio_in_left),     // left sound audio
        .audio_right(audio_in_right)    // right sound audio
    );
    
    wire clk_21;
    Clock_divider #(.n(21)) clk_21_module (
        .clk(clk),
        .clk_div(clk_21)
    );

    wire clk_20;
    Clock_divider #(.n(20)) clk_20_module (
        .clk(clk),
        .clk_div(clk_20)
    );

    

    assign freq_outL = 50000000 / freqL;
    assign freq_outR = 50000000 / freqR;

    assign freqL =  (song==4'd1) ? 2*freqL_105 : 
                    (song==4'd2) ? freqL_havana : 
                    (song==4'd3) ? freqL_LR : `sil;

    assign freqR =  (song==4'd1) ? 2*freqR_105 : 
                    (song==4'd2) ? freqR_havana : 
                    (song==4'd3) ? freqR_LR : `sil;

    wire en;
    assign en = (state==GAME) ? 1 : 0;

    wire [3:0] cnt;
    wire clk_song;
    assign clk_song =   (song==4'd1) ? clk_21 : 
                        (song==4'd2) ? clk_22 : clk_22;
    player_control #(.LEN(511)) playerCtrl_00 ( 
        .clk(clk_song),
        .reset(rst),
        .cnt(cnt),
        .state(en),
        .ibeat(ibeatNum)
    );

    SongOf105 music_01 (
        .ibeatNum(ibeatNum),
        .en(1),
        .toneL(freqL_105),
        .toneR(freqR_105)
    );

    Havana music_02 (
        .ibeatNum(ibeatNum),
        .en(1),
        .toneL(freqL_havana),
        .toneR(freqR_havana)
    );

    LightlyRow music_03 (
        .ibeatNum(ibeatNum),
        .en(1),
        .toneL(freqL_LR),
        .toneR(freqR_LR)
    );

    //volume
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            vol <= 3'd3;
        end
        else begin
            vol <= vol_next;
        end
    end
    always @* begin
        if(been_ready && key_down[last_change]==1'b1) begin
            if(key_num == 4'b0100) begin
                vol_next = (vol==3'd1) ? vol : vol + 3'd1;
            end 
            else if(key_num == 4'b0011) begin
                vol_next = (vol==3'd5) ? vol : vol - 3'd1;
            end
            else begin
                vol_next = vol;
            end
        end
        else begin
            vol_next = vol;
        end
    end

    //money
    wire UP_temp, UP, button_clk;
    Clock_divider #(.n(13)) btn_clk(.clk(clk), .clk_div(button_clk));
    debounce MONEY_UP(.pb_debounced(UP_temp), .pb(money_up), .clk(button_clk));
    onepulse MONEY_UP1P(.rst(rst), .clk(button_clk), .pb_debounced(UP_temp), .pb_1pulse(UP));

    wire btnu_temp, btnu;
    debounce MONEY_DOWN(.pb_debounced(btnu_temp), .pb(btnU), .clk(button_clk));
    onepulse MONEY_DOWN1P(.rst(rst), .clk(button_clk), .pb_debounced(btnu_temp), .pb_1pulse(btnu));
    
    

    wire clk_30;
    Clock_divider #(.n(30)) CLK30(.clk(clk), .clk_div(clk_30));

    wire clk_26;
    Clock_divider #(.n(26)) CLK26(.clk(clk), .clk_div(clk_26));

    wire clk_27;
    Clock_divider #(.n(27)) CLK27(.clk(clk), .clk_div(clk_27));

    wire clk_28;
    Clock_divider #(.n(28)) CLK28(.clk(clk), .clk_div(clk_28));

    reg [19:0] distance_now5, distance_now1, distance_now10;
    always @(posedge clk_25MHz) begin
        distance_now1 <= distance1;
        distance_now5 <= distance5;
        distance_now10 <= distance10;
    end

    reg [3:0] money0, money0_next, money1, money1_next;
    always @(posedge clk_28 or posedge rst) begin
        if(rst) begin
            money0 <= 4'd0;
            money1 <= 4'd0;
        end
        else begin
            money0 <= money0_next;
            money1 <= money1_next;
        end
    end
    always @* begin
        case(state)
            MENU: begin
                money0_next = 4'd0;
                money1_next = 4'd0;
            end
            INSERT: begin
                if(distance_now5 != distance5) begin
                    money0_next = (money0 < 4'd5) ? money0 + 4'd5 : money0 - 4'd5;
                    money1_next = (money0 > 4'd4) ? money1 + 4'd1 : money1;
                end
                else if(distance_now10 != distance10) begin
                    money0_next = money0;
                    money1_next = money1 + 4'd1;
                end
                else if(distance_now1 != distance1) begin
                    money0_next = (money0 == 4'd9) ? 4'd0 : money0 + 4'd1;
                    money1_next = (money0 == 4'd9) ? money1 + 4'd1 : money1;
                end
                else begin
                    money0_next = money0;
                    money1_next = money1;
                end
            end
            GAME: begin
                money0_next = 4'd0;
                money1_next = 4'd0;
            end
        endcase
    end

    //price
    reg [3:0] price0, price0_next, price1, price1_next;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            price0 <= 4'd0;
            price1 <= 4'd0;
        end
        else begin
            price0 <= price0_next;
            price1 <= price1_next;
        end
    end
    always @* begin
        case(state)
            MENU: begin
                if(song == 4'd1) begin
                    price0_next = 4'd5;
                    price1_next = 4'd2;
                end
                else if(song == 4'd2) begin
                    price0_next = 4'd5;
                    price1_next = 4'd3;
                end
                else if(song == 4'd3) begin
                    price0_next = 4'd0;
                    price1_next = 4'd4;
                end
                else begin
                    price0_next <= price0;
                    price1_next <= price1;
                end
            end
            INSERT: begin
                if(song == 4'd1) begin
                    price0_next = 4'd5;
                    price1_next = 4'd2;
                end
                else if(song == 4'd2) begin
                    price0_next = 4'd5;
                    price1_next = 4'd3;
                end
                else if(song == 4'd3) begin
                    price0_next = 4'd0;
                    price1_next = 4'd4;
                end
                else begin
                    price0_next <= price0;
                    price1_next <= price1;
                end
            end
            GAME: begin
                price0_next <= 4'd0;
                price1_next <= 4'd0;
            end
        endcase
    end

    //state
    reg [4:0] state, next_state;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            state <= MENU;
        end
        else begin
            state <= next_state;
        end
    end
    always @* begin
        case(state)
            MENU: begin
                if(song != 4'd0) begin
                    next_state = INSERT;
                end
                else begin
                    next_state = state;
                end
            end
            INSERT: begin
                if((money0 >= price0 && money1 >= price1) || (money1 > price1)) begin
                    if(money0 != 4'd0 || money1 != 4'd0) begin
                        next_state = GAME;
                    end
                    else begin
                        next_state = state;
                    end
                end
                else begin
                    next_state = state;
                end
            end
            GAME: begin
                if(cnt == 2) begin
                    next_state = MENU;
                end
                else begin
                    next_state = state;
                end
            end
            default: next_state = state;
        endcase 
    end

    //choose songs
    reg [3:0] song, song_next;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            song <= 4'd0;
        end
        else begin
            song <= song_next;
        end
    end
    always @* begin
        case(state)
            MENU: begin
                if(been_ready && key_down[last_change]==1'b1) begin
                    if(key_num == 4'b0000) begin
                        song_next = 4'd1;
                    end
                    else if(key_num == 4'b0001) begin
                        song_next = 4'd2;
                    end
                    else if(key_num == 4'b0010) begin
                        song_next = 4'd3;
                    end
                    else begin
                        song_next = song;
                    end
                end
                else begin
                    song_next = song;
                end 
            end
            GAME: begin
                if(cnt == 2) begin
                    song_next = 4'd0;
                end
                else begin
                    song_next = song;
                end
            end
            default: begin
                song_next = song;
            end
        endcase
    end

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? menu : 12'b0;

    clock_divider clk_wiz_0_inst(
        .clk(clk),
        .clk1(clk_25MHz),
        .clk22(clk_22)
    );

    mem_addr_gen mem_addr_gen_inst(
        .clk(clk_22),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .pixel_addr(pixel_addr)
    );

    blk_mem_gen_0 blk_mem_gen_0_inst(
        .clka(clk_25MHz),
        .wea(0),
        .addra(pixel_addr),
        .dina(data0[11:0]),
        .douta(menu)
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

    //LED
    reg [15:0] LED_now;
    assign led = LED_now;
    always @(posedge CLK_DISPLAY or posedge rst) begin
        if(rst) begin
            LED_now <= 16'b0000_0000_0000_0000;
        end
        else begin
            case(song)
                4'd0: LED_now[15:12] <= 4'b0000;
                4'd1: LED_now[15:12] <= 4'b1000;
                4'd2: LED_now[15:12] <= 4'b1100;
                4'd3: LED_now[15:12] <= 4'b1110;
                default: LED_now[15:12] <= 4'b1111;
            endcase

            case(vol)
                3'd1: LED_now[4:0] <= 5'b00001;
                3'd2: LED_now[4:0] <= 5'b00011;
                3'd3: LED_now[4:0] <= 5'b00111;
                3'd4: LED_now[4:0] <= 5'b01111;
                3'd5: LED_now[4:0] <= 5'b11111;
            endcase

            LED_now[11:5] <= 7'b000_0000;
        end
    end

    reg [3:0] DIGIT_now;
    reg [6:0] DISPLAY_now;
    reg [6:0] value;

    wire CLK_DISPLAY;
    Clock_divider #(.n(10)) clk_dis(.clk(clk), .clk_div(CLK_DISPLAY));

    assign DIGIT = DIGIT_now;
    assign DISPLAY = DISPLAY_now;

    always @(posedge CLK_DISPLAY) begin
        case (DIGIT)
            4'b1110: begin
                value = (state == MENU) ? 4'd10 : price1;
                DIGIT_now = 4'b1101;
            end
            4'b1101: begin
                value = (state == MENU) ? 4'd10 : money0;
                DIGIT_now = 4'b1011;
            end
            4'b1011: begin
                value = (state == MENU) ? 4'd10 : money1;
                DIGIT_now = 4'b0111;
            end
            4'b0111: begin
                value = (state == MENU) ? 4'd10 : price0;
                DIGIT_now = 4'b1110;
            end
            default: begin
                value = 4'd11;
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
        endcase
    end

endmodule