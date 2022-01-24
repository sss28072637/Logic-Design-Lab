module pixel_gen_snake(
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input [9:0] apple,
    input [5:0] len,
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
    input valid,
    input [2:0] STATE,
    input [5:0] score,
    input [1:0] choose,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
);
    parameter INITIAL = 3'd0;
    parameter GAMING = 3'd1;
    parameter WIN = 3'd3;
    parameter OVER = 3'd4;
    parameter CHOOSE = 3'd5;

    always @* begin
        case(STATE)
            INITIAL: begin
                if(!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                else if((( 10'd0  + 10'd310  <=h_cnt && h_cnt< 10'd24 + 10'd310 ) && ( 10'd48 + 10'd300 <=v_cnt && v_cnt< 10'd60  + 10'd300  ) )||
                        (( 10'd0  + 10'd310  <=h_cnt && h_cnt< 10'd24 + 10'd310 ) && ( 10'd72 + 10'd300 <=v_cnt && v_cnt< 10'd84  + 10'd300  ) )||
                        (( 10'd0  + 10'd310  <=h_cnt && h_cnt< 10'd24 + 10'd310 ) && ( 10'd96 + 10'd300 <=v_cnt && v_cnt< 10'd108 + 10'd300  ) )||
                        (( 10'd16 + 10'd310  <=h_cnt && h_cnt< 10'd24 + 10'd310 ) && ( 10'd48 + 10'd300 <=v_cnt && v_cnt< 10'd108 + 10'd300  ) )
                        )//3
                    begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white
                end
                

                else if((( 10'd24 + 10'd340 <=h_cnt && h_cnt< 10'd32 + 10'd340 ) && ( 10'd60 + 10'd300  <=v_cnt && v_cnt< 10'd108 + 10'd300 ))||
                        (( 10'd8  + 10'd340 <=h_cnt && h_cnt< 10'd32 + 10'd340 ) && ( 10'd48 + 10'd300  <=v_cnt && v_cnt< 10'd60  + 10'd300 ) )
                        )//7
                    begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white
                end 
                
                else if((( 10'd0 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd210) && ( 10'd0 *10'd12+ 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd150) )||
                        (( 10'd1 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd210) && ( 10'd0 *10'd12+ 10'd150<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd150) )||
                (( 10'd1 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd210) && ( 10'd6 *10'd12+ 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd150) )||
                
                //C

                (( 10'd0 *10'd8 + 10'd270<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd270) && ( 10'd1 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd150) )||
                (( 10'd6 *10'd8 + 10'd270<=h_cnt && h_cnt< 10'd7 *10'd8 + 10'd270) && ( 10'd1 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd150) )||
                (( 10'd1 *10'd8 + 10'd270<=h_cnt && h_cnt< 10'd6 *10'd8 + 10'd270) && ( 10'd0 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd1  *10'd12 + 10'd150) )||
                (( 10'd1 *10'd8 + 10'd270<=h_cnt && h_cnt< 10'd6 *10'd8 + 10'd270) && ( 10'd6 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd150) )||
                //O

                (( 10'd1 *10'd8 + 10'd330<=h_cnt && h_cnt< 10'd6 *10'd8 + 10'd330) && ( 10'd0 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd1  *10'd12 + 10'd150) )||
                (( 10'd3 *10'd8 + 10'd330<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd330) && ( 10'd0 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd150) )||
                (( 10'd1 *10'd8 + 10'd330<=h_cnt && h_cnt< 10'd6 *10'd8 + 10'd330) && ( 10'd6 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd150) )||
                
                //I
                
                (( 10'd0 *10'd8 + 10'd390<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd390) && ( 10'd0 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd150) )||
                (( 10'd4 *10'd8 + 10'd390<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd390) && ( 10'd0 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd150) )||
                (( 10'd1 *10'd8 + 10'd390<=h_cnt && h_cnt< 10'd2 *10'd8 + 10'd390) && ( 10'd2 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd150) )||
                (( 10'd2 *10'd8 + 10'd390<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd390) && ( 10'd3 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd150) )||
                (( 10'd3 *10'd8 + 10'd390<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd390) && ( 10'd4 *10'd12 + 10'd150<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd150) )
                //N

                )

                begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h560;
                end
                else if((( 0 <= h_cnt && h_cnt < 10'd640) && ( 0 <= v_cnt && v_cnt < 10'd30))||
                        (( 0 <= h_cnt && h_cnt < 10'd640) && ( 10'd450 <= v_cnt && v_cnt < 10'd480))||
                        (( 0 <= h_cnt && h_cnt< 10'd30) && ( 0 <= v_cnt && v_cnt < 10'd480))||
                        (( 10'd610 <= h_cnt && h_cnt < 10'd640) && ( 0 <= v_cnt && v_cnt < 10'd480))
                        //frame
                        )begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'h165;
                end
                else if((( 10'd1 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd210) && ( 10'd0 *10'd12+ 10'd250<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd250) )||
                (( 10'd0 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd210) && ( 10'd1 *10'd12+ 10'd250<=v_cnt && v_cnt< 10'd3  *10'd12+ 10'd250) )||
                (( 10'd1 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd210) && ( 10'd3 *10'd12+ 10'd250<=v_cnt && v_cnt< 10'd4  *10'd12+ 10'd250) )||
                (( 10'd4 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd210) && ( 10'd4 *10'd12+ 10'd250<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd250) )||
                (( 10'd0 *10'd8+ 10'd210<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd210) && ( 10'd6 *10'd12+ 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd250) )||
                //S
                (( 10'd0 *10'd8 + 10'd260<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd260) && ( 10'd0 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                (( 10'd4 *10'd8 + 10'd260<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd260) && ( 10'd0 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                (( 10'd1 *10'd8 + 10'd260<=h_cnt && h_cnt< 10'd2 *10'd8 + 10'd260) && ( 10'd2 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd250) )||
                (( 10'd2 *10'd8 + 10'd260<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd260) && ( 10'd3 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd250) )||
                (( 10'd3 *10'd8 + 10'd260<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd260) && ( 10'd4 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd250) )||
                //N
                (( 10'd1 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd310) && ( 10'd0 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd1  *10'd12 + 10'd250) )||
                (( 10'd0 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd310) && ( 10'd1 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                (( 10'd4 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd310) && ( 10'd1 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                (( 10'd1 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd310) && ( 10'd3 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd250) )||
                //A
                (( 10'd0 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd360) && ( 10'd0 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                (( 10'd3 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd360) && ( 10'd1 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd2  *10'd12 + 10'd250) )||
                (( 10'd2 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd360) && ( 10'd2 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd250) )||
                (( 10'd1 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd2 *10'd8 + 10'd360) && ( 10'd3 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd250) )||
                (( 10'd2 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd360) && ( 10'd4 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd250) )||
                (( 10'd3 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd360) && ( 10'd5 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd250) )||
                (( 10'd4 *10'd8 + 10'd360<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd360) && ( 10'd6 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                //K
                (( 10'd0 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd410) && ( 10'd0 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd1  *10'd12 + 10'd250) )||
                (( 10'd0 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd410) && ( 10'd6 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd250) )||
                (( 10'd0 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd410) && ( 10'd1 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd250) )||
                (( 10'd1 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd410) && ( 10'd3 *10'd12 + 10'd250<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd250) )
                //E
                ) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h33e;
                end
                else if((( 10'd0 *10'd8 + 10'd170<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd170) && ( 10'd2 *10'd12 + 10'd260<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd260) )||
                (( 10'd4 *10'd8 + 10'd170<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd170) && ( 10'd3 *10'd12 + 10'd260<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd260) )||
                (( 10'd4 *10'd8 + 10'd170<=h_cnt && h_cnt< 10'd7 *10'd8 + 10'd170) && ( 10'd4 *10'd12 + 10'd260<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd260) )
                //snake's body
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white
                end
        
                else if(( 10'd7 *10'd8 + 10'd170<=h_cnt && h_cnt< 10'd8 *10'd8 + 10'd170) && ( 10'd4 *10'd12 + 10'd260<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd260) )
                begin
                    //snake's head
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;//Red
                end
                
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h0; 
                end
            end
            GAMING: begin
                if(!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                else if((70<=h_cnt && h_cnt<75)|| (555<=h_cnt && h_cnt<560))
                    {vgaRed, vgaGreen, vgaBlue} = 12'h4e1;// color of court line (purple)
                else if( (apple[9:5]*15+75<=h_cnt && h_cnt<apple[9:5]*15+90) && (apple[4:0]*20<=v_cnt && v_cnt<apple[4:0]*20+20) )//color==RED
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;// color of appleA(red)
                else if((snake0[9:5]*15+75<=h_cnt && h_cnt<snake0[9:5]*15+90) && (snake0[4:0]*20<=v_cnt && v_cnt<snake0[4:0]*20+20))//color==RED
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;//color of snakeA's head(red)
                else if(((snake1[9:5]*15+75<=h_cnt && h_cnt<snake1[9:5]*15+90) && (snake1[4:0]*20<=v_cnt && v_cnt<snake1[4:0]*20+20) && len>1)||
                        ((snake2[9:5]*15+75<=h_cnt && h_cnt<snake2[9:5]*15+90) && (snake2[4:0]*20<=v_cnt && v_cnt<snake2[4:0]*20+20) && len>2)||
                        ((snake3[9:5]*15+75<=h_cnt && h_cnt<snake3[9:5]*15+90) && (snake3[4:0]*20<=v_cnt && v_cnt<snake3[4:0]*20+20) && len>3)||
                        ((snake4[9:5]*15+75<=h_cnt && h_cnt<snake4[9:5]*15+90) && (snake4[4:0]*20<=v_cnt && v_cnt<snake4[4:0]*20+20) && len>4)||
                        ((snake5[9:5]*15+75<=h_cnt && h_cnt<snake5[9:5]*15+90) && (snake5[4:0]*20<=v_cnt && v_cnt<snake5[4:0]*20+20) && len>5)||
                        ((snake6[9:5]*15+75<=h_cnt && h_cnt<snake6[9:5]*15+90) && (snake6[4:0]*20<=v_cnt && v_cnt<snake6[4:0]*20+20) && len>6)||
                        ((snake7[9:5]*15+75<=h_cnt && h_cnt<snake7[9:5]*15+90) && (snake7[4:0]*20<=v_cnt && v_cnt<snake7[4:0]*20+20) && len>7)||
                        ((snake8[9:5]*15+75<=h_cnt && h_cnt<snake8[9:5]*15+90) && (snake8[4:0]*20<=v_cnt && v_cnt<snake8[4:0]*20+20) && len>8)||
                        ((snake9[9:5]*15+75<=h_cnt && h_cnt<snake9[9:5]*15+90) && (snake9[4:0]*20<=v_cnt && v_cnt<snake9[4:0]*20+20) && len>9)) 
                begin
                    if(choose==2'd1) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                    else if(choose==2'd2) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h0e2;
                    end
                    else if(choose==2'd3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h777;//gray 
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    end
                end 
                else if((( 10'd0 *10'd8 + 10'd30 <=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd30) && ( 0 *10'd12 + 10'd60<=v_cnt && v_cnt< 1  *10'd12 + 10'd60) )||
                    (( 10'd0 *10'd8 + 10'd30 <=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd30) && ( 4 *10'd12 + 10'd60<=v_cnt && v_cnt< 5  *10'd12 + 10'd60) )||
                    (( 10'd0 *10'd8 + 10'd30 <=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd30) && ( 0 *10'd12 + 10'd60<=v_cnt && v_cnt< 5  *10'd12 + 10'd60) )||
                    (( 10'd2 *10'd8 + 10'd30 <=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd30) && ( 0 *10'd12 + 10'd60<=v_cnt && v_cnt< 5  *10'd12 + 10'd60) )
                    )begin//draw A0 here
                if(score == 6'd0) {vgaRed, vgaGreen, vgaBlue} = 12'hf55;
                else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end
            
                else if((( 10'd24 <=h_cnt && h_cnt< 10'd32 ) && ( 10'd60 <=v_cnt && v_cnt< 10'd108 ))
                    )begin //draw A1 here
                    if(score == 6'd1) {vgaRed, vgaGreen, vgaBlue} = 12'hf55;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end
            
                else if((( 10'd0 + 10'd600  <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd48 <=v_cnt && v_cnt< 10'd60 ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd72 <=v_cnt && v_cnt< 10'd84 ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd96 <=v_cnt && v_cnt< 10'd108 ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd8 + 10'd600) && ( 10'd72 <=v_cnt && v_cnt< 10'd108 ) )||
                        (( 10'd16 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd48 <=v_cnt && v_cnt< 10'd84 ) )
                        )begin//draw A2 here
                    if(score == 6'd2) {vgaRed, vgaGreen, vgaBlue} = 12'h16f;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end

                else if((( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd48 + 10'd75  <=v_cnt && v_cnt< 10'd60  + 10'd75  ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd72 + 10'd75  <=v_cnt && v_cnt< 10'd84  + 10'd75  ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd96 + 10'd75  <=v_cnt && v_cnt< 10'd108 + 10'd75  ) )||
                        (( 10'd16 + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd48 + 10'd75  <=v_cnt && v_cnt< 10'd108 + 10'd75  ) )
                        )begin//draw A3 here
                    if(score == 6'd3) {vgaRed, vgaGreen, vgaBlue} = 12'h06f;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end

                else if((( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd8 + 10'd600) && ( 10'd48 + 10'd60   <=v_cnt && v_cnt< 10'd84 + 10'd60   ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd72 + 10'd60   <=v_cnt && v_cnt< 10'd84 + 10'd60   ) )||
                        (( 10'd16 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd48 + 10'd60   <=v_cnt && v_cnt< 10'd108 + 10'd60   ) )
                        )begin//draw A4 here
                    if(score == 6'd4) {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end

                else if((( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd48 + 10'd140 <=v_cnt && v_cnt< 10'd60  + 10'd140 ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd72 + 10'd140 <=v_cnt && v_cnt< 10'd84  + 10'd140 ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd96 + 10'd140 <=v_cnt && v_cnt< 10'd108 + 10'd140 ) )||
                        (( 10'd16 + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd72 + 10'd140 <=v_cnt && v_cnt< 10'd108 + 10'd140 ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd8  + 10'd16) && ( 10'd48 + 10'd140 <=v_cnt && v_cnt< 10'd84  + 10'd140 ) )
                        )begin//draw A5 here
                    if(score == 6'd5) {vgaRed, vgaGreen, vgaBlue} = 12'h471;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end


                else if((( 10'd0  + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd48 + 10'd120   <=v_cnt && v_cnt< 10'd60 + 10'd120  ) )||
                        (( 10'd0  + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd72 + 10'd120  <=v_cnt && v_cnt< 10'd84 + 10'd120  ) )||
                        (( 10'd0  + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd96 + 10'd120  <=v_cnt && v_cnt< 10'd108 + 10'd120  ) )||
                        (( 10'd16 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd72 + 10'd120  <=v_cnt && v_cnt< 10'd108 + 10'd120  ) )||
                        (( 10'd0  + 10'd600 <=h_cnt && h_cnt< 10'd8 + 10'd600) && ( 10'd48 + 10'd120  <=v_cnt && v_cnt< 10'd108 + 10'd120  ) )
                        )begin//draw A6 here
                    if(score == 6'd6) {vgaRed, vgaGreen, vgaBlue} = 12'h08f;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end

                else if((( 10'd24 + 10'd16 <=h_cnt && h_cnt< 10'd32 + 10'd16) && ( 10'd60 + 10'd200  <=v_cnt && v_cnt< 10'd108 + 10'd200 ))||
                        (( 10'd8  + 10'd16 <=h_cnt && h_cnt< 10'd32 + 10'd16) && ( 10'd48 + 10'd200  <=v_cnt && v_cnt< 10'd60  + 10'd200 ) )
                        )begin //draw A7 here
                    if(score == 6'd7) {vgaRed, vgaGreen, vgaBlue} = 12'h63f;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end

                else if((( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd48 + 10'd180   <=v_cnt && v_cnt< 10'd60 + 10'd180   ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd72 + 10'd180   <=v_cnt && v_cnt< 10'd84 + 10'd180   ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd96 + 10'd180   <=v_cnt && v_cnt< 10'd108 + 10'd180   ) )||
                        (( 10'd16 + 10'd600 <=h_cnt && h_cnt< 10'd24 + 10'd600) && ( 10'd48 + 10'd180   <=v_cnt && v_cnt< 10'd108 + 10'd180   ) )||
                        (( 10'd0 + 10'd600 <=h_cnt && h_cnt< 10'd8 + 10'd600) && ( 10'd48 + 10'd180   <=v_cnt && v_cnt< 10'd108 + 10'd180   ) )
                        )begin//draw A8 here
                    if(score == 6'd8) {vgaRed, vgaGreen, vgaBlue} = 12'h4f1;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end

                else if((( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd48 + 10'd260 <=v_cnt && v_cnt< 10'd60  + 10'd260 ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd72 + 10'd260 <=v_cnt && v_cnt< 10'd84  + 10'd260 ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd96 + 10'd260 <=v_cnt && v_cnt< 10'd108 + 10'd260 ) )||
                        (( 10'd16 + 10'd16 <=h_cnt && h_cnt< 10'd24 + 10'd16) && ( 10'd48 + 10'd260 <=v_cnt && v_cnt< 10'd108 + 10'd260 ) )||
                        (( 10'd0  + 10'd16 <=h_cnt && h_cnt< 10'd8  + 10'd16) && ( 10'd48 + 10'd260 <=v_cnt && v_cnt< 10'd84  + 10'd260 ) )
                        )begin//draw A9 here
                    if(score == 6'd9) {vgaRed, vgaGreen, vgaBlue} = 12'h38c;
                    else       {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h0; 
                end
            end
            WIN: begin
                if(!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                else if((( 0 <= h_cnt && h_cnt < 10'd640) && ( 0 <= v_cnt && v_cnt < 10'd30))||
                        (( 0 <= h_cnt && h_cnt < 10'd640) && ( 10'd450 <= v_cnt && v_cnt < 10'd480))||
                        (( 0 <= h_cnt && h_cnt< 10'd30) && ( 0 <= v_cnt && v_cnt < 10'd480))||
                        (( 10'd610 <= h_cnt && h_cnt < 10'd640) && ( 0 <= v_cnt && v_cnt < 10'd480))
                        //frame
                        )begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'h563;
                end
                else if((( 10'd0 *10'd8+ 10'd300<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd300) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                        (( 10'd1 *10'd8+ 10'd300<=h_cnt && h_cnt< 10'd2 *10'd8+ 10'd300) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                        (( 10'd2 *10'd8+ 10'd300<=h_cnt && h_cnt< 10'd3 *10'd8+ 10'd300) && ( 10'd2 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                        (( 10'd3 *10'd8+ 10'd300<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd300) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                        (( 10'd4 *10'd8+ 10'd300<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd300) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                        //W
                        (( 10'd0 *10'd8+ 10'd350<=h_cnt && h_cnt< 10'd3 *10'd8+ 10'd350) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd200) )||
                        (( 10'd1 *10'd8+ 10'd350<=h_cnt && h_cnt< 10'd2 *10'd8+ 10'd350) && ( 10'd1 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                        (( 10'd0 *10'd8+ 10'd350<=h_cnt && h_cnt< 10'd3 *10'd8+ 10'd350) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                        //I
                        (( 10'd0 *10'd8 + 10'd380<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd380) && ( 10'd0 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd200) )||
                        (( 10'd4 *10'd8 + 10'd380<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd380) && ( 10'd0 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd200) )||
                        (( 10'd1 *10'd8 + 10'd380<=h_cnt && h_cnt< 10'd2 *10'd8 + 10'd380) && ( 10'd2 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd200) )||
                        (( 10'd2 *10'd8 + 10'd380<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd380) && ( 10'd3 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd200) )||
                        (( 10'd3 *10'd8 + 10'd380<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd380) && ( 10'd4 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd200) )
                        //N
                        )
                        {vgaRed, vgaGreen, vgaBlue} = 12'h4C6;//Red

                else if((( 10'd0 *10'd8 + 10'd200<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd200) && ( 10'd2 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd200) )||
                        (( 10'd4 *10'd8 + 10'd200<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd200) && ( 10'd3 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd200) )||
                        (( 10'd4 *10'd8 + 10'd200<=h_cnt && h_cnt< 10'd7 *10'd8 + 10'd200) && ( 10'd4 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd200) )
                        //snake's body
                        )begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white
                        end
                
                else if(( 10'd7 *10'd8 + 10'd200<=h_cnt && h_cnt< 10'd8 *10'd8 + 10'd200) && ( 10'd4 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd200) )
                        //snake's head
                        {vgaRed, vgaGreen, vgaBlue} = 12'hf55;//Red

                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            OVER: begin
                if(!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;


                else if((( 10'd0   <= h_cnt && h_cnt < 10'd60 ) && ( 10'd0   <= v_cnt && v_cnt < 10'd20 ))||
                        (( 10'd580 <= h_cnt && h_cnt < 10'd640) && ( 10'd0   <= v_cnt && v_cnt < 10'd20 ))||
                        (( 10'd0   <= h_cnt && h_cnt < 10'd60 ) && ( 10'd460 <= v_cnt && v_cnt < 10'd480))||
                        (( 10'd580 <= h_cnt && h_cnt < 10'd640) && ( 10'd460 <= v_cnt && v_cnt < 10'd480))||

                        (( 10'd0   <= h_cnt && h_cnt < 10'd20 ) && ( 10'd0   <= v_cnt && v_cnt < 10'd60 ))||
                        (( 10'd0   <= h_cnt && h_cnt < 10'd20 ) && ( 10'd420 <= v_cnt && v_cnt < 10'd480))||
                        (( 10'd620 <= h_cnt && h_cnt < 10'd640) && ( 10'd0   <= v_cnt && v_cnt < 10'd60 ))||
                        (( 10'd620 <= h_cnt && h_cnt < 10'd640) && ( 10'd420 <= v_cnt && v_cnt < 10'd480))
                        //frame
                        )begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'h777;
                end

                else if((( 10'd0 *10'd8+ 10'd290<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd290) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd290<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd290) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd290<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd290) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                (( 10'd4 *10'd8+ 10'd290<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd290) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                //O
                
                (( 10'd0 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd340) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd3  *10'd12+ 10'd200) )||
                (( 10'd1 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd2 *10'd8+ 10'd340) && ( 10'd3 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                (( 10'd2 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd3 *10'd8+ 10'd340) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                (( 10'd3 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd340) && ( 10'd3 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                (( 10'd4 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd340) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd3  *10'd12+ 10'd200) )||
                
                //V

                (( 10'd0 *10'd8+ 10'd390<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd390) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd390<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd390) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd390<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd390) && ( 10'd3 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd4  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd390<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd390) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                
                
                //E

                (( 10'd0 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd450) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd450) && ( 10'd0 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd200) )||
                (( 10'd4 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd450) && ( 10'd1 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd3  *10'd12+ 10'd200) )||
                (( 10'd0 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd450) && ( 10'd3 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd4  *10'd12+ 10'd200) )||
                (( 10'd2 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd3 *10'd8+ 10'd450) && ( 10'd4 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd5  *10'd12+ 10'd200) )|| 
                (( 10'd3 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd450) && ( 10'd5 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd200) )||
                (( 10'd4 *10'd8+ 10'd450<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd450) && ( 10'd6 *10'd12+ 10'd200<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd200) )
                )begin
                //R
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;//Red
                end
                else if((( 10'd0 *10'd8 + 10'd120<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd120) && ( 10'd2 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd200) )||
                        (( 10'd4 *10'd8 + 10'd120<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd120) && ( 10'd3 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd200) )||
                        (( 10'd4 *10'd8 + 10'd120<=h_cnt && h_cnt< 10'd7 *10'd8 + 10'd120) && ( 10'd4 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd200) )
                        //snake's body
                        )begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white
                        end
                
                // else if(( 10'd7 *10'd8 + 10'd200<=h_cnt && h_cnt< 10'd8 *10'd8 + 10'd200) && ( 10'd4 *10'd12 + 10'd200<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd200) )
                //         //snake's head
                //         {vgaRed, vgaGreen, vgaBlue} = 12'hf55;//Red

                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            CHOOSE: begin
                if(!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;

                /* else if((( 10'd0 *10'd8+ 10'd100<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd100) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd1 *10'd8+ 10'd100<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd100) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd50) )||
                        (( 10'd1 *10'd8+ 10'd100<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd100) && ( 10'd6 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                //C
                        (( 10'd0 *10'd8+ 10'd160<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd160) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd4 *10'd8+ 10'd160<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd160) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd160<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd160) && ( 10'd3 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd4  *10'd12+ 10'd50) )||
                //H
                        (( 10'd0 *10'd8+ 10'd220<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd220) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd220<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd220) && ( 10'd6 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd220<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd220) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd4 *10'd8+ 10'd220<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd220) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                //O
                        (( 10'd0 *10'd8+ 10'd280<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd280) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd280<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd280) && ( 10'd6 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd280<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd280) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                        (( 10'd4 *10'd8+ 10'd280<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd280) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                //O
                        (( 10'd1 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd340) && ( 10'd0 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd1  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd1 *10'd8+ 10'd340) && ( 10'd1 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd3  *10'd12+ 10'd50) )||
                        (( 10'd1 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd340) && ( 10'd3 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd4  *10'd12+ 10'd50) )||
                        (( 10'd4 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd5 *10'd8+ 10'd340) && ( 10'd4 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd6  *10'd12+ 10'd50) )||
                        (( 10'd0 *10'd8+ 10'd340<=h_cnt && h_cnt< 10'd4 *10'd8+ 10'd340) && ( 10'd6 *10'd12+ 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12+ 10'd50) )||
                //S
                        (( 10'd0 *10'd8 + 10'd400<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd400) && ( 10'd0 *10'd12 + 10'd50<=v_cnt && v_cnt< 10'd1  *10'd12 + 10'd50) )||
                        (( 10'd0 *10'd8 + 10'd400<=h_cnt && h_cnt< 10'd5 *10'd8 + 10'd400) && ( 10'd6 *10'd12 + 10'd50<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd50) )||
                        (( 10'd0 *10'd8 + 10'd400<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd400) && ( 10'd1 *10'd12 + 10'd50<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd50) )||
                        (( 10'd1 *10'd8 + 10'd400<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd400) && ( 10'd3 *10'd12 + 10'd50<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd50) )
                //E
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h0e2;//green
                end */


                else if((( 10'd0   <= h_cnt && h_cnt < 10'd60 ) && ( 10'd0   <= v_cnt && v_cnt < 10'd20 ))||
                        (( 10'd580 <= h_cnt && h_cnt < 10'd640) && ( 10'd0   <= v_cnt && v_cnt < 10'd20 ))||
                        (( 10'd0   <= h_cnt && h_cnt < 10'd60 ) && ( 10'd460 <= v_cnt && v_cnt < 10'd480))||
                        (( 10'd580 <= h_cnt && h_cnt < 10'd640) && ( 10'd460 <= v_cnt && v_cnt < 10'd480))||

                        (( 10'd0   <= h_cnt && h_cnt < 10'd20 ) && ( 10'd0   <= v_cnt && v_cnt < 10'd60 ))||
                        (( 10'd0   <= h_cnt && h_cnt < 10'd20 ) && ( 10'd420 <= v_cnt && v_cnt < 10'd480))||
                        (( 10'd620 <= h_cnt && h_cnt < 10'd640) && ( 10'd0   <= v_cnt && v_cnt < 10'd60 ))||
                        (( 10'd620 <= h_cnt && h_cnt < 10'd640) && ( 10'd420 <= v_cnt && v_cnt < 10'd480))
                        //frame corner
                        )begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'h13f;
                end

                else if((( 10'd216   <= h_cnt && h_cnt < 10'd432 ) && ( 10'd0   <= v_cnt && v_cnt < 10'd20 ))||
                        (( 10'd216 <= h_cnt && h_cnt < 10'd432) && ( 10'd460   <= v_cnt && v_cnt < 10'd480 ))||
                        (( 10'd0   <= h_cnt && h_cnt < 10'd20 ) && ( 10'd160 <= v_cnt && v_cnt < 10'd320))||
                        (( 10'd620 <= h_cnt && h_cnt < 10'd640) && ( 10'd160 <= v_cnt && v_cnt < 10'd320))
                        //frame line
                        )begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
                end


                else if((( 10'd24 + 10'd410 <=h_cnt && h_cnt< 10'd32 + 10'd410 ) && ( 10'd60 + 10'd95 <=v_cnt && v_cnt< 10'd108 + 10'd95 ))
                )begin //1
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white
                end

                else if((( 10'd0  + 10'd310 <=h_cnt && h_cnt< 10'd24 + 10'd310) && ( 10'd48 + 10'd95  <=v_cnt && v_cnt< 10'd60  + 10'd95  ) )||
                        (( 10'd0  + 10'd310 <=h_cnt && h_cnt< 10'd24 + 10'd310) && ( 10'd72 + 10'd95  <=v_cnt && v_cnt< 10'd84  + 10'd95  ) )||
                        (( 10'd0  + 10'd310 <=h_cnt && h_cnt< 10'd24 + 10'd310) && ( 10'd96 + 10'd95  <=v_cnt && v_cnt< 10'd108 + 10'd95  ) )||
                        (( 10'd0  + 10'd310 <=h_cnt && h_cnt< 10'd8  + 10'd310) && ( 10'd72 + 10'd95  <=v_cnt && v_cnt< 10'd108 + 10'd95  ) )||
                        (( 10'd16 + 10'd310 <=h_cnt && h_cnt< 10'd24 + 10'd310) && ( 10'd48 + 10'd95  <=v_cnt && v_cnt< 10'd84  + 10'd95  ) )
                )begin //2
                    {vgaRed, vgaGreen, vgaBlue} = 12'h0e2;//green
                end

                else if((( 10'd0  + 10'd210 <=h_cnt && h_cnt< 10'd24 + 10'd210) && ( 10'd48 + 10'd95  <=v_cnt && v_cnt< 10'd60  + 10'd95  ) )||
                        (( 10'd0  + 10'd210 <=h_cnt && h_cnt< 10'd24 + 10'd210) && ( 10'd72 + 10'd95  <=v_cnt && v_cnt< 10'd84  + 10'd95  ) )||
                        (( 10'd0  + 10'd210 <=h_cnt && h_cnt< 10'd24 + 10'd210) && ( 10'd96 + 10'd95  <=v_cnt && v_cnt< 10'd108 + 10'd95  ) )||
                        (( 10'd16 + 10'd210 <=h_cnt && h_cnt< 10'd24 + 10'd210) && ( 10'd48 + 10'd95  <=v_cnt && v_cnt< 10'd108 + 10'd95  ) )
                )begin //3
                    {vgaRed, vgaGreen, vgaBlue} = 12'h777;//gray 
                end

                else if((( 10'd2 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd410) && ( 10'd0 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd4  *10'd12 + 10'd240) )||
                        (( 10'd1 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd2 *10'd8 + 10'd410) && ( 10'd3 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd240) )||
                        (( 10'd2 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd410) && ( 10'd5 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd240) )
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hfff;//white snake
                end
                else if((( 10'd2 *10'd8 + 10'd410<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd410) && ( 10'd6 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd240) )
                //snake head
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;
                end
                else if((( 10'd1 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd2 *10'd8 + 10'd310) && ( 10'd0 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd240) )||
                        (( 10'd2 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd310) && ( 10'd2 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd240) )||
                        (( 10'd3 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd310) && ( 10'd5 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd240) )
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h0e2;//green snake
                end
                else if((( 10'd3 *10'd8 + 10'd310<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd310) && ( 10'd6 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd240) )
                // snake head
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;
                end
                else if((( 10'd3 *10'd8 + 10'd210<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd210) && ( 10'd0 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd240) )||
                        (( 10'd0 *10'd8 + 10'd210<=h_cnt && h_cnt< 10'd4 *10'd8 + 10'd210) && ( 10'd2 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd3  *10'd12 + 10'd240) )||
                        (( 10'd0 *10'd8 + 10'd210<=h_cnt && h_cnt< 10'd1 *10'd8 + 10'd210) && ( 10'd2 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd240) )||
                        (( 10'd0 *10'd8 + 10'd210<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd210) && ( 10'd4 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd5  *10'd12 + 10'd240) )||
                        (( 10'd2 *10'd8 + 10'd210<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd210) && ( 10'd5 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd6  *10'd12 + 10'd240) )
            
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'h777;//gray snake
                end
                else if((( 10'd2 *10'd8 + 10'd210<=h_cnt && h_cnt< 10'd3 *10'd8 + 10'd210) && ( 10'd6 *10'd12 + 10'd240<=v_cnt && v_cnt< 10'd7  *10'd12 + 10'd240) )
                // snake head
                )begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf55;
                end
                else {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
            default: begin
                if(!valid) {vgaRed, vgaGreen, vgaBlue} = 12'h0;
                else {vgaRed, vgaGreen, vgaBlue} = 12'h777;//gray
            end
        endcase
    end

endmodule
