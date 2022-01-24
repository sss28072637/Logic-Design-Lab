module keyboard_ctrl(
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire rst,
    input wire clk,
    input wire clk_25,
    output One,
    output Two,
    output Three,
    output Enter,
    output Up,
    output Down,
    output Right,
    output Left,
    output Esc
);

    parameter [8:0] KEY_CODES [0:8] = {
        9'h0_1D,	// W=> 1D             0 
		9'h0_1C,	// A => 1C            1      
		9'h0_1B,	// S => 1B            2     
		9'h0_23,    // D => 23            3  
		9'b0_0101_1010, // enter => 5A    4
        9'b0_0001_0110, //4D => 1         5
        9'b0_0001_1110, //5A => 2         6
        9'b0_0010_0110, //21 => 3         7
        9'h0_76         //esc => 76       8  
    };

    wire [511:0] key_down;

    KeyboardDecoder kb_dc(
        .key_down(key_down),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    wire esc;
    OnePulse ENter(esc, key_down[KEY_CODES[8]], clk_25);

    wire enter;
    OnePulse ESc(enter, key_down[KEY_CODES[4]], clk_25);
    
    wire up;
    OnePulse UP(up, key_down[KEY_CODES[0]], clk_25);

    wire left;
    OnePulse LEft(left, key_down[KEY_CODES[1]], clk_25);

    wire right;
    OnePulse RIght(right, key_down[KEY_CODES[3]], clk_25);

    wire down;
    OnePulse DOwn(down, key_down[KEY_CODES[2]], clk_25);

    wire one, two, three;
    OnePulse ONe(one, key_down[KEY_CODES[5]], clk_25);
    OnePulse TWo(two, key_down[KEY_CODES[6]], clk_25);
    OnePulse THree(three, key_down[KEY_CODES[7]], clk_25);


    assign Enter = enter;
    assign Up = up;
    assign Down = down;
    assign Right = right;
    assign Left = left;
    assign One = one;
    assign Two = two;
    assign Three = three;
    assign Esc = esc;

endmodule