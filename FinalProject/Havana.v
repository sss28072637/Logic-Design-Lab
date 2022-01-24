
`define LA 32'd784
`define SO 32'd784
`define FA 32'd698

`define MI 32'd622

`define RE 32'd587
`define DO 32'd523

`define si 32'd494
`define la 32'd440
`define so 32'd392
`define fa 32'd349
`define mi 32'd330
`define re 32'd294
`define do 32'd262

`define MI_2 32'd622
`define si_2 32'd466
`define SI_2 32'd466

`define do_d 32'd131
`define re_d 32'd147

`define mi_d 32'd156

`define fa_d 32'd174
`define so_d 32'd196
`define la_d 32'd220
`define si_d 32'd247
`define DO_d 32'd262
`define RE_d 32'd294
`define MI_d 32'd330


`define re_d_2 32'd73
`define mi_d_2 32'd83
`define fa_d_2 32'd87
`define so_d_2 32'd98
`define la_d_2 32'd110
`define si_d_2 32'd123

`define si_d_2_d 32'd116
`define mi_d_2_d 32'd156
`define mi_d_d 32'd156

`define fa_d_r 32'd185


`define sil 32'd50000000

module Havana (
	input [11:0] ibeatNum,
	input en,
	output reg [31:0] toneL,
    output reg [31:0] toneR
);

    always @* begin
        if(en == 1) begin
            case(ibeatNum)
                // --- Measure 1 ---
                    12'd0: toneR = `sil;      12'd1: toneR = `RE;// HG (half-beat)
                    12'd2: toneR = `RE;      12'd3: toneR = `RE;
                    12'd4: toneR = `RE;      12'd5: toneR = `RE;
                    12'd6: toneR = `RE;      12'd7: toneR = `sil;
                    12'd8: toneR = `RE;      12'd9: toneR = `RE;// HE (half-beat)
                    12'd10: toneR = `RE;     12'd11: toneR = `RE;
                    12'd12: toneR = `RE;     12'd13: toneR = `RE;
                    12'd14: toneR = `RE;     12'd15: toneR = `RE; // (Short break for repetitive notes: high E)

                    12'd16: toneR = `si_2;     12'd17: toneR = `si_2;// HE (one-beat)
                    12'd18: toneR = `si_2;     12'd19: toneR = `si_2;
                    12'd20: toneR = `si_2;    12'd21: toneR = `si_2;
                    12'd22: toneR = `si_2;     12'd23: toneR = `sil;
                    12'd24: toneR = `si_2;     12'd25: toneR = `si_2;
                    12'd26: toneR = `si_2;     12'd27: toneR = `si_2;
                    12'd28: toneR = `si_2;     12'd29: toneR = `si_2;
                    12'd30: toneR = `si_2;     12'd31: toneR = `si_2;

                    12'd32: toneR = `so;      12'd33: toneR = `so;  // HF (half-beat)
                    12'd34: toneR = `so;      12'd35: toneR = `so; 
                    12'd36: toneR = `so;      12'd37: toneR = `so; 
                    12'd38: toneR = `so;      12'd39: toneR = `so; 
                    12'd40: toneR = `so;      12'd41: toneR = `so;  // HD (half-beat)
                    12'd42: toneR = `so;      12'd43: toneR = `so; 
                    12'd44: toneR = `so;      12'd45: toneR = `so; 
                    12'd46: toneR = `so;      12'd47: toneR = `so;  // (Short break for repetitive notes: high D)

                    12'd48: toneR = `sil;     12'd49: toneR = `sil;// HD (one-beat)
                    12'd50: toneR = `sil;     12'd51: toneR = `sil;
                    12'd52: toneR = `sil;     12'd53: toneR = `sil;
                    12'd54: toneR = `sil;     12'd55: toneR = `sil;
                    12'd56: toneR = `sil;     12'd57: toneR = `sil;
                    12'd58: toneR = `sil;     12'd59: toneR = `sil;
                    12'd60: toneR = `sil;     12'd61: toneR = `sil;
                    12'd62: toneR = `sil;     12'd63: toneR = `sil;

                    // --- Measure 2 ---
                    12'd64: toneR = `sil;      12'd65: toneR = `sil;  // HC (half-beat)
                    12'd66: toneR = `sil;     12'd67: toneR = `sil; 
                    12'd68: toneR = `sil;      12'd69: toneR = `sil; 
                    12'd70: toneR = `sil;     12'd71: toneR = `sil; 
                    12'd72: toneR = `RE;      12'd73: toneR = `RE;  // HD (half-beat)
                    12'd74: toneR = `RE;       12'd75: toneR = `RE;  
                    12'd76: toneR = `RE;      12'd77: toneR = `RE; 
                    12'd78: toneR = `RE;       12'd79: toneR = `RE;  

                    12'd80: toneR = `DO;       12'd81: toneR =`DO;  // HE (half-beat)
                    12'd82: toneR = `DO;        12'd83: toneR = `DO; 
                    12'd84: toneR = `DO;        12'd85: toneR = `DO; 
                    12'd86: toneR = `DO;       12'd87: toneR = `DO; 
                    12'd88: toneR = `RE;     12'd89: toneR = `RE; // HF (half-beat)
                    12'd90: toneR = `RE;    12'd91: toneR = `RE;
                    12'd92: toneR = `RE;     12'd93: toneR = `RE;
                    12'd94: toneR = `RE;    12'd95: toneR =`RE;

                    12'd96: toneR = `MI;      12'd97: toneR = `MI;  // HG (half-beat)
                    12'd98: toneR = `MI;      12'd99: toneR = `MI;
                    12'd100: toneR = `MI;     12'd101: toneR = `MI; 
                    12'd102: toneR = `MI;     12'd103: toneR = `MI;  // (Short break for repetitive notes: high G)
                    12'd104: toneR = `RE;     12'd105: toneR =`RE;  // HG (half-beat)
                    12'd106: toneR = `RE;     12'd107: toneR = `RE; 
                    12'd108: toneR = `RE;     12'd109: toneR = `RE; 
                    12'd110: toneR = `RE;     12'd111: toneR = `RE;  // (Short break for repetitive notes: high G)

                    12'd112: toneR = `DO;    12'd113: toneR = `DO; // HG (one-beat)
                    12'd114: toneR = `DO;    12'd115: toneR = `DO;
                    12'd116: toneR = `DO;    12'd117: toneR = `DO;
                    12'd118: toneR = `DO;    12'd119: toneR = `DO;
                    12'd120: toneR = `si_2;    12'd121: toneR = `si_2;
                    12'd122: toneR = `si_2;    12'd123: toneR = `si_2;
                    12'd124: toneR = `si_2;    12'd125: toneR = `si_2;
                    12'd126: toneR = `si_2;    12'd127: toneR = `si_2;// (Short break for repetitive notes: high G)

                    // --- Measure 3 ---
                    12'd128: toneR = `RE;       12'd129: toneR = `RE;  // HG (half-beat)
                    12'd130: toneR = `RE;       12'd131: toneR = `RE; 
                    12'd132: toneR = `RE;       12'd133: toneR = `RE; 
                    12'd134: toneR = `RE;       12'd135: toneR = `sil; 
                    12'd136: toneR = `RE;       12'd137: toneR = `RE;  // HE (half-beat)
                    12'd138: toneR = `RE;       12'd139: toneR = `RE; 
                    12'd140: toneR = `RE;       12'd141: toneR = `RE; 
                    12'd142: toneR = `RE;       12'd143: toneR = `RE;  // (Short break for repetitive notes: high E)

                    12'd144: toneR = `si_2;     12'd145: toneR = `si_2; // HE (one-beat)
                    12'd146: toneR = `si_2;     12'd147: toneR = `si_2;
                    12'd148: toneR = `si_2;     12'd149: toneR = `si_2;
                    12'd150: toneR = `si_2;     12'd151: toneR = `sil;
                    12'd152: toneR = `si_2;     12'd153: toneR = `si_2;
                    12'd154: toneR = `si_2;     12'd155: toneR = `si_2;
                    12'd156: toneR = `si_2;     12'd157: toneR = `si_2;
                    12'd158: toneR = `si_2;     12'd159: toneR = `si_2;

                    12'd160: toneR = `so;      12'd161: toneR = `so;  // HF (half-beat)
                    12'd162: toneR = `so;      12'd163: toneR = `so; 
                    12'd164: toneR = `so;      12'd165: toneR = `so; 
                    12'd166: toneR = `so;      12'd167: toneR = `so; 
                    12'd168: toneR = `so;      12'd169: toneR = `so;  // HD (half-beat)
                    12'd170: toneR = `so;      12'd171: toneR = `so; 
                    12'd172: toneR = `so;      12'd173: toneR = `so; 
                    12'd174: toneR = `so;      12'd175: toneR = `so;  // (Short break for repetitive notes: high D)

                    12'd176: toneR = `sil;      12'd177: toneR =  `sil; // HD (one-beat)
                    12'd178: toneR = `sil;      12'd179: toneR =  `sil;
                    12'd180: toneR = `sil;      12'd181: toneR =  `sil;
                    12'd182: toneR =  `sil;     12'd183: toneR = `sil;
                    12'd184: toneR =  `sil;     12'd185: toneR =  `sil;
                    12'd186: toneR =  `sil;     12'd187: toneR =  `sil;
                    12'd188: toneR =  `sil;     12'd189: toneR =  `sil;
                    12'd190: toneR =  `sil;     12'd191: toneR =  `sil;

                    // --- Measure 4 ---
                    12'd192: toneR = `sil;     12'd193: toneR = `sil; // HC (half-beat)
                    12'd194: toneR = `sil;     12'd495: toneR = `sil;
                    12'd196: toneR = `sil;     12'd197: toneR = `sil;
                    12'd198: toneR = `sil;     12'd199: toneR = `sil;
                    12'd200: toneR = `RE;      12'd201: toneR = `RE;  // HE (half-beat)
                    12'd202: toneR = `RE;      12'd203: toneR = `RE; 
                    12'd204: toneR = `RE;      12'd205: toneR = `RE; 
                    12'd206: toneR = `RE;      12'd207: toneR = `RE; 

                    12'd208: toneR = `DO;     12'd209: toneR = `DO;  // HG (half-beat)
                    12'd210: toneR = `DO;     12'd211: toneR = `DO; 
                    12'd212: toneR = `DO;     12'd213: toneR = `DO; 
                    12'd214: toneR = `DO;     12'd215: toneR = `DO;  // (Short break for repetitive notes: high G)
                    12'd216: toneR = `RE;     12'd217: toneR = `RE; // HG (half-beat)
                    12'd218: toneR = `RE;     12'd219: toneR = `RE;
                    12'd220: toneR = `RE;     12'd221: toneR = `RE;
                    12'd222: toneR = `RE;     12'd223: toneR = `RE;

                    12'd224: toneR = `MI;     12'd225: toneR = `MI; // HC (half-beat)
                    12'd226: toneR = `MI;    12'd227: toneR = `MI;
                    12'd228: toneR =`MI;    12'd229: toneR = `MI;
                    12'd230: toneR = `MI;    12'd231: toneR = `MI; // (Short break for repetitive notes: high C)
                    12'd232: toneR = `RE;     12'd233: toneR = `RE;// HC (half-beat)
                    12'd234: toneR = `RE;     12'd235: toneR = `RE;
                    12'd236: toneR = `RE;    12'd237: toneR = `RE;
                    12'd238: toneR = `RE;     12'd239: toneR = `RE; // (Short break for repetitive notes: high C)

                    12'd240: toneR = `DO;     12'd241: toneR = `DO; // HC (one-beat)
                    12'd242: toneR = `DO;     12'd243: toneR = `DO;
                    12'd244: toneR = `DO;     12'd245: toneR = `DO;
                    12'd246: toneR = `DO;     12'd247: toneR = `DO;
                    12'd248: toneR = `SI_2;     12'd249: toneR = `SI_2;
                    12'd250: toneR = `SI_2;     12'd251: toneR = `SI_2;
                    12'd252: toneR = `SI_2;     12'd253: toneR = `SI_2;
                    12'd254: toneR = `SI_2;     12'd255: toneR = `SI_2;

                    // --- Measure 5 ---
                    12'd256: toneR = `RE;       12'd257: toneR = `RE;   // HD (half-beat)
                    12'd258: toneR = `RE;       12'd259: toneR = `RE;  
                    12'd260: toneR = `RE;       12'd261: toneR = `RE;  
                    12'd262: toneR = `RE;       12'd263: toneR = `sil;   // (Short break for repetitive notes: high D)
                    12'd264: toneR = `RE;       12'd265: toneR = `RE;  // HD (half-beat)
                    12'd266: toneR = `RE;       12'd267: toneR = `RE; 
                    12'd268: toneR = `RE;       12'd269: toneR = `RE; 
                    12'd270: toneR = `RE;       12'd271: toneR = `RE;  // (Short break for repetitive notes: high D)

                    12'd272: toneR = `SI_2;     12'd273: toneR = `SI_2;  // HD (half-beat)
                    12'd274: toneR = `SI_2;     12'd275: toneR = `SI_2; 
                    12'd276: toneR = `SI_2;     12'd277: toneR = `SI_2; 
                    12'd278: toneR = `SI_2;     12'd279: toneR = `sil; // (Short break for repetitive notes: high D)
                    12'd280: toneR = `SI_2;     12'd281: toneR = `SI_2;  // HD (half-beat)
                    12'd282: toneR = `SI_2;     12'd283: toneR = `SI_2; 
                    12'd284: toneR = `SI_2;     12'd285: toneR = `SI_2; 
                    12'd286: toneR = `SI_2;     12'd287: toneR = `SI_2;  // (Short break for repetitive notes: high D)

                    12'd288: toneR = `la;     12'd289: toneR = `la;  // HD (half-beat)
                    12'd290: toneR = `la;      12'd291: toneR = `la; 
                    12'd292: toneR = `la;      12'd293: toneR = `la; 
                    12'd294: toneR = `la;      12'd295: toneR = `la; 
                    12'd296: toneR = `la;      12'd297: toneR = `la;  // HE (half-beat)
                    12'd298: toneR = `la;     12'd299: toneR = `la; 
                    12'd300: toneR = `la;     12'd301: toneR = `la; 
                    12'd302: toneR = `la;      12'd303: toneR = `la; 

                    12'd304: toneR = `sil;     12'd305: toneR = `sil; // HF (one-beat)
                    12'd306: toneR = `sil;     12'd307: toneR = `sil;
                    12'd308: toneR = `sil;     12'd309: toneR = `sil;
                    12'd310: toneR = `sil;     12'd311: toneR = `sil;
                    12'd312: toneR = `sil;     12'd313: toneR = `sil;
                    12'd314: toneR = `sil;     12'd315: toneR = `sil;
                    12'd316: toneR = `sil;     12'd317: toneR = `sil;
                    12'd318: toneR = `sil;     12'd319: toneR = `sil;

                    // --- Measure 6 ---
                    12'd320: toneR = `sil;     12'd321: toneR = `sil;// HE (half-beat)
                    12'd322: toneR = `sil;     12'd323: toneR = `sil;
                    12'd324: toneR = `sil;     12'd325: toneR = `sil;
                    12'd326: toneR = `sil;     12'd327: toneR = `sil; // (Short break for repetitive notes: high E)
                    12'd328: toneR = `RE;      12'd329: toneR = `RE;  // HE (half-beat)
                    12'd330: toneR = `RE;      12'd331: toneR = `RE; 
                    12'd332: toneR = `RE;      12'd333: toneR = `RE; 
                    12'd334: toneR = `RE;      12'd335: toneR = `RE;  // (Short break for repetitive notes: high E)

                    12'd336: toneR = `DO;      12'd337: toneR = `DO;  // HE (half-beat)
                    12'd338: toneR = `DO;      12'd339: toneR = `DO; 
                    12'd340: toneR = `DO;      12'd341: toneR = `DO; 
                    12'd342: toneR = `DO;      12'd343: toneR = `DO;  // (Short break for repetitive notes: high E)
                    12'd344: toneR = `RE;      12'd345: toneR = `RE;  // HE (half-beat)
                    12'd346: toneR = `RE;      12'd347: toneR = `RE; 
                    12'd348: toneR = `RE;      12'd349: toneR = `RE; 
                    12'd350: toneR = `RE;      12'd351: toneR = `RE;  // (Short break for repetitive notes: high E)

                    12'd352: toneR = `MI;      12'd353: toneR = `MI;  // HE (half-beat)
                    12'd354: toneR = `MI;      12'd355: toneR = `MI; 
                    12'd356: toneR = `MI;      12'd357: toneR = `MI; 
                    12'd358: toneR = `MI;      12'd359: toneR = `MI; 
                    12'd360: toneR = `RE;      12'd361: toneR = `RE; // HF (half-beat)
                    12'd362: toneR = `RE;      12'd363: toneR = `RE;
                    12'd364: toneR = `RE;      12'd365: toneR = `RE;
                    12'd366: toneR = `RE;      12'd367: toneR = `RE;

                    12'd368: toneR = `DO;       12'd369: toneR = `DO;  // HG (one-beat)
                    12'd370: toneR = `DO;       12'd371: toneR = `DO; 
                    12'd372: toneR = `DO;       12'd373: toneR = `DO; 
                    12'd374: toneR = `DO;       12'd375: toneR = `DO; 
                    12'd376: toneR = `SI_2;     12'd377: toneR = `SI_2;
                    12'd378: toneR = `SI_2;     12'd379: toneR = `SI_2;
                    12'd380: toneR = `SI_2;     12'd381: toneR = `SI_2;
                    12'd382: toneR = `SI_2;     12'd383: toneR = `SI_2; // (Short break for repetitive notes: high G)

                    // --- Measure 7 ---
                    12'd384: toneR = `RE;        12'd385: toneR = `RE; // HG (half-beat)
                    12'd386: toneR = `RE;        12'd387: toneR = `RE;
                    12'd388: toneR = `RE;        12'd389: toneR = `RE;
                    12'd390: toneR = `RE;        12'd391: toneR = `RE;
                    12'd392: toneR = `SI_2;      12'd393: toneR = `SI_2; // HE (half-beat)
                    12'd394: toneR = `SI_2;      12'd395: toneR = `SI_2;
                    12'd396: toneR = `SI_2;      12'd397: toneR = `SI_2;
                    12'd398: toneR = `SI_2;      12'd399: toneR = `SI_2; // (Short break for repetitive notes: high E)

                    12'd400: toneR = `sil;      12'd401: toneR = `sil;  // HE (one-beat)
                    12'd402: toneR = `sil;      12'd403: toneR = `sil; 
                    12'd404: toneR = `sil;       12'd405: toneR = `sil; 
                    12'd406: toneR = `sil;      12'd407: toneR = `sil;
                    12'd408: toneR = `SI_2;        12'd409: toneR = `SI_2;  
                    12'd410: toneR = `SI_2;        12'd414: toneR = `SI_2;  
                    12'd412: toneR = `SI_2;        12'd413: toneR = `SI_2;  
                    12'd414: toneR = `SI_2;        12'd415: toneR = `SI_2;  

                    12'd416: toneR = `DO;      12'd417: toneR = `DO;// HF (half-beat)
                    12'd418: toneR = `DO;     12'd419: toneR = `DO;
                    12'd420: toneR = `DO;      12'd421: toneR = `DO;
                    12'd422: toneR = `DO;    12'd423: toneR =  `DO;
                    12'd424: toneR = `SI_2;       12'd425: toneR = `SI_2;  // HD (half-beat)
                    12'd426: toneR = `SI_2;       12'd427: toneR = `SI_2; 
                    12'd428: toneR = `SI_2;       12'd429: toneR = `SI_2; 
                    12'd430: toneR = `SI_2;      12'd431: toneR = `SI_2;  // (Short break for repetitive notes: high D)

                    12'd432: toneR = `DO;          12'd433: toneR =`DO;     // HD (one-beat)
                    12'd434: toneR = `DO;          12'd435: toneR = `DO;     
                    12'd436: toneR = `DO;          12'd437: toneR = `DO;     
                    12'd438: toneR = `DO;           12'd439: toneR = `DO;    
                    12'd440: toneR = `SI_2;       12'd441: toneR = `SI_2;
                    12'd442: toneR = `SI_2;       12'd443: toneR = `SI_2;
                    12'd444: toneR = `SI_2;       12'd445: toneR = `SI_2; 
                    12'd446: toneR = `SI_2;       12'd447: toneR = `SI_2; 

                    // --- Measure 8 ---
                    12'd448: toneR = `RE;    12'd449: toneR = `RE; // HC (half-beat)
                    12'd450: toneR = `RE;    12'd451: toneR = `RE;
                    12'd452: toneR = `RE;    12'd453: toneR = `RE;
                    12'd454: toneR = `RE;    12'd455: toneR = `RE;
                    12'd456: toneR = `la;    12'd457: toneR = `la;  // HE (half-beat)
                    12'd458: toneR = `la;    12'd459: toneR = `la; 
                    12'd460: toneR = `la;    12'd461: toneR = `la; 
                    12'd462: toneR = `la;    12'd463: toneR = `la; 

                    12'd464: toneR = `sil;      12'd465: toneR = `sil; // HG (half-beat)
                    12'd466: toneR = `sil;      12'd467: toneR = `sil;
                    12'd468: toneR = `sil;      12'd469: toneR = `sil;
                    12'd470: toneR = `sil;      12'd471: toneR = `sil; // (Short break for repetitive notes: high G)
                    12'd472: toneR = `SI_2;     12'd473: toneR = `SI_2; // HG (half-beat)
                    12'd474: toneR = `SI_2;     12'd475: toneR = `SI_2;
                    12'd476: toneR = `SI_2;     12'd477: toneR = `SI_2;
                    12'd478: toneR = `SI_2;     12'd479: toneR = `SI_2;

                    12'd480: toneR =`la;           12'd481: toneR = `la; // HC (half-beat)
                    12'd482: toneR = `la;          12'd483: toneR = `la;
                    12'd484: toneR = `la;          12'd485: toneR = `la;
                    12'd486: toneR = `la;          12'd487: toneR = `la;
                    12'd488: toneR = `SI_2;        12'd489: toneR = `SI_2;    // HC (half-beat)
                    12'd490: toneR = `SI_2;        12'd491: toneR = `SI_2;   
                    12'd492: toneR = `SI_2;        12'd493: toneR = `SI_2;   
                    12'd494: toneR = `SI_2;        12'd495: toneR = `SI_2;   

                    12'd496: toneR = `la;       12'd497: toneR = `la; // HC (one-beat)
                    12'd498: toneR = `la;       12'd499: toneR = `la;
                    12'd500: toneR = `la;       12'd501: toneR = `la;
                    12'd502: toneR = `la;       12'd503: toneR = `la;
                    12'd504: toneR = `SI_2;     12'd505: toneR = `SI_2;
                    12'd506: toneR = `SI_2;     12'd507: toneR = `SI_2;
                    12'd508: toneR = `SI_2;     12'd509: toneR = `SI_2;
                    12'd510: toneR = `SI_2;     12'd511: toneR = `SI_2;

                    default: toneR = `sil;
            endcase
        end else begin
            toneR = `sil;
        end
    end

    always @(*) begin
        if(en == 1)begin
            case(ibeatNum)
                    12'd0: toneL = `sil;  	12'd1: toneL = `so_d; // HC (two-beat)
                    12'd2: toneL = `so_d; 	12'd3: toneL = `so_d;
                    12'd4: toneL = `so_d;	12'd5: toneL = `so_d;
                    12'd6: toneL = `so_d;  	12'd7: toneL = `so_d;
                    12'd8: toneL = `so_d;   12'd9: toneL = `so_d;
                    12'd10: toneL = `so_d;	12'd11: toneL = `so_d;
                    12'd12: toneL = `so_d;	12'd13: toneL = `so_d;
                    12'd14: toneL = `so_d;	12'd15: toneL = `so_d;

                    12'd16: toneL = `RE_d;	12'd17: toneL = `RE_d;
                    12'd18: toneL = `RE_d;	12'd19: toneL = `RE_d;
                    12'd20: toneL = `RE_d;	12'd21: toneL = `RE_d;
                    12'd22: toneL = `RE_d;	12'd23: toneL = `RE_d;
                    12'd24: toneL = `so_d;	12'd25: toneL = `so_d;
                    12'd26: toneL = `so_d;	12'd27: toneL = `so_d;
                    12'd28: toneL = `so_d;	12'd29: toneL = `so_d;
                    12'd30: toneL = `so_d;	12'd31: toneL = `so_d;

                    12'd32: toneL = `mi_d;	    12'd33: toneL = `mi_d;// G (one-beat)
                    12'd34: toneL = `mi_d;	    12'd35: toneL = `mi_d;
                    12'd36: toneL = `mi_d;	    12'd37: toneL = `mi_d;
                    12'd38: toneL = `mi_d;	    12'd39: toneL = `sil;
                    12'd40: toneL = `mi_d;	    12'd41: toneL = `mi_d;
                    12'd42: toneL = `mi_d;	    12'd43: toneL = `mi_d;
                    12'd44: toneL = `mi_d;	    12'd45: toneL = `mi_d;
                    12'd46: toneL = `mi_d;	    12'd47: toneL = `mi_d;

                    12'd48: toneL = `so_d;	    12'd49: toneL = `so_d; // B (one-beat)
                    12'd50: toneL = `so_d;	    12'd51: toneL = `so_d;
                    12'd52: toneL = `so_d;	    12'd53: toneL = `so_d;
                    12'd54: toneL = `so_d;	    12'd55: toneL = `so_d;
                    12'd56: toneL = `re_d;	    12'd57: toneL = `re_d;	 
                    12'd58: toneL = `re_d;	 	12'd59: toneL = `re_d;	 
                    12'd60: toneL = `re_d;	    12'd61: toneL = `re_d;	 
                    12'd62: toneL = `re_d; 	    12'd63: toneL = `re_d;	 
                    // --- Measure 2 ---
                    12'd64: toneL = `re_d;	   12'd65: toneL =  `re_d; // HC (two-beat)
                    12'd66: toneL =  `re_d;    12'd67: toneL =  `re_d;
                    12'd68: toneL =  `re_d;	   12'd69: toneL =  `re_d;
                    12'd70: toneL =  `re_d;	   12'd71: toneL =  `re_d;
                    12'd72: toneL = `la_d;	   12'd73: toneL = `la_d;
                    12'd74: toneL = `la_d; 	   12'd75: toneL = `la_d;
                    12'd76: toneL = `la_d;	   12'd77: toneL = `la_d;
                    12'd78: toneL = `la_d;	   12'd79: toneL = `la_d;

                    12'd80: toneL = `DO_d;   12'd81: toneL = `DO_d;
                    12'd82: toneL = `DO_d;   12'd83: toneL = `DO_d;
                    12'd84: toneL = `DO_d;   12'd85: toneL = `DO_d;
                    12'd86: toneL = `DO_d;   12'd87: toneL = `DO_d;
                    12'd88: toneL = `DO_d;   12'd89: toneL = `DO_d;
                    12'd90: toneL = `DO_d;   12'd91: toneL = `DO_d;
                    12'd92: toneL = `DO_d;   12'd93: toneL = `DO_d;
                    12'd94: toneL = `DO_d;   12'd95: toneL = `DO_d;

                    12'd96: toneL = `sil;	    12'd97: toneL = `sil; // G (one-beat)
                    12'd98: toneL = `sil;	    12'd99: toneL = `sil;
                    12'd100: toneL = `sil;	    12'd101: toneL = `sil;
                    12'd102: toneL = `sil;      12'd103: toneL = `sil;
                    12'd104: toneL = `fa_d_r;	12'd105: toneL = `fa_d_r;
                    12'd106: toneL = `fa_d_r;   12'd107: toneL = `fa_d_r;
                    12'd108: toneL = `fa_d_r;   12'd109: toneL = `fa_d_r;
                    12'd110: toneL = `fa_d_r;   12'd111: toneL = `fa_d_r;

                    12'd112: toneL = `MI_d;	12'd113: toneL = `MI_d; // B (one-beat)
                    12'd114: toneL = `MI_d;	12'd115: toneL = `MI_d;
                    12'd116: toneL = `MI_d;	12'd117: toneL = `MI_d;
                    12'd118: toneL = `MI_d;	12'd119: toneL = `MI_d;
                    12'd120: toneL = `RE_d;	12'd121: toneL = `RE_d;
                    12'd122: toneL = `RE_d;	12'd123: toneL = `RE_d;
                    12'd124: toneL = `RE_d;	12'd125: toneL = `RE_d;
                    12'd126: toneL = `RE_d;	12'd127: toneL = `RE_d;
                    // --- Measure 3 ---
                    12'd128: toneL = `so_d;    12'd129: toneL = `so_d; // HC (two-beat)
                    12'd130: toneL = `so_d;    12'd131: toneL = `so_d; 
                    12'd132: toneL = `so_d;    12'd133: toneL = `so_d; 
                    12'd134: toneL = `so_d;    12'd135: toneL = `so_d; 
                    12'd136: toneL = `so_d;    12'd137: toneL = `so_d; 
                    12'd138: toneL = `so_d;    12'd139: toneL = `so_d; 
                    12'd140: toneL = `so_d;    12'd141: toneL = `so_d; 
                    12'd142: toneL = `so_d;    12'd143: toneL = `so_d; 

                    12'd144: toneL = `RE_d;	12'd145: toneL = `RE_d; 
                    12'd146: toneL = `RE_d; 12'd147: toneL = `RE_d;
                    12'd148: toneL = `RE_d;	12'd149: toneL = `RE_d;
                    12'd150: toneL = `RE_d; 12'd151: toneL = `RE_d;
                    12'd152: toneL = `so_d;	12'd153: toneL = `so_d;	
                    12'd154: toneL = `so_d;	12'd155: toneL = `so_d;	
                    12'd156: toneL = `so_d;	12'd157: toneL = `so_d;	
                    12'd158: toneL = `so_d;	12'd159: toneL = `so_d;	

                    12'd160: toneL = `mi_d;	12'd161: toneL = `mi_d; // G (one-beat)
                    12'd162: toneL = `mi_d;	12'd163: toneL = `mi_d;
                    12'd164: toneL = `mi_d;	12'd165: toneL = `mi_d;
                    12'd166: toneL = `mi_d;	12'd167: toneL = `sil;
                    12'd168: toneL = `mi_d;	12'd169: toneL = `mi_d;
                    12'd170: toneL = `mi_d;	12'd171: toneL = `mi_d;
                    12'd172: toneL = `mi_d;	12'd173: toneL = `mi_d;
                    12'd174: toneL = `mi_d;	12'd175: toneL = `mi_d;

                    12'd176: toneL = `so_d;	12'd177: toneL = `so_d; // B (one-beat)
                    12'd178: toneL = `so_d; 12'd179: toneL = `so_d;
                    12'd180: toneL = `so_d;	12'd181: toneL = `so_d;
                    12'd182: toneL = `so_d; 12'd183: toneL = `so_d;
                    12'd184: toneL = `re_d;	12'd185: toneL = `re_d;
                    12'd186: toneL = `re_d;	12'd187: toneL = `re_d;
                    12'd188: toneL = `re_d;	12'd189: toneL = `re_d;
                    12'd190: toneL = `re_d;	12'd191: toneL = `re_d;
                    // --- Measure 4 ---
                    12'd192: toneL = `re_d;   12'd193: toneL = `re_d_2; // HC (one-beat)
                    12'd194: toneL = `re_d;   12'd195: toneL = `re_d_2;
                    12'd196: toneL = `re_d;   12'd197: toneL = `re_d_2;
                    12'd198: toneL = `re_d;   12'd199: toneL = `re_d_2;
                    12'd200: toneL = `la_d;   12'd201: toneL = `la_d; 
                    12'd202: toneL = `la_d;    12'd203: toneL = `la_d; 
                    12'd204: toneL = `la_d;    12'd205: toneL = `la_d; 
                    12'd206: toneL = `la_d;    12'd207: toneL = `la_d; 

                    12'd208: toneL = `DO_d;	12'd209: toneL = `DO_d; // G (one-beat)
                    12'd210: toneL = `DO_d;	12'd211: toneL = `DO_d;
                    12'd212: toneL = `DO_d;	12'd213: toneL = `DO_d;
                    12'd214: toneL = `DO_d;	12'd215: toneL = `DO_d;
                    12'd216: toneL = `DO_d;	12'd217: toneL = `DO_d;	
                    12'd218: toneL = `DO_d;	12'd219: toneL = `DO_d;	
                    12'd220: toneL = `DO_d;	12'd221: toneL = `DO_d;	
                    12'd222: toneL = `DO_d;	12'd223: toneL = `DO_d;

                    12'd224: toneL = `sil;   	12'd225: toneL = `sil;// E (one-beat)
                    12'd226: toneL = `sil;      12'd227: toneL = `sil;
                    12'd228: toneL = `sil;	    12'd229: toneL = `sil;
                    12'd230: toneL = `sil;	    12'd231: toneL = `sil;
                    12'd232: toneL = `fa_d_r;	12'd233: toneL = `fa_d_r;
                    12'd234: toneL = `fa_d_r;	12'd235: toneL = `fa_d_r;
                    12'd236: toneL = `fa_d_r;	12'd237: toneL = `fa_d_r;
                    12'd238: toneL = `fa_d_r;	12'd239: toneL = `fa_d_r;

                    12'd240: toneL = `MI_d;	    12'd241: toneL = `MI_d; // C (one-beat)
                    12'd242: toneL = `MI_d;     12'd243: toneL =`MI_d;
                    12'd244: toneL = `MI_d;	    12'd245: toneL = `MI_d;
                    12'd246: toneL = `MI_d;     12'd247: toneL = `MI_d;
                    12'd248: toneL = `RE_d;	    12'd249: toneL = `RE_d;	
                    12'd250: toneL = `RE_d;		12'd251: toneL = `RE_d;	
                    12'd252: toneL = `RE_d;		12'd253: toneL = `RE_d;	
                    12'd254: toneL = `RE_d;		12'd255: toneL = `RE_d;	
                    // --- Measure 5 ---
                    12'd256: toneL = `so_d;   12'd257: toneL = `so_d;  // G (two-beat)
                    12'd258: toneL = `so_d;   12'd259: toneL = `so_d; 
                    12'd260: toneL = `so_d;    12'd261: toneL = `so_d; 
                    12'd262: toneL = `so_d;    12'd263: toneL = `so_d; 
                    12'd264: toneL = `so_d;      12'd265: toneL = `so_d;  
                    12'd266: toneL = `so_d;      12'd267: toneL = `so_d;  
                    12'd268: toneL = `so_d;     12'd269: toneL = `so_d; 
                    12'd270: toneL = `so_d;      12'd271: toneL = `so_d; 

                    12'd272: toneL = `RE_d; 	12'd273: toneL = `RE_d; 
                    12'd274: toneL = `RE_d;	    12'd275: toneL = `RE_d;
                    12'd276: toneL = `RE_d;  	12'd277: toneL = `RE_d;
                    12'd278: toneL = `RE_d;	    12'd279: toneL = `RE_d;
                    12'd280: toneL = `so_d;	    12'd281: toneL = `so_d;
                    12'd282: toneL = `so_d;		12'd283: toneL = `so_d;	
                    12'd284: toneL = `so_d;		12'd285: toneL = `so_d;	
                    12'd286: toneL = `so_d;	    12'd287: toneL = `so_d;	

                    12'd288: toneL = `mi_d;	    12'd289: toneL = `mi_d;	 // F (one-beat)
                    12'd290: toneL = `mi_d;		12'd291: toneL = `mi_d;	
                    12'd292: toneL = `mi_d;	    12'd293: toneL =`mi_d;	
                    12'd294: toneL = `mi_d;		12'd295: toneL = `sil;	
                    12'd296: toneL = `mi_d; 	12'd297: toneL = `mi_d;
                    12'd298: toneL = `mi_d;     12'd299: toneL = `mi_d;
                    12'd300: toneL = `mi_d;	    12'd301: toneL = `mi_d;
                    12'd302: toneL = `mi_d;	    12'd303: toneL = `mi_d;

                    12'd304: toneL = `so_d;	  12'd305: toneL = `so_d; // D (one-beat)
                    12'd306: toneL = `so_d;   12'd307: toneL = `so_d;
                    12'd308: toneL = `so_d;   12'd309: toneL = `so_d;
                    12'd310: toneL = `so_d;   12'd311: toneL = `so_d;
                    12'd312: toneL = `re_d;	  12'd313: toneL = `re_d;	
                    12'd314: toneL = `re_d;	  12'd315: toneL = `re_d;	
                    12'd316: toneL = `re_d;	  12'd317: toneL =`re_d;	
                    12'd318: toneL = `re_d;	  12'd319: toneL = `re_d;	

                    // --- Measure 6 ---
                    12'd320: toneL = `re_d;     12'd321: toneL = `re_d; // E (two-beat)
                    12'd322: toneL = `re_d;     12'd323: toneL = `re_d;
                    12'd324: toneL = `re_d;    12'd325: toneL = `re_d;
                    12'd326: toneL = `re_d;     12'd327: toneL = `re_d;
                    12'd328: toneL = `la_d;     12'd329: toneL = `la_d; 
                    12'd330: toneL = `la_d;     12'd331: toneL = `la_d; 
                    12'd332: toneL = `la_d;      12'd333: toneL = `la_d; 
                    12'd334: toneL = `la_d;      12'd335: toneL = `la_d; 

                    12'd336: toneL = `DO_d;     12'd337: toneL = `DO_d; 
                    12'd338: toneL = `DO_d;     12'd339: toneL = `DO_d; 
                    12'd340: toneL = `DO_d;     12'd341: toneL = `DO_d; 
                    12'd342: toneL = `DO_d;     12'd343: toneL = `DO_d;
                    12'd344: toneL = `DO_d;     12'd345: toneL = `DO_d;
                    12'd346: toneL = `DO_d;     12'd347: toneL = `DO_d; 
                    12'd348: toneL = `DO_d;     12'd349: toneL = `DO_d; 
                    12'd350: toneL = `DO_d;     12'd351: toneL = `DO_d; 

                    12'd352: toneL = `sil;     12'd353: toneL = `sil;  // G (one-beat)
                    12'd354: toneL = `sil;     12'd355: toneL = `sil; 
                    12'd356: toneL = `sil;     12'd357: toneL = `sil; 
                    12'd358: toneL = `sil;     12'd359: toneL = `sil; 
                    12'd360: toneL = `fa_d_r;     12'd361: toneL = `fa_d_r;
                    12'd362: toneL = `fa_d_r;     12'd363: toneL = `fa_d_r; 
                    12'd364: toneL = `fa_d_r;     12'd365: toneL = `fa_d_r; 
                    12'd366: toneL = `fa_d_r;     12'd367: toneL = `fa_d_r;

                    12'd368: toneL = `MI_d;      12'd369: toneL = `MI_d;   // B (one-beat)
                    12'd370: toneL = `MI_d;      12'd371: toneL = `MI_d;  
                    12'd372: toneL = `MI_d;      12'd373: toneL = `MI_d;  
                    12'd374: toneL = `MI_d;      12'd375: toneL = `MI_d;  
                    12'd376: toneL = `RE_d;      12'd377: toneL = `RE_d; 
                    12'd378: toneL = `RE_d;      12'd379: toneL = `RE_d; 
                    12'd380: toneL = `RE_d;      12'd381: toneL = `RE_d; 
                    12'd382: toneL = `RE_d;      12'd383: toneL = `RE_d; 

                    // --- Measure 7 ---
                    12'd384: toneL = `so_d;         12'd385: toneL = `so_d;    // HC (two-beat)
                    12'd386: toneL = `so_d;         12'd387: toneL = `so_d;    
                    12'd388: toneL = `so_d;         12'd389: toneL = `so_d;    
                    12'd390: toneL = `so_d;         12'd391: toneL = `so_d;    
                    12'd392: toneL = `so_d;         12'd393: toneL = `so_d;   
                    12'd394: toneL = `so_d;         12'd395: toneL = `so_d;   
                    12'd396: toneL = `so_d;         12'd397: toneL = `so_d;   
                    12'd398: toneL = `so_d;         12'd399: toneL = `so_d;   

                    12'd400: toneL = `RE_d;       12'd401: toneL = `RE_d;  
                    12'd402: toneL = `RE_d;       12'd403: toneL = `RE_d;  
                    12'd404: toneL = `RE_d;       12'd405: toneL = `RE_d;  
                    12'd406: toneL = `RE_d;       12'd407: toneL = `RE_d;  
                    12'd408: toneL = `so_d;       12'd409: toneL = `so_d;
                    12'd410: toneL = `so_d;       12'd414: toneL = `so_d;
                    12'd412: toneL = `so_d;       12'd413: toneL = `so_d;
                    12'd414: toneL = `so_d;       12'd415: toneL = `so_d;

                    12'd416: toneL =  `mi_d;       12'd417: toneL =  `mi_d;  // G (one-beat)
                    12'd418: toneL =  `mi_d;       12'd419: toneL =  `mi_d; 
                    12'd420: toneL =  `mi_d;       12'd421: toneL =  `mi_d; 
                    12'd422: toneL =  `mi_d;       12'd423: toneL =  `sil; 
                    12'd424: toneL =  `mi_d;       12'd425: toneL =  `mi_d; 
                    12'd426: toneL =  `mi_d;       12'd427: toneL =  `mi_d;
                    12'd428: toneL =  `mi_d;       12'd429: toneL =  `mi_d;
                    12'd430: toneL =  `mi_d;       12'd431: toneL =  `mi_d; 

                    12'd432: toneL = `so_d;      12'd433: toneL = `so_d; // B (one-beat)
                    12'd434: toneL = `so_d;      12'd435: toneL = `so_d;
                    12'd436: toneL = `so_d;      12'd437: toneL = `so_d;
                    12'd438: toneL = `so_d;      12'd439: toneL = `so_d;
                    12'd440: toneL = `re_d;      12'd441: toneL = `re_d;
                    12'd442: toneL = `re_d;      12'd443: toneL = `re_d;
                    12'd444: toneL = `re_d;      12'd445: toneL = `re_d;
                    12'd446: toneL = `re_d;      12'd447: toneL = `re_d;

                    // --- Measure 8 ---
                    12'd448: toneL = `sil;     12'd449: toneL = `sil; // HC (half-beat)
                    12'd450: toneL = `sil;     12'd451: toneL = `sil;
                    12'd452: toneL = `sil;     12'd453: toneL = `sil;
                    12'd454: toneL = `sil;     12'd455: toneL = `sil;
                    12'd456: toneL = `sil;     12'd457: toneL = `sil;
                    12'd458: toneL = `sil;     12'd459: toneL = `sil;
                    12'd460: toneL = `sil;     12'd461: toneL = `sil;
                    12'd462: toneL = `sil;     12'd463: toneL = `sil;

                    12'd464: toneL = `sil;     12'd465: toneL = `sil; // G (one-beat)
                    12'd466: toneL = `sil;     12'd467: toneL = `sil;
                    12'd468: toneL = `sil;     12'd469: toneL = `sil;
                    12'd470: toneL = `sil;     12'd471: toneL = `sil;
                    12'd472: toneL = `sil;     12'd473: toneL = `sil;
                    12'd474: toneL = `sil;     12'd475: toneL = `sil;
                    12'd476: toneL = `sil;     12'd477: toneL = `sil;
                    12'd478: toneL = `sil;     12'd479: toneL = `sil;

                    12'd480: toneL = `sil;     12'd481: toneL = `sil; // C (two-beat)
                    12'd482: toneL = `sil;     12'd483: toneL = `sil;
                    12'd484: toneL = `sil;     12'd485: toneL = `sil;
                    12'd486: toneL = `sil;     12'd487: toneL = `sil;
                    12'd488: toneL = `sil;     12'd489: toneL = `sil;
                    12'd490: toneL = `sil;     12'd491: toneL = `sil;
                    12'd492: toneL = `sil;     12'd493: toneL = `sil;
                    12'd494: toneL = `sil;     12'd495: toneL = `sil;

                    12'd496: toneL = `sil;     12'd497: toneL = `sil;
                    12'd498: toneL = `sil;     12'd499: toneL = `sil;
                    12'd500: toneL = `sil;     12'd501: toneL = `sil;
                    12'd502: toneL = `sil;     12'd503: toneL = `sil;
                    12'd504: toneL = `sil;     12'd505: toneL = `sil;
                    12'd506: toneL = `sil;     12'd507: toneL = `sil;
                    12'd508: toneL = `sil;     12'd509: toneL = `sil;
                    12'd510: toneL = `sil;     12'd511: toneL = `sil;

                    default : toneL = `sil;
            endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule