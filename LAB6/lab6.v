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

module lab06(
    input clk,
    input rst,
    inout PS2_CLK,
    inout PS2_DATA,
    output [3:0] DIGIT,
    output [6:0] DISPLAY,
    output [15:0] LED
);
    parameter [8:0] KEY_CODES [0:19] = {
		9'b0_0100_0101,	// 0 => 45
		9'b0_0001_0110,	// 1 => 16
		9'b0_0001_1110,	// 2 => 1E
		9'b0_0010_0110,	// 3 => 26
		9'b0_0010_0101,	// 4 => 25
		9'b0_0010_1110,	// 5 => 2E
		9'b0_0011_0110,	// 6 => 36
		9'b0_0011_1101,	// 7 => 3D
		9'b0_0011_1110,	// 8 => 3E
		9'b0_0100_0110,	// 9 => 46
		
		9'b0_0111_0000, // right_0 => 70
		9'b0_0110_1001, // right_1 => 69
		9'b0_0111_0010, // right_2 => 72
		9'b0_0111_1010, // right_3 => 7A
		9'b0_0110_1011, // right_4 => 6B
		9'b0_0111_0011, // right_5 => 73
		9'b0_0111_0100, // right_6 => 74
		9'b0_0110_1100, // right_7 => 6C
		9'b0_0111_0101, // right_8 => 75
		9'b0_0111_1101  // right_9 => 7D
	};

    reg [3:0] BCD0, BCD0_next;
    reg [3:0] BCD1, BCD1_next;
    reg [3:0] BCD2, BCD2_next;
    reg [3:0] BCD3, BCD3_next;
	
	reg [15:0] nums, nums_next;
	reg [3:0] key_num;
	reg [9:0] last_key;
	
	wire shift_down;
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;
    
    reg [3:0] DIGIT_now;
    reg [6:0] DISPLAY_now;
    reg [6:0] value;

    reg [1:0] finish, finish_next;

    assign DISPLAY = DISPLAY_now;
    assign DIGIT = DIGIT_now;
    assign LED = LED_now;

    wire CLK_DISPLAY;
    clock_divider #(.n(15)) clk_7(.clk(clk), .clk_div(CLK_DISPLAY));

    wire button_clk;
    clock_divider #(.n(13)) btn_clk(.clk(clk), .clk_div(button_clk));

    wire CLK_DIV;
    clock_divider #(.n(26)) CLK(.clk(clk), .clk_div(CLK_DIV));

    wire RST_temp, RST;
    debounce pbBTNL(.pb_debounced(RST_temp), .pb(rst), .clk(button_clk));
    onepulse opBTNL(.rst(rst), .clk(button_clk), .pb_debounced(RST_temp), .pb_1pulse(RST));
		
	KeyboardDecoder key_de (
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(been_ready),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(RST),
		.clk(clk)
	);

    parameter DRIVING = 3'b000;
    parameter GET_OFF = 3'b001;
    parameter GET_UP = 3'b010;
    parameter REFUEL = 3'b011;
    parameter STOP = 3'b100;
    parameter CONSUME = 3'b110;
    parameter MIDDLE = 3'b111;

    reg [2:0] state, next_state;
    reg [15:0] LED_now, LED_next;
    reg [1:0] passenger, passenger_next;
    reg [1:0] wait0_passenger, wait0_passenger_next, wait6_passenger, wait6_passenger_next;
    reg [8:0] revenue, revenue_next;
    reg [8:0] gas, gas_next;
    reg [1:0] up_down, up_down_next;
    reg [1:0] reach0, reach0_next, reach6, reach6_next;
    reg [3:0] pnum0, pnum0_next;
    reg [3:0] pnum6, pnum6_next;
    reg [8:0] GAS, REVENUE;

    always @(posedge CLK_DIV or posedge RST) begin
        if(RST) begin
            GAS <= 0;
        end
        else begin
            GAS <= (gas>20)?20:gas;
        end
    end

    always @(posedge CLK_DIV or posedge RST) begin
        if(RST) begin
            REVENUE <= 0;
        end
        else begin
            REVENUE <= revenue;
        end
    end

    
    always @(posedge clk or posedge RST) begin
        if(RST) begin
            state <= STOP;
        end
        else begin
            state <= next_state;
        end
    end
    always @(*) begin
        case(state)
            DRIVING: begin
                if(LED_now[6:0]==7'b0000001 && !up_down) begin
                    next_state = CONSUME;
                end
                else if(LED_now[6:0]==7'b1000000 && up_down) begin
                    next_state = CONSUME;
                end
                else if(LED_now[6:0]==7'b0001000 && passenger!=0 && !finish) begin
                    next_state = CONSUME;
                end
                else begin
                    next_state = state;
                end
            end
            GET_OFF: begin
                if(LED_now[6:0]==7'b0000001 && passenger==0 && wait0_passenger>0) begin
                    next_state = GET_UP;
                end
                else if(LED_now[6:0]==7'b1000000 && passenger==0 && wait6_passenger>0) begin
                    next_state = GET_UP;
                end
                else if(LED_now[6:0]==7'b0000001 && passenger==0 && wait0_passenger==0 && wait6_passenger>0) begin
                    next_state = DRIVING;
                end
                else if(LED_now[6:0]==7'b1000000 && passenger==0 && wait6_passenger==0 && wait0_passenger>0) begin
                    next_state = DRIVING;
                end
                else if(passenger==0 && wait0_passenger==0 && wait6_passenger==0) begin
                    next_state = STOP;
                end
                else begin
                    next_state = state;
                end
            end
            GET_UP: begin
                if(LED_now[6:0]==7'b0000001 && wait0_passenger==0) begin
                    next_state = REFUEL;
                end
                else if(LED_now[6:0]==7'b1000000 && wait6_passenger==0) begin
                    next_state = REFUEL;
                end
                else begin
                    next_state = state;
                end
            end
            REFUEL: begin
                next_state = DRIVING;
            end
            STOP: begin
                if(LED_now[6:0]==7'b0000001 && wait0_passenger>0 && wait6_passenger==0) begin
                    next_state = GET_OFF;
                end
                else if(LED_now[6:0]==7'b1000000 && wait0_passenger==0 && wait6_passenger>0) begin
                    next_state = GET_OFF;
                end
                else if(LED_now[6:0]==7'b0000001 && wait0_passenger==0 && wait6_passenger>0) begin
                    next_state = DRIVING;
                end
                else if(LED_now[6:0]==7'b1000000 && wait0_passenger>0 && wait6_passenger==0) begin
                    next_state = DRIVING;
                end
                else begin
                    next_state = state;
                end
            end
            CONSUME: begin
                if(LED_now[6:0]==7'b0001000) begin
                    next_state = REFUEL;
                end
                else if(LED_now[6:0]==7'b1000000 || LED_now[6:0]==7'b0000001) begin
                    next_state = GET_OFF;
                end
                else begin
                    next_state = DRIVING;
                end
            end
        endcase
    end

    always @(posedge clk or posedge RST) begin
        if(RST) begin
            pnum0 <= 0;
            pnum6 <= 0;
        end
        else begin
            pnum0 <= pnum0_next;
            pnum6 <= pnum6_next;
        end
    end
    always @(*) begin
        if(wait0_passenger>0 || wait6_passenger>0) begin
            pnum0_next = wait0_passenger;
            pnum6_next = wait6_passenger;
        end
        else begin
            pnum0_next = pnum0;
            pnum6_next = pnum6;
        end
    end

    always @(posedge clk or posedge RST) begin
        if(RST) begin
            up_down <= 1;
        end
        else begin
            up_down <= up_down_next;
        end
    end 
    always @(*) begin
        if(LED_now[6:0]==7'b1000000) begin
            up_down_next = 0;
        end
        else if(LED_now[6:0]==7'b0000001) begin
            up_down_next = 1;
        end
        else begin
            up_down_next = up_down;
        end
    end

    always @(posedge clk or posedge RST) begin
        if(RST) begin
            passenger <= 0;
            gas <= 0;
            wait0_passenger <= 0;
            wait6_passenger <= 0;
            finish <= 1;
            revenue <= 0;
        end
        else begin
            passenger <= passenger_next;
            gas <= gas_next;
            wait0_passenger <= wait0_passenger_next;
            wait6_passenger <= wait6_passenger_next;
            finish <= finish_next;
            revenue <= revenue_next;
        end
    end
    always @(*) begin
        if(been_ready && key_down[last_change] == 1'b1) begin
            if(key_num == 4'b0001) begin
                wait0_passenger_next = (wait0_passenger==2)?wait0_passenger:wait0_passenger+1;
                wait6_passenger_next = wait6_passenger;
            end
            else if(key_num == 4'b0010) begin
                wait0_passenger_next = wait0_passenger;
                wait6_passenger_next = (wait6_passenger==2)?wait6_passenger:wait6_passenger+1;
            end
            else begin
                wait0_passenger_next = wait0_passenger;
                wait6_passenger_next = wait6_passenger;
            end
        end
        else begin
            wait0_passenger_next = wait0_passenger;
            wait6_passenger_next = wait6_passenger;
        end
        case(state)
            DRIVING: begin
                passenger_next = passenger;
                gas_next = gas;
                finish_next = 0;
                revenue_next = revenue;
            end
            GET_OFF: begin
                revenue_next = revenue;
                passenger_next = passenger - 1;
                gas_next = gas;
                finish_next = 0;
            end
            GET_UP: begin
                gas_next = gas;
                finish_next = 0;
                if(LED_now[6:0]==7'b1000000) begin
                    revenue_next = (revenue+wait6_passenger*20<90)?(revenue+wait6_passenger*20):90;
                    passenger_next = pnum6;
                    wait0_passenger_next = wait0_passenger;
                    wait6_passenger_next = 0;
                end
                else if(LED_now[6:0]==7'b0000001) begin
                    revenue_next = (revenue+wait0_passenger*30<90)?(revenue+wait0_passenger*30):90;
                    passenger_next = pnum0;
                    wait0_passenger_next = 0;
                    wait6_passenger_next = wait6_passenger;
                end
                else begin
                    revenue_next = revenue;
                    passenger_next = passenger;
                    wait0_passenger_next = wait0_passenger;
                    wait6_passenger_next = wait6_passenger;
                end
            end
            REFUEL: begin
                if(gas==15 && passenger!=0 && revenue>=10) begin
                    gas_next = 20;
                    revenue_next = revenue - 10;
                end
                else if(gas==10 && passenger!=0 && revenue>=10) begin
                    gas_next = 20;
                    revenue_next = revenue - 10;
                end
                else if(gas==5 && passenger!=0 && revenue>=20) begin
                    gas_next = 20;
                    revenue_next = revenue - 20;
                end
                else if(gas==5 && passenger!=0 && revenue>=10) begin
                    gas_next = 15;
                    revenue_next = revenue - 10;
                end
                else if(gas==0 && passenger!=0 && revenue>=20) begin
                    gas_next = 20;
                    revenue_next = revenue - 20;
                end
                else if(gas==0 && passenger!=0 && revenue>=10) begin
                    gas_next = 10;
                    revenue_next = revenue - 10;
                end
                else begin
                    gas_next = GAS;
                    revenue_next = revenue;
                end
                passenger_next = passenger;
                finish_next = 1;
            end
            STOP: begin
                revenue_next = revenue;
                passenger_next = passenger;
                gas_next = gas;
                finish_next = 0;
            end
            CONSUME: begin
                gas_next = (gas - passenger*5);
                passenger_next = passenger;
                revenue_next = revenue;
                finish_next = 0;
            end
            default: begin
                gas_next = GAS;
                passenger_next = passenger;
                revenue_next = revenue;
                finish_next = finish;
            end
        endcase
    end
    
    always @(posedge CLK_DIV or posedge RST) begin
        if(RST) begin
            LED_now <= 16'b0000_0000_0000_0001;
        end
        else begin
            LED_now <= LED_next;
        end
    end
    always@ (*) begin
        if(passenger==1) begin
            LED_next[10:9] = 2'b10;
        end
        else if(passenger==2) begin
            LED_next[10:9] = 2'b11;
        end
        else begin
            LED_next[10:9] = 2'b00;
        end

        if(wait0_passenger==1) begin
            LED_next[15:14] = 2'b10;
        end
        else if(wait0_passenger==2) begin
            LED_next[15:14] = 2'b11;
        end
        else begin
            LED_next[15:14] = 2'b00;
        end

        if(wait6_passenger==1) begin
            LED_next[12:11] = 2'b010;
        end
        else if(wait6_passenger==2) begin
            LED_next[12:11] = 2'b11;
        end
        else begin
            LED_next[12:11] = 2'b00;
        end

        case(state)
            DRIVING: begin
                if(up_down) begin
                    LED_next[6:0] = LED_now[6:0] << 1;
                end
                else begin
                    LED_next[6:0] = LED_now[6:0] >> 1;
                end
            end
            default: begin
                LED_next[6:0] = LED_now[6:0];
            end
        endcase
    end

    /* always @(posedge clk or posedge RST) begin
        if(RST) begin
            BCD0 <= 0;
            BCD1 <= 0;
            BCD2 <= 0;
            BCD3 <= 0;
        end
        else begin
            BCD0 <= revenue % 10;
            BCD1 <= revenue / 10;
            BCD2 <= gas % 10;
            BCD3 <= gas / 10;
        end
    end */


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
			KEY_CODES[10] : key_num = 4'b0000;
			KEY_CODES[11] : key_num = 4'b0001;
			KEY_CODES[12] : key_num = 4'b0010;
			KEY_CODES[13] : key_num = 4'b0011;
			KEY_CODES[14] : key_num = 4'b0100;
			KEY_CODES[15] : key_num = 4'b0101;
			KEY_CODES[16] : key_num = 4'b0110;
			KEY_CODES[17] : key_num = 4'b0111;
			KEY_CODES[18] : key_num = 4'b1000;
			KEY_CODES[19] : key_num = 4'b1001;
			default		  : key_num = 4'b1111;
		endcase
	end

    always @(posedge CLK_DISPLAY) begin
        case (DIGIT)
            4'b1110: begin
                value/* _next */ = REVENUE / 10;
                DIGIT_now = 4'b1101;
            end
            4'b1101: begin
                value/* _next */ = GAS % 10;
                DIGIT_now = 4'b1011;
            end
            4'b1011: begin
                value/* _next */ = GAS / 10;
                DIGIT_now = 4'b0111;
            end
            4'b0111: begin
                value/* _next */ = REVENUE % 10;
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
        endcase
    end

endmodule