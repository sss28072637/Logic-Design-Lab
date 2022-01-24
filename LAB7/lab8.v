`define A 32'd262 //Do
`define S 32'd294 //Re
`define D 32'd330 //Mi
`define F 32'd349 //Fa
`define G 32'd392 //So
`define H 32'd440 //La
`define J 32'd494 //Si

`define c   32'd262   // C3
`define d   32'd294
`define e   32'd330
`define f   32'd349
`define g   32'd392   // G3
`define b   32'd494   // B3
`define hc  32'd524   // C4 Do
`define hd  32'd588   // D4 Re
`define he  32'd660   // E4 Mi
`define hf  32'd698   // F4 Fa
`define hg  32'd784   // G4 So

`define mi 32'd659
`define so 32'd784
`define do 32'd523
`define re 32'd587
`define fa 32'd698
`define SO 32'd392
`define LA 32'd440
`define SI 32'd494
`define FA 32'd349
`define DO 32'd262
`define MI 32'd330
`define RE 32'd294

`define sil 32'd50000000 // slience

`define silence 32'd50000000

module music_2 (
	input [11:0] ibeatNum,
	input en,
	output reg [31:0] toneL,
    output reg [31:0] toneR
);

    always @* begin
        if(en == 1) begin
            case(ibeatNum)
                // --- Measure 1 ---
                    12'd0: toneR = `mi;      12'd1: toneR = `mi; // HG (half-beat)
                    12'd2: toneR = `mi;      12'd3: toneR = `mi;
                    12'd4: toneR = `mi;      12'd5: toneR = `mi;
                    12'd6: toneR = `mi;      12'd7: toneR = `sil;
                    12'd8: toneR = `mi;      12'd9: toneR = `mi; // HE (half-beat)
                    12'd10: toneR = `mi;     12'd11: toneR = `mi;
                    12'd12: toneR = `mi;     12'd13: toneR = `mi;
                    12'd14: toneR = `mi;     12'd15: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd16: toneR = `mi;     12'd17: toneR = `mi; // HE (one-beat)
                    12'd18: toneR = `mi;     12'd19: toneR = `mi;
                    12'd20: toneR = `mi;     12'd21: toneR = `mi;
                    12'd22: toneR = `mi;     12'd23: toneR = `mi;
                    12'd24: toneR = `mi;     12'd25: toneR = `mi;
                    12'd26: toneR = `mi;     12'd27: toneR = `mi;
                    12'd28: toneR = `mi;     12'd29: toneR = `mi;
                    12'd30: toneR = `mi;     12'd31: toneR = `mi;

                    12'd32: toneR = `mi;     12'd33: toneR = `mi; // HF (half-beat)
                    12'd34: toneR = `mi;     12'd35: toneR = `mi;
                    12'd36: toneR = `mi;     12'd37: toneR = `mi;
                    12'd38: toneR = `mi;     12'd39: toneR = `sil;
                    12'd40: toneR = `mi;     12'd41: toneR = `mi; // HD (half-beat)
                    12'd42: toneR = `mi;     12'd43: toneR = `mi;
                    12'd44: toneR = `mi;     12'd45: toneR = `mi;
                    12'd46: toneR = `mi;     12'd47: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd48: toneR = `mi;     12'd49: toneR = `mi; // HD (one-beat)
                    12'd50: toneR = `mi;     12'd51: toneR = `mi;
                    12'd52: toneR = `mi;     12'd53: toneR = `mi;
                    12'd54: toneR = `mi;     12'd55: toneR = `mi;
                    12'd56: toneR = `mi;     12'd57: toneR = `mi;
                    12'd58: toneR = `mi;     12'd59: toneR = `mi;
                    12'd60: toneR = `mi;     12'd61: toneR = `mi;
                    12'd62: toneR = `mi;     12'd63: toneR = `mi;

                    // --- Measure 2 ---
                    12'd64: toneR = `mi;     12'd65: toneR = `mi; // HC (half-beat)
                    12'd66: toneR = `mi;     12'd67: toneR = `mi;
                    12'd68: toneR = `mi;     12'd69: toneR = `mi;
                    12'd70: toneR = `mi;     12'd71: toneR = `mi;
                    12'd72: toneR = `so;     12'd73: toneR = `so; // HD (half-beat)
                    12'd74: toneR = `so;     12'd75: toneR = `so;
                    12'd76: toneR = `so;     12'd77: toneR = `so;
                    12'd78: toneR = `so;     12'd79: toneR = `sil;

                    12'd80: toneR = `do;     12'd81: toneR = `do; // HE (half-beat)
                    12'd82: toneR = `do;     12'd83: toneR = `do;
                    12'd84: toneR = `do;     12'd85: toneR = `do;
                    12'd86: toneR = `do;     12'd87: toneR = `do;
                    12'd88: toneR = `re;     12'd89: toneR = `re; // HF (half-beat)
                    12'd90: toneR = `re;     12'd91: toneR = `re;
                    12'd92: toneR = `re;     12'd93: toneR = `re;
                    12'd94: toneR = `re;     12'd95: toneR = `sil;

                    12'd96: toneR = `mi;     12'd97: toneR = `mi; // HG (half-beat)
                    12'd98: toneR = `mi;     12'd99: toneR = `mi;
                    12'd100: toneR = `mi;    12'd101: toneR = `mi;
                    12'd102: toneR = `mi;    12'd103: toneR = `mi; // (Short break for repetitive notes: high G)
                    12'd104: toneR = `mi;    12'd105: toneR = `mi; // HG (half-beat)
                    12'd106: toneR = `mi;    12'd107: toneR = `mi;
                    12'd108: toneR = `mi;    12'd109: toneR = `mi;
                    12'd110: toneR = `mi;    12'd111: toneR = `mi; // (Short break for repetitive notes: high G)

                    12'd112: toneR = `mi;    12'd113: toneR = `mi; // HG (one-beat)
                    12'd114: toneR = `mi;    12'd115: toneR = `mi;
                    12'd116: toneR = `mi;    12'd117: toneR = `mi;
                    12'd118: toneR = `mi;    12'd119: toneR = `mi;
                    12'd120: toneR = `mi;    12'd121: toneR = `mi;
                    12'd122: toneR = `mi;    12'd123: toneR = `mi;
                    12'd124: toneR = `mi;    12'd125: toneR = `mi;
                    12'd126: toneR = `mi;    12'd127: toneR = `mi; // (Short break for repetitive notes: high G)

                    // --- Measure 3 ---
                    12'd128: toneR = `fa;      12'd129: toneR = `fa; // HG (half-beat)
                    12'd130: toneR = `fa;      12'd131: toneR = `fa;
                    12'd132: toneR = `fa;      12'd133: toneR = `fa;
                    12'd134: toneR = `fa;      12'd135: toneR = `sil;
                    12'd136: toneR = `fa;      12'd137: toneR = `fa; // HE (half-beat)
                    12'd138: toneR = `fa;      12'd139: toneR = `fa;
                    12'd140: toneR = `fa;      12'd141: toneR = `fa;
                    12'd142: toneR = `fa;      12'd143: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd144: toneR = `fa;     12'd145: toneR = `fa; // HE (one-beat)
                    12'd146: toneR = `fa;     12'd147: toneR = `fa;
                    12'd148: toneR = `fa;     12'd149: toneR = `fa;
                    12'd150: toneR = `fa;     12'd151: toneR = `sil;
                    12'd152: toneR = `fa;     12'd153: toneR = `fa;
                    12'd154: toneR = `fa;     12'd155: toneR = `fa;
                    12'd156: toneR = `fa;     12'd157: toneR = `fa;
                    12'd158: toneR = `fa;     12'd159: toneR = `sil;

                    12'd160: toneR = `fa;     12'd161: toneR = `fa; // HF (half-beat)
                    12'd162: toneR = `fa;     12'd163: toneR = `fa;
                    12'd164: toneR = `fa;     12'd165: toneR = `fa;
                    12'd166: toneR = `fa;     12'd167: toneR = `fa;
                    12'd168: toneR = `mi;     12'd169: toneR = `mi; // HD (half-beat)
                    12'd170: toneR = `mi;     12'd171: toneR = `mi;
                    12'd172: toneR = `mi;     12'd173: toneR = `mi;
                    12'd174: toneR = `mi;     12'd175: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd176: toneR = `mi;     12'd177: toneR = `mi; // HD (one-beat)
                    12'd178: toneR = `mi;     12'd179: toneR = `mi;
                    12'd180: toneR = `mi;     12'd181: toneR = `mi;
                    12'd182: toneR = `mi;     12'd183: toneR = `sil;
                    12'd184: toneR = `mi;     12'd185: toneR = `mi;
                    12'd186: toneR = `mi;     12'd187: toneR = `mi;
                    12'd188: toneR = `mi;     12'd189: toneR = `mi;
                    12'd190: toneR = `mi;     12'd191: toneR = `sil;

                    // --- Measure 4 ---
                    12'd192: toneR = `mi;     12'd193: toneR = `mi; // HC (half-beat)
                    12'd194: toneR = `mi;     12'd495: toneR = `mi;
                    12'd196: toneR = `mi;     12'd197: toneR = `mi;
                    12'd198: toneR = `mi;     12'd199: toneR = `mi;
                    12'd200: toneR = `re;     12'd201: toneR = `re; // HE (half-beat)
                    12'd202: toneR = `re;     12'd203: toneR = `re;
                    12'd204: toneR = `re;     12'd205: toneR = `re;
                    12'd206: toneR = `re;     12'd207: toneR = `sil;

                    12'd208: toneR = `re;     12'd209: toneR = `re; // HG (half-beat)
                    12'd210: toneR = `re;     12'd211: toneR = `re;
                    12'd212: toneR = `re;     12'd213: toneR = `re;
                    12'd214: toneR = `re;     12'd215: toneR = `re; // (Short break for repetitive notes: high G)
                    12'd216: toneR = `mi;     12'd217: toneR = `mi; // HG (half-beat)
                    12'd218: toneR = `mi;     12'd219: toneR = `mi;
                    12'd220: toneR = `mi;     12'd221: toneR = `mi;
                    12'd222: toneR = `mi;     12'd223: toneR = `sil;

                    12'd224: toneR = `re;     12'd225: toneR = `re; // HC (half-beat)
                    12'd226: toneR = `re;     12'd227: toneR = `re;
                    12'd228: toneR = `re;     12'd229: toneR = `re;
                    12'd230: toneR = `re;     12'd231: toneR = `re; // (Short break for repetitive notes: high C)
                    12'd232: toneR = `re;     12'd233: toneR = `re; // HC (half-beat)
                    12'd234: toneR = `re;     12'd235: toneR = `re;
                    12'd236: toneR = `re;     12'd237: toneR = `re;
                    12'd238: toneR = `re;     12'd239: toneR = `re; // (Short break for repetitive notes: high C)

                    12'd240: toneR = `so;     12'd241: toneR = `so; // HC (one-beat)
                    12'd242: toneR = `so;     12'd243: toneR = `so;
                    12'd244: toneR = `so;     12'd245: toneR = `so;
                    12'd246: toneR = `so;     12'd247: toneR = `so;
                    12'd248: toneR = `so;     12'd249: toneR = `so;
                    12'd250: toneR = `so;     12'd251: toneR = `so;
                    12'd252: toneR = `so;     12'd253: toneR = `so;
                    12'd254: toneR = `so;     12'd255: toneR = `so;

                    // --- Measure 5 ---
                    12'd256: toneR = `mi;     12'd257: toneR = `mi; // HD (half-beat)
                    12'd258: toneR = `mi;     12'd259: toneR = `mi;
                    12'd260: toneR = `mi;     12'd261: toneR = `mi;
                    12'd262: toneR = `mi;     12'd263: toneR = `sil; // (Short break for repetitive notes: high D)
                    12'd264: toneR = `mi;     12'd265: toneR = `mi; // HD (half-beat)
                    12'd266: toneR = `mi;     12'd267: toneR = `mi;
                    12'd268: toneR = `mi;     12'd269: toneR = `mi;
                    12'd270: toneR = `mi;     12'd271: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd272: toneR = `mi;     12'd273: toneR = `mi; // HD (half-beat)
                    12'd274: toneR = `mi;     12'd275: toneR = `mi;
                    12'd276: toneR = `mi;     12'd277: toneR = `mi;
                    12'd278: toneR = `mi;     12'd279: toneR = `mi; // (Short break for repetitive notes: high D)
                    12'd280: toneR = `mi;     12'd281: toneR = `mi; // HD (half-beat)
                    12'd282: toneR = `mi;     12'd283: toneR = `mi;
                    12'd284: toneR = `mi;     12'd285: toneR = `mi;
                    12'd286: toneR = `mi;     12'd287: toneR = `mi; // (Short break for repetitive notes: high D)

                    12'd288: toneR = `mi;     12'd289: toneR = `mi; // HD (half-beat)
                    12'd290: toneR = `mi;     12'd291: toneR = `mi;
                    12'd292: toneR = `mi;     12'd293: toneR = `mi;
                    12'd294: toneR = `mi;     12'd295: toneR = `sil;
                    12'd296: toneR = `mi;     12'd297: toneR = `mi; // HE (half-beat)
                    12'd298: toneR = `mi;     12'd299: toneR = `mi;
                    12'd300: toneR = `mi;     12'd301: toneR = `mi;
                    12'd302: toneR = `mi;     12'd303: toneR = `mi;

                    12'd304: toneR = `mi;     12'd305: toneR = `mi; // HF (one-beat)
                    12'd306: toneR = `mi;     12'd307: toneR = `mi;
                    12'd308: toneR = `mi;     12'd309: toneR = `mi;
                    12'd310: toneR = `mi;     12'd311: toneR = `mi;
                    12'd312: toneR = `mi;     12'd313: toneR = `mi;
                    12'd314: toneR = `mi;     12'd315: toneR = `mi;
                    12'd316: toneR = `mi;     12'd317: toneR = `mi;
                    12'd318: toneR = `mi;     12'd319: toneR = `mi;

                    // --- Measure 6 ---
                    12'd320: toneR = `mi;     12'd321: toneR = `mi; // HE (half-beat)
                    12'd322: toneR = `mi;     12'd323: toneR = `mi;
                    12'd324: toneR = `mi;     12'd325: toneR = `mi;
                    12'd326: toneR = `mi;     12'd327: toneR = `mi; // (Short break for repetitive notes: high E)
                    12'd328: toneR = `so;     12'd329: toneR = `so; // HE (half-beat)
                    12'd330: toneR = `so;     12'd331: toneR = `so;
                    12'd332: toneR = `so;     12'd333: toneR = `so;
                    12'd334: toneR = `so;     12'd335: toneR = `so; // (Short break for repetitive notes: high E)

                    12'd336: toneR = `do;     12'd337: toneR = `do; // HE (half-beat)
                    12'd338: toneR = `do;     12'd339: toneR = `do;
                    12'd340: toneR = `do;     12'd341: toneR = `do;
                    12'd342: toneR = `do;     12'd343: toneR = `do; // (Short break for repetitive notes: high E)
                    12'd344: toneR = `re;     12'd345: toneR = `re; // HE (half-beat)
                    12'd346: toneR = `re;     12'd347: toneR = `re;
                    12'd348: toneR = `re;     12'd349: toneR = `re;
                    12'd350: toneR = `re;     12'd351: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd352: toneR = `mi;     12'd353: toneR = `mi; // HE (half-beat)
                    12'd354: toneR = `mi;     12'd355: toneR = `mi;
                    12'd356: toneR = `mi;     12'd357: toneR = `mi;
                    12'd358: toneR = `mi;     12'd359: toneR = `mi;
                    12'd360: toneR = `mi;     12'd361: toneR = `mi; // HF (half-beat)
                    12'd362: toneR = `mi;     12'd363: toneR = `mi;
                    12'd364: toneR = `mi;     12'd365: toneR = `mi;
                    12'd366: toneR = `mi;     12'd367: toneR = `mi;

                    12'd368: toneR = `mi;     12'd369: toneR = `mi; // HG (one-beat)
                    12'd370: toneR = `mi;     12'd371: toneR = `mi;
                    12'd372: toneR = `mi;     12'd373: toneR = `mi;
                    12'd374: toneR = `mi;     12'd375: toneR = `mi;
                    12'd376: toneR = `mi;     12'd377: toneR = `mi;
                    12'd378: toneR = `mi;     12'd379: toneR = `mi;
                    12'd380: toneR = `mi;     12'd381: toneR = `mi;
                    12'd382: toneR = `mi;     12'd383: toneR = `mi; // (Short break for repetitive notes: high G)

                    // --- Measure 7 ---
                    12'd384: toneR = `fa;      12'd385: toneR = `fa; // HG (half-beat)
                    12'd386: toneR = `fa;      12'd387: toneR = `fa;
                    12'd388: toneR = `fa;      12'd389: toneR = `fa;
                    12'd390: toneR = `fa;      12'd391: toneR = `sil;
                    12'd392: toneR = `fa;      12'd393: toneR = `fa; // HE (half-beat)
                    12'd394: toneR = `fa;      12'd395: toneR = `fa;
                    12'd396: toneR = `fa;      12'd397: toneR = `fa;
                    12'd398: toneR = `fa;      12'd399: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd400: toneR = `fa;      12'd401: toneR = `fa; // HE (one-beat)
                    12'd402: toneR = `fa;      12'd403: toneR = `fa;
                    12'd404: toneR = `fa;      12'd405: toneR = `fa;
                    12'd406: toneR = `fa;      12'd407: toneR = `fa;
                    12'd408: toneR = `fa;      12'd409: toneR = `sil;
                    12'd410: toneR = `fa;      12'd414: toneR = `fa;
                    12'd412: toneR = `fa;      12'd413: toneR = `fa;
                    12'd414: toneR = `fa;      12'd415: toneR = `sil;

                    12'd416: toneR = `fa;      12'd417: toneR = `fa; // HF (half-beat)
                    12'd418: toneR = `fa;      12'd419: toneR = `fa;
                    12'd420: toneR = `fa;      12'd421: toneR = `fa;
                    12'd422: toneR = `fa;      12'd423: toneR = `fa;
                    12'd424: toneR = `mi;      12'd425: toneR = `mi; // HD (half-beat)
                    12'd426: toneR = `mi;      12'd427: toneR = `mi;
                    12'd428: toneR = `mi;      12'd429: toneR = `mi;
                    12'd430: toneR = `mi;      12'd431: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd432: toneR = `mi;      12'd433: toneR = `mi; // HD (one-beat)
                    12'd434: toneR = `mi;      12'd435: toneR = `mi;
                    12'd436: toneR = `mi;      12'd437: toneR = `mi;
                    12'd438: toneR = `mi;      12'd439: toneR = `sil;
                    12'd440: toneR = `mi;      12'd441: toneR = `mi;
                    12'd442: toneR = `mi;      12'd443: toneR = `mi;
                    12'd444: toneR = `mi;      12'd445: toneR = `mi;
                    12'd446: toneR = `mi;      12'd447: toneR = `sil;

                    // --- Measure 8 ---
                    12'd448: toneR = `so;     12'd449: toneR = `so; // HC (half-beat)
                    12'd450: toneR = `so;     12'd451: toneR = `so;
                    12'd452: toneR = `so;     12'd453: toneR = `so;
                    12'd454: toneR = `so;     12'd455: toneR = `sil;
                    12'd456: toneR = `so;     12'd457: toneR = `so; // HE (half-beat)
                    12'd458: toneR = `so;     12'd459: toneR = `so;
                    12'd460: toneR = `so;     12'd461: toneR = `so;
                    12'd462: toneR = `so;     12'd463: toneR = `so;

                    12'd464: toneR = `fa;     12'd465: toneR = `fa; // HG (half-beat)
                    12'd466: toneR = `fa;     12'd467: toneR = `fa;
                    12'd468: toneR = `fa;     12'd469: toneR = `fa;
                    12'd470: toneR = `fa;     12'd471: toneR = `fa; // (Short break for repetitive notes: high G)
                    12'd472: toneR = `re;     12'd473: toneR = `re; // HG (half-beat)
                    12'd474: toneR = `re;     12'd475: toneR = `re;
                    12'd476: toneR = `re;     12'd477: toneR = `re;
                    12'd478: toneR = `re;     12'd479: toneR = `re;

                    12'd480: toneR = `do;     12'd481: toneR = `do; // HC (half-beat)
                    12'd482: toneR = `do;     12'd483: toneR = `do;
                    12'd484: toneR = `do;     12'd485: toneR = `do;
                    12'd486: toneR = `do;     12'd487: toneR = `do;
                    12'd488: toneR = `do;     12'd489: toneR = `do; // HC (half-beat)
                    12'd490: toneR = `do;     12'd491: toneR = `do;
                    12'd492: toneR = `do;     12'd493: toneR = `do;
                    12'd494: toneR = `do;     12'd495: toneR = `do;

                    12'd496: toneR = `do;     12'd497: toneR = `do; // HC (one-beat)
                    12'd498: toneR = `do;     12'd499: toneR = `do;
                    12'd500: toneR = `do;     12'd501: toneR = `do;
                    12'd502: toneR = `do;     12'd503: toneR = `do;
                    12'd504: toneR = `do;     12'd505: toneR = `do;
                    12'd506: toneR = `do;     12'd507: toneR = `do;
                    12'd508: toneR = `do;     12'd509: toneR = `do;
                    12'd510: toneR = `do;     12'd511: toneR = `do;

                    default: toneR = `sil;
            endcase
        end else begin
            toneR = `sil;
        end
    end

    always @(*) begin
        if(en == 1)begin
            case(ibeatNum)
                    12'd0: toneL = `do;  	12'd1: toneL = `do; // HC (two-beat)
                    12'd2: toneL = `do;  	12'd3: toneL = `do;
                    12'd4: toneL = `do;	    12'd5: toneL = `do;
                    12'd6: toneL = `do;  	12'd7: toneL = `do;
                    12'd8: toneL = `do;	    12'd9: toneL = `do;
                    12'd10: toneL = `do;	12'd11: toneL = `do;
                    12'd12: toneL = `do;	12'd13: toneL = `do;
                    12'd14: toneL = `do;	12'd15: toneL = `do;

                    12'd16: toneL = `SO;	12'd17: toneL = `SO;
                    12'd18: toneL = `SO;	12'd19: toneL = `SO;
                    12'd20: toneL = `SO;	12'd21: toneL = `SO;
                    12'd22: toneL = `SO;	12'd23: toneL = `SO;
                    12'd24: toneL = `SO;	12'd25: toneL = `SO;
                    12'd26: toneL = `SO;	12'd27: toneL = `SO;
                    12'd28: toneL = `SO;	12'd29: toneL = `SO;
                    12'd30: toneL = `SO;	12'd31: toneL = `SO;

                    12'd32: toneL = `do;	    12'd33: toneL = `do; // G (one-beat)
                    12'd34: toneL = `do;	    12'd35: toneL = `do;
                    12'd36: toneL = `do;	    12'd37: toneL = `do;
                    12'd38: toneL = `do;	    12'd39: toneL = `do;
                    12'd40: toneL = `do;	    12'd41: toneL = `do;
                    12'd42: toneL = `do;	    12'd43: toneL = `do;
                    12'd44: toneL = `do;	    12'd45: toneL = `do;
                    12'd46: toneL = `do;	    12'd47: toneL = `do;

                    12'd48: toneL = `SO;	    12'd49: toneL = `SO; // B (one-beat)
                    12'd50: toneL = `SO;	    12'd51: toneL = `SO;
                    12'd52: toneL = `SO;	    12'd53: toneL = `SO;
                    12'd54: toneL = `SO;	    12'd55: toneL = `SO;
                    12'd56: toneL = `SO;	    12'd57: toneL = `SO;
                    12'd58: toneL = `SO;	    12'd59: toneL = `SO;
                    12'd60: toneL = `SO;	    12'd61: toneL = `SO;
                    12'd62: toneL = `SO;	    12'd63: toneL = `SO;

                    12'd64: toneL = `do;	12'd65: toneL = `do; // HC (two-beat)
                    12'd66: toneL = `do;    12'd67: toneL = `do;
                    12'd68: toneL = `do;	12'd69: toneL = `do;
                    12'd70: toneL = `do;	12'd71: toneL = `do;
                    12'd72: toneL = `do;	12'd73: toneL = `do;
                    12'd74: toneL = `do;	12'd75: toneL = `do;
                    12'd76: toneL = `do;	12'd77: toneL = `do;
                    12'd78: toneL = `do;	12'd79: toneL = `do;

                    12'd80: toneL = `SO;	12'd81: toneL = `SO;
                    12'd82: toneL = `SO;    12'd83: toneL = `SO;
                    12'd84: toneL = `SO;    12'd85: toneL = `SO;
                    12'd86: toneL = `SO;    12'd87: toneL = `SO;
                    12'd88: toneL = `SO;    12'd89: toneL = `SO;
                    12'd90: toneL = `SO;    12'd91: toneL = `SO;
                    12'd92: toneL = `SO;    12'd93: toneL = `SO;
                    12'd94: toneL = `SO;    12'd95: toneL = `SO;

                    12'd96: toneL = `do;	12'd97: toneL = `do; // G (one-beat)
                    12'd98: toneL = `do; 	12'd99: toneL = `do;
                    12'd100: toneL = `do;	12'd101: toneL = `do;
                    12'd102: toneL = `do;	12'd103: toneL = `do;
                    12'd104: toneL = `SO;	12'd105: toneL = `SO;
                    12'd106: toneL = `SO;	12'd107: toneL = `SO;
                    12'd108: toneL = `SO;	12'd109: toneL = `SO;
                    12'd110: toneL = `SO;	12'd111: toneL = `SO;

                    12'd112: toneL = `LA;	12'd113: toneL = `LA; // B (one-beat)
                    12'd114: toneL = `LA;	12'd115: toneL = `LA;
                    12'd116: toneL = `LA;	12'd117: toneL = `LA;
                    12'd118: toneL = `LA;	12'd119: toneL = `LA;
                    12'd120: toneL = `SI;	12'd121: toneL = `SI;
                    12'd122: toneL = `SI;	12'd123: toneL = `SI;
                    12'd124: toneL = `SI;	12'd125: toneL = `SI;
                    12'd126: toneL = `SI;	12'd127: toneL = `sil;

                    12'd128: toneL = `re;   12'd129: toneL = `re; // HC (two-beat)
                    12'd130: toneL = `re;   12'd131: toneL = `re;
                    12'd132: toneL = `re;   12'd133: toneL = `re;
                    12'd134: toneL = `re;   12'd135: toneL = `re;
                    12'd136: toneL = `re;   12'd137: toneL = `re;
                    12'd138: toneL = `re;   12'd139: toneL = `re;
                    12'd140: toneL = `re;   12'd141: toneL = `re;
                    12'd142: toneL = `re;   12'd143: toneL = `re;

                    12'd144: toneL = `FA;	12'd145: toneL = `FA; 
                    12'd146: toneL = `FA; 	12'd147: toneL = `FA;
                    12'd148: toneL = `FA;	12'd149: toneL = `FA;
                    12'd150: toneL = `FA;	12'd151: toneL = `FA;
                    12'd152: toneL = `FA;	12'd153: toneL = `FA;
                    12'd154: toneL = `FA;	12'd155: toneL = `FA;
                    12'd156: toneL = `FA;	12'd157: toneL = `FA;
                    12'd158: toneL = `FA;	12'd159: toneL = `FA;

                    12'd160: toneL = `do;	12'd161: toneL = `do; // G (one-beat)
                    12'd162: toneL = `do;	12'd163: toneL = `do;
                    12'd164: toneL = `do;	12'd165: toneL = `do;
                    12'd166: toneL = `do;	12'd167: toneL = `do;
                    12'd168: toneL = `do;	12'd169: toneL = `do;
                    12'd170: toneL = `do;	12'd171: toneL = `do;
                    12'd172: toneL = `do;	12'd173: toneL = `do;
                    12'd174: toneL = `do;	12'd175: toneL = `do;

                    12'd176: toneL = `MI;	12'd177: toneL = `MI; // B (one-beat)
                    12'd178: toneL = `MI;   12'd179: toneL = `MI;
                    12'd180: toneL = `MI;	12'd181: toneL = `MI;
                    12'd182: toneL = `MI;   12'd183: toneL = `MI;
                    12'd184: toneL = `MI;	12'd185: toneL = `MI;
                    12'd186: toneL = `MI;	12'd187: toneL = `MI;
                    12'd188: toneL = `MI;	12'd189: toneL = `MI;
                    12'd190: toneL = `MI;	12'd191: toneL = `MI;

                    12'd192: toneL = `SO;   12'd193: toneL = `SO; // HC (one-beat)
                    12'd194: toneL = `SO;   12'd195: toneL = `SO;
                    12'd196: toneL = `SO;   12'd197: toneL = `SO;
                    12'd198: toneL = `SO;   12'd199: toneL = `SO;
                    12'd200: toneL = `SO;   12'd201: toneL = `SO;
                    12'd202: toneL = `SO;   12'd203: toneL = `SO;
                    12'd204: toneL = `SO;   12'd205: toneL = `SO;
                    12'd206: toneL = `SO;   12'd207: toneL = `SO;

                    12'd208: toneL = `FA;	12'd209: toneL = `FA; // G (one-beat)
                    12'd210: toneL = `FA;	12'd211: toneL = `FA;
                    12'd212: toneL = `FA;	12'd213: toneL = `FA;
                    12'd214: toneL = `FA;	12'd215: toneL = `FA;
                    12'd216: toneL = `FA;	12'd217: toneL = `FA;
                    12'd218: toneL = `FA;	12'd219: toneL = `FA;
                    12'd220: toneL = `FA;	12'd221: toneL = `FA;
                    12'd222: toneL = `FA;	12'd223: toneL = `FA;

                    12'd224: toneL = `RE;	12'd225: toneL = `RE; // E (one-beat)
                    12'd226: toneL = `RE; 	12'd227: toneL = `RE;
                    12'd228: toneL = `RE;	12'd229: toneL = `RE;
                    12'd230: toneL = `RE;	12'd231: toneL = `RE;
                    12'd232: toneL = `RE;	12'd233: toneL = `RE;
                    12'd234: toneL = `RE;	12'd235: toneL = `RE;
                    12'd236: toneL = `RE;	12'd237: toneL = `RE;
                    12'd238: toneL = `RE;	12'd239: toneL = `RE;

                    12'd240: toneL = `SI;	12'd241: toneL = `SI; // C (one-beat)
                    12'd242: toneL = `SI;   12'd243: toneL = `SI;
                    12'd244: toneL = `SI;	12'd245: toneL = `SI;
                    12'd246: toneL = `SI;   12'd247: toneL = `SI;
                    12'd248: toneL = `SI;	12'd249: toneL = `SI;
                    12'd250: toneL = `SI;	12'd251: toneL = `SI;
                    12'd252: toneL = `SI;	12'd253: toneL = `SI;
                    12'd254: toneL = `SI;	12'd255: toneL = `SI;

                    12'd256: toneL = `do;   12'd257: toneL = `do; // G (two-beat)
                    12'd258: toneL = `do;   12'd259: toneL = `do;
                    12'd260: toneL = `do;   12'd261: toneL = `do;
                    12'd262: toneL = `do;   12'd263: toneL = `do;
                    12'd264: toneL = `do;   12'd265: toneL = `do;
                    12'd266: toneL = `do;   12'd267: toneL = `do;
                    12'd268: toneL = `do;   12'd269: toneL = `do;
                    12'd270: toneL = `do;   12'd271: toneL = `do;

                    12'd272: toneL = `SO;	12'd273: toneL = `SO; 
                    12'd274: toneL = `SO; 	12'd275: toneL = `SO;
                    12'd276: toneL = `SO;	12'd277: toneL = `SO;
                    12'd278: toneL = `SO;	12'd279: toneL = `SO;
                    12'd280: toneL = `SO;	12'd281: toneL = `SO;
                    12'd282: toneL = `SO;	12'd283: toneL = `SO;
                    12'd284: toneL = `SO;	12'd285: toneL = `SO;
                    12'd286: toneL = `SO;	12'd287: toneL = `SO;

                    12'd288: toneL = `do;	12'd289: toneL = `do; // F (one-beat)
                    12'd290: toneL = `do;	12'd291: toneL = `do;
                    12'd292: toneL = `do;	12'd293: toneL = `do;
                    12'd294: toneL = `do;	12'd295: toneL = `do;
                    12'd296: toneL = `do;	12'd297: toneL = `do;
                    12'd298: toneL = `do;	12'd299: toneL = `do;
                    12'd300: toneL = `do;	12'd301: toneL = `do;
                    12'd302: toneL = `do;	12'd303: toneL = `do;

                    12'd304: toneL = `SO;	12'd305: toneL = `SO; // D (one-beat)
                    12'd306: toneL = `SO;   12'd307: toneL = `SO;
                    12'd308: toneL = `SO;	12'd309: toneL = `SO;
                    12'd310: toneL = `SO;   12'd311: toneL = `SO;
                    12'd312: toneL = `SO;	12'd313: toneL = `SO;
                    12'd314: toneL = `SO;	12'd315: toneL = `SO;
                    12'd316: toneL = `SO;	12'd317: toneL = `SO;
                    12'd318: toneL = `SO;	12'd319: toneL = `SO;

                    // --- Measure 6 ---
                    12'd320: toneL = `do;     12'd321: toneL = `do; // E (two-beat)
                    12'd322: toneL = `do;     12'd323: toneL = `do;
                    12'd324: toneL = `do;     12'd325: toneL = `do;
                    12'd326: toneL = `do;     12'd327: toneL = `do;
                    12'd328: toneL = `do;     12'd329: toneL = `do;
                    12'd330: toneL = `do;     12'd331: toneL = `do;
                    12'd332: toneL = `do;     12'd333: toneL = `do;
                    12'd334: toneL = `do;     12'd335: toneL = `do;

                    12'd336: toneL = `SO;     12'd337: toneL = `SO;
                    12'd338: toneL = `SO;     12'd339: toneL = `SO;
                    12'd340: toneL = `SO;     12'd341: toneL = `SO;
                    12'd342: toneL = `SO;     12'd343: toneL = `SO;
                    12'd344: toneL = `SO;     12'd345: toneL = `SO;
                    12'd346: toneL = `SO;     12'd347: toneL = `SO;
                    12'd348: toneL = `SO;     12'd349: toneL = `SO;
                    12'd350: toneL = `SO;     12'd351: toneL = `SO;

                    12'd352: toneL = `do;     12'd353: toneL = `do; // G (one-beat)
                    12'd354: toneL = `do;     12'd355: toneL = `do;
                    12'd356: toneL = `do;     12'd357: toneL = `do;
                    12'd358: toneL = `do;     12'd359: toneL = `do;
                    12'd360: toneL = `SO;     12'd361: toneL = `SO;
                    12'd362: toneL = `SO;     12'd363: toneL = `SO;
                    12'd364: toneL = `SO;     12'd365: toneL = `SO;
                    12'd366: toneL = `SO;     12'd367: toneL = `SO;

                    12'd368: toneL = `LA;     12'd369: toneL = `LA; // B (one-beat)
                    12'd370: toneL = `LA;     12'd371: toneL = `LA;
                    12'd372: toneL = `LA;     12'd373: toneL = `LA;
                    12'd374: toneL = `LA;     12'd375: toneL = `LA;
                    12'd376: toneL = `SI;     12'd377: toneL = `SI;
                    12'd378: toneL = `SI;     12'd379: toneL = `SI;
                    12'd380: toneL = `SI;     12'd381: toneL = `SI;
                    12'd382: toneL = `SI;     12'd383: toneL = `SI;

                    // --- Measure 7 ---
                    12'd384: toneL = `re;      12'd385: toneL = `re; // HC (two-beat)
                    12'd386: toneL = `re;      12'd387: toneL = `re;
                    12'd388: toneL = `re;      12'd389: toneL = `re;
                    12'd390: toneL = `re;      12'd391: toneL = `re;
                    12'd392: toneL = `re;      12'd393: toneL = `re;
                    12'd394: toneL = `re;      12'd395: toneL = `re;
                    12'd396: toneL = `re;      12'd397: toneL = `re;
                    12'd398: toneL = `re;      12'd399: toneL = `re;

                    12'd400: toneL = `FA;      12'd401: toneL = `FA;
                    12'd402: toneL = `FA;      12'd403: toneL = `FA;
                    12'd404: toneL = `FA;      12'd405: toneL = `FA;
                    12'd406: toneL = `FA;      12'd407: toneL = `FA;
                    12'd408: toneL = `FA;      12'd409: toneL = `FA;
                    12'd410: toneL = `FA;      12'd414: toneL = `FA;
                    12'd412: toneL = `FA;      12'd413: toneL = `FA;
                    12'd414: toneL = `FA;      12'd415: toneL = `FA;

                    12'd416: toneL = `do;      12'd417: toneL = `do; // G (one-beat)
                    12'd418: toneL = `do;      12'd419: toneL = `do;
                    12'd420: toneL = `do;      12'd421: toneL = `do;
                    12'd422: toneL = `do;      12'd423: toneL = `do;
                    12'd424: toneL = `do;      12'd425: toneL = `do;
                    12'd426: toneL = `do;      12'd427: toneL = `do;
                    12'd428: toneL = `do;      12'd429: toneL = `do;
                    12'd430: toneL = `do;      12'd431: toneL = `do;

                    12'd432: toneL = `MI;      12'd433: toneL = `MI; // B (one-beat)
                    12'd434: toneL = `MI;      12'd435: toneL = `MI;
                    12'd436: toneL = `MI;      12'd437: toneL = `MI;
                    12'd438: toneL = `MI;      12'd439: toneL = `MI;
                    12'd440: toneL = `MI;      12'd441: toneL = `MI;
                    12'd442: toneL = `MI;      12'd443: toneL = `MI;
                    12'd444: toneL = `MI;      12'd445: toneL = `MI;
                    12'd446: toneL = `MI;      12'd447: toneL = `MI;

                    // --- Measure 8 ---
                    12'd448: toneL = `do;     12'd449: toneL = `do; // HC (half-beat)
                    12'd450: toneL = `do;     12'd451: toneL = `do;
                    12'd452: toneL = `do;     12'd453: toneL = `do;
                    12'd454: toneL = `do;     12'd455: toneL = `do;
                    12'd456: toneL = `do;     12'd457: toneL = `do;
                    12'd458: toneL = `do;     12'd459: toneL = `do;
                    12'd460: toneL = `do;     12'd461: toneL = `do;
                    12'd462: toneL = `do;     12'd463: toneL = `do;

                    12'd464: toneL = `SO;     12'd465: toneL = `SO; // G (one-beat)
                    12'd466: toneL = `SO;     12'd467: toneL = `SO;
                    12'd468: toneL = `SO;     12'd469: toneL = `SO;
                    12'd470: toneL = `SO;     12'd471: toneL = `SO;
                    12'd472: toneL = `SO;     12'd473: toneL = `SO;
                    12'd474: toneL = `SO;     12'd475: toneL = `SO;
                    12'd476: toneL = `SO;     12'd477: toneL = `SO;
                    12'd478: toneL = `SO;     12'd479: toneL = `SO;

                    12'd480: toneL = `DO;     12'd481: toneL = `DO; // C (two-beat)
                    12'd482: toneL = `DO;     12'd483: toneL = `DO;
                    12'd484: toneL = `DO;     12'd485: toneL = `DO;
                    12'd486: toneL = `DO;     12'd487: toneL = `DO;
                    12'd488: toneL = `DO;     12'd489: toneL = `DO;
                    12'd490: toneL = `DO;     12'd491: toneL = `DO;
                    12'd492: toneL = `DO;     12'd493: toneL = `DO;
                    12'd494: toneL = `DO;     12'd495: toneL = `DO;

                    12'd496: toneL = `DO;     12'd497: toneL = `DO;
                    12'd498: toneL = `DO;     12'd499: toneL = `DO;
                    12'd500: toneL = `DO;     12'd501: toneL = `DO;
                    12'd502: toneL = `DO;     12'd503: toneL = `DO;
                    12'd504: toneL = `DO;     12'd505: toneL = `DO;
                    12'd506: toneL = `DO;     12'd507: toneL = `DO;
                    12'd508: toneL = `DO;     12'd509: toneL = `DO;
                    12'd510: toneL = `DO;     12'd511: toneL = `DO;

                    default : toneL = `sil;
            endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule

module music_example (
	input [11:0] ibeatNum,
	input en,
	output reg [31:0] toneL,
    output reg [31:0] toneR
);

    always @* begin
        if(en == 1) begin
            case(ibeatNum)
                // --- Measure 1 ---
                    12'd0: toneR = `hg;      12'd1: toneR = `hg; // HG (half-beat)
                    12'd2: toneR = `hg;      12'd3: toneR = `hg;
                    12'd4: toneR = `hg;      12'd5: toneR = `hg;
                    12'd6: toneR = `hg;      12'd7: toneR = `hg;
                    12'd8: toneR = `he;      12'd9: toneR = `he; // HE (half-beat)
                    12'd10: toneR = `he;     12'd11: toneR = `he;
                    12'd12: toneR = `he;     12'd13: toneR = `he;
                    12'd14: toneR = `he;     12'd15: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd16: toneR = `he;     12'd17: toneR = `he; // HE (one-beat)
                    12'd18: toneR = `he;     12'd19: toneR = `he;
                    12'd20: toneR = `he;     12'd21: toneR = `he;
                    12'd22: toneR = `he;     12'd23: toneR = `he;
                    12'd24: toneR = `he;     12'd25: toneR = `he;
                    12'd26: toneR = `he;     12'd27: toneR = `he;
                    12'd28: toneR = `he;     12'd29: toneR = `he;
                    12'd30: toneR = `he;     12'd31: toneR = `he;

                    12'd32: toneR = `hf;     12'd33: toneR = `hf; // HF (half-beat)
                    12'd34: toneR = `hf;     12'd35: toneR = `hf;
                    12'd36: toneR = `hf;     12'd37: toneR = `hf;
                    12'd38: toneR = `hf;     12'd39: toneR = `hf;
                    12'd40: toneR = `hd;     12'd41: toneR = `hd; // HD (half-beat)
                    12'd42: toneR = `hd;     12'd43: toneR = `hd;
                    12'd44: toneR = `hd;     12'd45: toneR = `hd;
                    12'd46: toneR = `hd;     12'd47: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd48: toneR = `hd;     12'd49: toneR = `hd; // HD (one-beat)
                    12'd50: toneR = `hd;     12'd51: toneR = `hd;
                    12'd52: toneR = `hd;     12'd53: toneR = `hd;
                    12'd54: toneR = `hd;     12'd55: toneR = `hd;
                    12'd56: toneR = `hd;     12'd57: toneR = `hd;
                    12'd58: toneR = `hd;     12'd59: toneR = `hd;
                    12'd60: toneR = `hd;     12'd61: toneR = `hd;
                    12'd62: toneR = `hd;     12'd63: toneR = `hd;

                    // --- Measure 2 ---
                    12'd64: toneR = `hc;     12'd65: toneR = `hc; // HC (half-beat)
                    12'd66: toneR = `hc;     12'd67: toneR = `hc;
                    12'd68: toneR = `hc;     12'd69: toneR = `hc;
                    12'd70: toneR = `hc;     12'd71: toneR = `hc;
                    12'd72: toneR = `hd;     12'd73: toneR = `hd; // HD (half-beat)
                    12'd74: toneR = `hd;     12'd75: toneR = `hd;
                    12'd76: toneR = `hd;     12'd77: toneR = `hd;
                    12'd78: toneR = `hd;     12'd79: toneR = `hd;

                    12'd80: toneR = `he;     12'd81: toneR = `he; // HE (half-beat)
                    12'd82: toneR = `he;     12'd83: toneR = `he;
                    12'd84: toneR = `he;     12'd85: toneR = `he;
                    12'd86: toneR = `he;     12'd87: toneR = `he;
                    12'd88: toneR = `hf;     12'd89: toneR = `hf; // HF (half-beat)
                    12'd90: toneR = `hf;     12'd91: toneR = `hf;
                    12'd92: toneR = `hf;     12'd93: toneR = `hf;
                    12'd94: toneR = `hf;     12'd95: toneR = `hf;

                    12'd96: toneR = `hg;     12'd97: toneR = `hg; // HG (half-beat)
                    12'd98: toneR = `hg;     12'd99: toneR = `hg;
                    12'd100: toneR = `hg;    12'd101: toneR = `hg;
                    12'd102: toneR = `hg;    12'd103: toneR = `sil; // (Short break for repetitive notes: high G)
                    12'd104: toneR = `hg;    12'd105: toneR = `hg; // HG (half-beat)
                    12'd106: toneR = `hg;    12'd107: toneR = `hg;
                    12'd108: toneR = `hg;    12'd109: toneR = `hg;
                    12'd110: toneR = `hg;    12'd111: toneR = `sil; // (Short break for repetitive notes: high G)

                    12'd112: toneR = `hg;    12'd113: toneR = `hg; // HG (one-beat)
                    12'd114: toneR = `hg;    12'd115: toneR = `hg;
                    12'd116: toneR = `hg;    12'd117: toneR = `hg;
                    12'd118: toneR = `hg;    12'd119: toneR = `hg;
                    12'd120: toneR = `hg;    12'd121: toneR = `hg;
                    12'd122: toneR = `hg;    12'd123: toneR = `hg;
                    12'd124: toneR = `hg;    12'd125: toneR = `hg;
                    12'd126: toneR = `hg;    12'd127: toneR = `sil; // (Short break for repetitive notes: high G)

                    // --- Measure 3 ---
                    12'd128: toneR = `hg;      12'd129: toneR = `hg; // HG (half-beat)
                    12'd130: toneR = `hg;      12'd131: toneR = `hg;
                    12'd132: toneR = `hg;      12'd133: toneR = `hg;
                    12'd134: toneR = `hg;      12'd135: toneR = `hg;
                    12'd136: toneR = `he;      12'd137: toneR = `he; // HE (half-beat)
                    12'd138: toneR = `he;      12'd139: toneR = `he;
                    12'd140: toneR = `he;      12'd141: toneR = `he;
                    12'd142: toneR = `he;      12'd143: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd144: toneR = `he;     12'd145: toneR = `he; // HE (one-beat)
                    12'd146: toneR = `he;     12'd147: toneR = `he;
                    12'd148: toneR = `he;     12'd149: toneR = `he;
                    12'd150: toneR = `he;     12'd151: toneR = `he;
                    12'd152: toneR = `he;     12'd153: toneR = `he;
                    12'd154: toneR = `he;     12'd155: toneR = `he;
                    12'd156: toneR = `he;     12'd157: toneR = `he;
                    12'd158: toneR = `he;     12'd159: toneR = `he;

                    12'd160: toneR = `hf;     12'd161: toneR = `hf; // HF (half-beat)
                    12'd162: toneR = `hf;     12'd163: toneR = `hf;
                    12'd164: toneR = `hf;     12'd165: toneR = `hf;
                    12'd166: toneR = `hf;     12'd167: toneR = `hf;
                    12'd168: toneR = `hd;     12'd169: toneR = `hd; // HD (half-beat)
                    12'd170: toneR = `hd;     12'd171: toneR = `hd;
                    12'd172: toneR = `hd;     12'd173: toneR = `hd;
                    12'd174: toneR = `hd;     12'd175: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd176: toneR = `hd;     12'd177: toneR = `hd; // HD (one-beat)
                    12'd178: toneR = `hd;     12'd179: toneR = `hd;
                    12'd180: toneR = `hd;     12'd181: toneR = `hd;
                    12'd182: toneR = `hd;     12'd183: toneR = `hd;
                    12'd184: toneR = `hd;     12'd185: toneR = `hd;
                    12'd186: toneR = `hd;     12'd187: toneR = `hd;
                    12'd188: toneR = `hd;     12'd189: toneR = `hd;
                    12'd190: toneR = `hd;     12'd191: toneR = `hd;

                    // --- Measure 4 ---
                    12'd192: toneR = `hc;     12'd193: toneR = `hc; // HC (half-beat)
                    12'd194: toneR = `hc;     12'd495: toneR = `hc;
                    12'd196: toneR = `hc;     12'd197: toneR = `hc;
                    12'd198: toneR = `hc;     12'd199: toneR = `hc;
                    12'd200: toneR = `he;     12'd201: toneR = `he; // HE (half-beat)
                    12'd202: toneR = `he;     12'd203: toneR = `he;
                    12'd204: toneR = `he;     12'd205: toneR = `he;
                    12'd206: toneR = `he;     12'd207: toneR = `he;

                    12'd208: toneR = `hg;     12'd209: toneR = `hg; // HG (half-beat)
                    12'd210: toneR = `hg;     12'd211: toneR = `hg;
                    12'd212: toneR = `hg;     12'd213: toneR = `hg;
                    12'd214: toneR = `hg;     12'd215: toneR = `sil; // (Short break for repetitive notes: high G)
                    12'd216: toneR = `hg;     12'd217: toneR = `hg; // HG (half-beat)
                    12'd218: toneR = `hg;     12'd219: toneR = `hg;
                    12'd220: toneR = `hg;     12'd221: toneR = `hg;
                    12'd222: toneR = `hg;     12'd223: toneR = `hg;

                    12'd224: toneR = `he;     12'd225: toneR = `he; // HC (half-beat)
                    12'd226: toneR = `he;     12'd227: toneR = `he;
                    12'd228: toneR = `he;     12'd229: toneR = `he;
                    12'd230: toneR = `he;     12'd231: toneR = `sil; // (Short break for repetitive notes: high C)
                    12'd232: toneR = `he;     12'd233: toneR = `he; // HC (half-beat)
                    12'd234: toneR = `he;     12'd235: toneR = `he;
                    12'd236: toneR = `he;     12'd237: toneR = `he;
                    12'd238: toneR = `he;     12'd239: toneR = `sil; // (Short break for repetitive notes: high C)

                    12'd240: toneR = `he;     12'd241: toneR = `he; // HC (one-beat)
                    12'd242: toneR = `he;     12'd243: toneR = `he;
                    12'd244: toneR = `he;     12'd245: toneR = `he;
                    12'd246: toneR = `he;     12'd247: toneR = `he;
                    12'd248: toneR = `he;     12'd249: toneR = `he;
                    12'd250: toneR = `he;     12'd251: toneR = `he;
                    12'd252: toneR = `he;     12'd253: toneR = `he;
                    12'd254: toneR = `he;     12'd255: toneR = `he;

                    // --- Measure 5 ---
                    12'd256: toneR = `hd;     12'd257: toneR = `hd; // HD (half-beat)
                    12'd258: toneR = `hd;     12'd259: toneR = `hd;
                    12'd260: toneR = `hd;     12'd261: toneR = `hd;
                    12'd262: toneR = `hd;     12'd263: toneR = `sil; // (Short break for repetitive notes: high D)
                    12'd264: toneR = `hd;     12'd265: toneR = `hd; // HD (half-beat)
                    12'd266: toneR = `hd;     12'd267: toneR = `hd;
                    12'd268: toneR = `hd;     12'd269: toneR = `hd;
                    12'd270: toneR = `hd;     12'd271: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd272: toneR = `hd;     12'd273: toneR = `hd; // HD (half-beat)
                    12'd274: toneR = `hd;     12'd275: toneR = `hd;
                    12'd276: toneR = `hd;     12'd277: toneR = `hd;
                    12'd278: toneR = `hd;     12'd279: toneR = `sil; // (Short break for repetitive notes: high D)
                    12'd280: toneR = `hd;     12'd281: toneR = `hd; // HD (half-beat)
                    12'd282: toneR = `hd;     12'd283: toneR = `hd;
                    12'd284: toneR = `hd;     12'd285: toneR = `hd;
                    12'd286: toneR = `hd;     12'd287: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd288: toneR = `hd;     12'd289: toneR = `hd; // HD (half-beat)
                    12'd290: toneR = `hd;     12'd291: toneR = `hd;
                    12'd292: toneR = `hd;     12'd293: toneR = `hd;
                    12'd294: toneR = `hd;     12'd295: toneR = `hd;
                    12'd296: toneR = `he;     12'd297: toneR = `he; // HE (half-beat)
                    12'd298: toneR = `he;     12'd299: toneR = `he;
                    12'd300: toneR = `he;     12'd301: toneR = `he;
                    12'd302: toneR = `he;     12'd303: toneR = `he;

                    12'd304: toneR = `hf;     12'd305: toneR = `hf; // HF (one-beat)
                    12'd306: toneR = `hf;     12'd307: toneR = `hf;
                    12'd308: toneR = `hf;     12'd309: toneR = `hf;
                    12'd310: toneR = `hf;     12'd311: toneR = `hf;
                    12'd312: toneR = `hf;     12'd313: toneR = `hf;
                    12'd314: toneR = `hf;     12'd315: toneR = `hf;
                    12'd316: toneR = `hf;     12'd317: toneR = `hf;
                    12'd318: toneR = `hf;     12'd319: toneR = `hf;

                    // --- Measure 6 ---
                    12'd320: toneR = `he;     12'd321: toneR = `he; // HE (half-beat)
                    12'd322: toneR = `he;     12'd323: toneR = `he;
                    12'd324: toneR = `he;     12'd325: toneR = `he;
                    12'd326: toneR = `he;     12'd327: toneR = `sil; // (Short break for repetitive notes: high E)
                    12'd328: toneR = `he;     12'd329: toneR = `he; // HE (half-beat)
                    12'd330: toneR = `he;     12'd331: toneR = `he;
                    12'd332: toneR = `he;     12'd333: toneR = `he;
                    12'd334: toneR = `he;     12'd335: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd336: toneR = `he;     12'd337: toneR = `he; // HE (half-beat)
                    12'd338: toneR = `he;     12'd339: toneR = `he;
                    12'd340: toneR = `he;     12'd341: toneR = `he;
                    12'd342: toneR = `he;     12'd343: toneR = `sil; // (Short break for repetitive notes: high E)
                    12'd344: toneR = `he;     12'd345: toneR = `he; // HE (half-beat)
                    12'd346: toneR = `he;     12'd347: toneR = `he;
                    12'd348: toneR = `he;     12'd349: toneR = `he;
                    12'd350: toneR = `he;     12'd351: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd352: toneR = `he;     12'd353: toneR = `he; // HE (half-beat)
                    12'd354: toneR = `he;     12'd355: toneR = `he;
                    12'd356: toneR = `he;     12'd357: toneR = `he;
                    12'd358: toneR = `he;     12'd359: toneR = `he;
                    12'd360: toneR = `hf;     12'd361: toneR = `hf; // HF (half-beat)
                    12'd362: toneR = `hf;     12'd363: toneR = `hf;
                    12'd364: toneR = `hf;     12'd365: toneR = `hf;
                    12'd366: toneR = `hf;     12'd367: toneR = `hf;

                    12'd368: toneR = `hg;     12'd369: toneR = `hg; // HG (one-beat)
                    12'd370: toneR = `hg;     12'd371: toneR = `hg;
                    12'd372: toneR = `hg;     12'd373: toneR = `hg;
                    12'd374: toneR = `hg;     12'd375: toneR = `hg;
                    12'd376: toneR = `hg;     12'd377: toneR = `hg;
                    12'd378: toneR = `hg;     12'd379: toneR = `hg;
                    12'd380: toneR = `hg;     12'd381: toneR = `hg;
                    12'd382: toneR = `hg;     12'd383: toneR = `sil; // (Short break for repetitive notes: high G)

                    // --- Measure 7 ---
                    12'd384: toneR = `hg;      12'd385: toneR = `hg; // HG (half-beat)
                    12'd386: toneR = `hg;      12'd387: toneR = `hg;
                    12'd388: toneR = `hg;      12'd389: toneR = `hg;
                    12'd390: toneR = `hg;      12'd391: toneR = `hg;
                    12'd392: toneR = `he;      12'd393: toneR = `he; // HE (half-beat)
                    12'd394: toneR = `he;      12'd395: toneR = `he;
                    12'd396: toneR = `he;      12'd397: toneR = `he;
                    12'd398: toneR = `he;      12'd399: toneR = `sil; // (Short break for repetitive notes: high E)

                    12'd400: toneR = `he;      12'd401: toneR = `he; // HE (one-beat)
                    12'd402: toneR = `he;      12'd403: toneR = `he;
                    12'd404: toneR = `he;      12'd405: toneR = `he;
                    12'd406: toneR = `he;      12'd407: toneR = `he;
                    12'd408: toneR = `he;      12'd409: toneR = `he;
                    12'd410: toneR = `he;      12'd414: toneR = `he;
                    12'd412: toneR = `he;      12'd413: toneR = `he;
                    12'd414: toneR = `he;      12'd415: toneR = `he;

                    12'd416: toneR = `hf;      12'd417: toneR = `hf; // HF (half-beat)
                    12'd418: toneR = `hf;      12'd419: toneR = `hf;
                    12'd420: toneR = `hf;      12'd421: toneR = `hf;
                    12'd422: toneR = `hf;      12'd423: toneR = `hf;
                    12'd424: toneR = `hd;      12'd425: toneR = `hd; // HD (half-beat)
                    12'd426: toneR = `hd;      12'd427: toneR = `hd;
                    12'd428: toneR = `hd;      12'd429: toneR = `hd;
                    12'd430: toneR = `hd;      12'd431: toneR = `sil; // (Short break for repetitive notes: high D)

                    12'd432: toneR = `hd;      12'd433: toneR = `hd; // HD (one-beat)
                    12'd434: toneR = `hd;      12'd435: toneR = `hd;
                    12'd436: toneR = `hd;      12'd437: toneR = `hd;
                    12'd438: toneR = `hd;      12'd439: toneR = `hd;
                    12'd440: toneR = `hd;      12'd441: toneR = `hd;
                    12'd442: toneR = `hd;      12'd443: toneR = `hd;
                    12'd444: toneR = `hd;      12'd445: toneR = `hd;
                    12'd446: toneR = `hd;      12'd447: toneR = `hd;

                    // --- Measure 8 ---
                    12'd448: toneR = `hc;     12'd449: toneR = `hc; // HC (half-beat)
                    12'd450: toneR = `hc;     12'd451: toneR = `hc;
                    12'd452: toneR = `hc;     12'd453: toneR = `hc;
                    12'd454: toneR = `hc;     12'd455: toneR = `hc;
                    12'd456: toneR = `he;     12'd457: toneR = `he; // HE (half-beat)
                    12'd458: toneR = `he;     12'd459: toneR = `he;
                    12'd460: toneR = `he;     12'd461: toneR = `he;
                    12'd462: toneR = `he;     12'd463: toneR = `he;

                    12'd464: toneR = `hg;     12'd465: toneR = `hg; // HG (half-beat)
                    12'd466: toneR = `hg;     12'd467: toneR = `hg;
                    12'd468: toneR = `hg;     12'd469: toneR = `hg;
                    12'd470: toneR = `hg;     12'd471: toneR = `sil; // (Short break for repetitive notes: high G)
                    12'd472: toneR = `hg;     12'd473: toneR = `hg; // HG (half-beat)
                    12'd474: toneR = `hg;     12'd475: toneR = `hg;
                    12'd476: toneR = `hg;     12'd477: toneR = `hg;
                    12'd478: toneR = `hg;     12'd479: toneR = `hg;

                    12'd480: toneR = `hc;     12'd481: toneR = `hc; // HC (half-beat)
                    12'd482: toneR = `hc;     12'd483: toneR = `hc;
                    12'd484: toneR = `hc;     12'd485: toneR = `hc;
                    12'd486: toneR = `hc;     12'd487: toneR = `hc;
                    12'd488: toneR = `hc;     12'd489: toneR = `hc; // HC (half-beat)
                    12'd490: toneR = `hc;     12'd491: toneR = `hc;
                    12'd492: toneR = `hc;     12'd493: toneR = `hc;
                    12'd494: toneR = `hc;     12'd495: toneR = `hc;

                    12'd496: toneR = `hc;     12'd497: toneR = `hc; // HC (one-beat)
                    12'd498: toneR = `hc;     12'd499: toneR = `hc;
                    12'd500: toneR = `hc;     12'd501: toneR = `hc;
                    12'd502: toneR = `hc;     12'd503: toneR = `hc;
                    12'd504: toneR = `hc;     12'd505: toneR = `hc;
                    12'd506: toneR = `hc;     12'd507: toneR = `hc;
                    12'd508: toneR = `hc;     12'd509: toneR = `hc;
                    12'd510: toneR = `hc;     12'd511: toneR = `hc;

                    default: toneR = `sil;
            endcase
        end else begin
            toneR = `sil;
        end
    end

    always @(*) begin
        if(en == 1)begin
            case(ibeatNum)
                12'd0: toneL = `hc;  	12'd1: toneL = `hc; // HC (two-beat)
                    12'd2: toneL = `hc;  	12'd3: toneL = `hc;
                    12'd4: toneL = `hc;	    12'd5: toneL = `hc;
                    12'd6: toneL = `hc;  	12'd7: toneL = `hc;
                    12'd8: toneL = `hc;	    12'd9: toneL = `hc;
                    12'd10: toneL = `hc;	12'd11: toneL = `hc;
                    12'd12: toneL = `hc;	12'd13: toneL = `hc;
                    12'd14: toneL = `hc;	12'd15: toneL = `hc;

                    12'd16: toneL = `hc;	12'd17: toneL = `hc;
                    12'd18: toneL = `hc;	12'd19: toneL = `hc;
                    12'd20: toneL = `hc;	12'd21: toneL = `hc;
                    12'd22: toneL = `hc;	12'd23: toneL = `hc;
                    12'd24: toneL = `hc;	12'd25: toneL = `hc;
                    12'd26: toneL = `hc;	12'd27: toneL = `hc;
                    12'd28: toneL = `hc;	12'd29: toneL = `hc;
                    12'd30: toneL = `hc;	12'd31: toneL = `hc;

                    12'd32: toneL = `g;	    12'd33: toneL = `g; // G (one-beat)
                    12'd34: toneL = `g;	    12'd35: toneL = `g;
                    12'd36: toneL = `g;	    12'd37: toneL = `g;
                    12'd38: toneL = `g;	    12'd39: toneL = `g;
                    12'd40: toneL = `g;	    12'd41: toneL = `g;
                    12'd42: toneL = `g;	    12'd43: toneL = `g;
                    12'd44: toneL = `g;	    12'd45: toneL = `g;
                    12'd46: toneL = `g;	    12'd47: toneL = `g;

                    12'd48: toneL = `b;	    12'd49: toneL = `b; // B (one-beat)
                    12'd50: toneL = `b;	    12'd51: toneL = `b;
                    12'd52: toneL = `b;	    12'd53: toneL = `b;
                    12'd54: toneL = `b;	    12'd55: toneL = `b;
                    12'd56: toneL = `b;	    12'd57: toneL = `b;
                    12'd58: toneL = `b;	    12'd59: toneL = `b;
                    12'd60: toneL = `b;	    12'd61: toneL = `b;
                    12'd62: toneL = `b;	    12'd63: toneL = `b;

                    12'd64: toneL = `hc;	12'd65: toneL = `hc; // HC (two-beat)
                    12'd66: toneL = `hc;    12'd67: toneL = `hc;
                    12'd68: toneL = `hc;	12'd69: toneL = `hc;
                    12'd70: toneL = `hc;	12'd71: toneL = `hc;
                    12'd72: toneL = `hc;	12'd73: toneL = `hc;
                    12'd74: toneL = `hc;	12'd75: toneL = `hc;
                    12'd76: toneL = `hc;	12'd77: toneL = `hc;
                    12'd78: toneL = `hc;	12'd79: toneL = `hc;

                    12'd80: toneL = `hc;	12'd81: toneL = `hc;
                    12'd82: toneL = `hc;    12'd83: toneL = `hc;
                    12'd84: toneL = `hc;    12'd85: toneL = `hc;
                    12'd86: toneL = `hc;    12'd87: toneL = `hc;
                    12'd88: toneL = `hc;    12'd89: toneL = `hc;
                    12'd90: toneL = `hc;    12'd91: toneL = `hc;
                    12'd92: toneL = `hc;    12'd93: toneL = `hc;
                    12'd94: toneL = `hc;    12'd95: toneL = `hc;

                    12'd96: toneL = `g;	    12'd97: toneL = `g; // G (one-beat)
                    12'd98: toneL = `g; 	12'd99: toneL = `g;
                    12'd100: toneL = `g;	12'd101: toneL = `g;
                    12'd102: toneL = `g;	12'd103: toneL = `g;
                    12'd104: toneL = `g;	12'd105: toneL = `g;
                    12'd106: toneL = `g;	12'd107: toneL = `g;
                    12'd108: toneL = `g;	12'd109: toneL = `g;
                    12'd110: toneL = `g;	12'd111: toneL = `g;

                    12'd112: toneL = `b;	12'd113: toneL = `b; // B (one-beat)
                    12'd114: toneL = `b;	12'd115: toneL = `b;
                    12'd116: toneL = `b;	12'd117: toneL = `b;
                    12'd118: toneL = `b;	12'd119: toneL = `b;
                    12'd120: toneL = `b;	12'd121: toneL = `b;
                    12'd122: toneL = `b;	12'd123: toneL = `b;
                    12'd124: toneL = `b;	12'd125: toneL = `b;
                    12'd126: toneL = `b;	12'd127: toneL = `b;

                    12'd128: toneL = `hc;   12'd129: toneL = `hc; // HC (two-beat)
                    12'd130: toneL = `hc;   12'd131: toneL = `hc;
                    12'd132: toneL = `hc;   12'd133: toneL = `hc;
                    12'd134: toneL = `hc;   12'd135: toneL = `hc;
                    12'd136: toneL = `hc;   12'd137: toneL = `hc;
                    12'd138: toneL = `hc;   12'd139: toneL = `hc;
                    12'd140: toneL = `hc;   12'd141: toneL = `hc;
                    12'd142: toneL = `hc;   12'd143: toneL = `hc;

                    12'd144: toneL = `hc;	12'd145: toneL = `hc; 
                    12'd146: toneL = `hc; 	12'd147: toneL = `hc;
                    12'd148: toneL = `hc;	12'd149: toneL = `hc;
                    12'd150: toneL = `hc;	12'd151: toneL = `hc;
                    12'd152: toneL = `hc;	12'd153: toneL = `hc;
                    12'd154: toneL = `hc;	12'd155: toneL = `hc;
                    12'd156: toneL = `hc;	12'd157: toneL = `hc;
                    12'd158: toneL = `hc;	12'd159: toneL = `hc;

                    12'd160: toneL = `g;	12'd161: toneL = `g; // G (one-beat)
                    12'd162: toneL = `g;	12'd163: toneL = `g;
                    12'd164: toneL = `g;	12'd165: toneL = `g;
                    12'd166: toneL = `g;	12'd167: toneL = `g;
                    12'd168: toneL = `g;	12'd169: toneL = `g;
                    12'd170: toneL = `g;	12'd171: toneL = `g;
                    12'd172: toneL = `g;	12'd173: toneL = `g;
                    12'd174: toneL = `g;	12'd175: toneL = `g;

                    12'd176: toneL = `b;	12'd177: toneL = `b; // B (one-beat)
                    12'd178: toneL = `b;    12'd179: toneL = `b;
                    12'd180: toneL = `b;	12'd181: toneL = `b;
                    12'd182: toneL = `b;    12'd183: toneL = `b;
                    12'd184: toneL = `b;	12'd185: toneL = `b;
                    12'd186: toneL = `b;	12'd187: toneL = `b;
                    12'd188: toneL = `b;	12'd189: toneL = `b;
                    12'd190: toneL = `b;	12'd191: toneL = `b;

                    12'd192: toneL = `hc;   12'd193: toneL = `hc; // HC (one-beat)
                    12'd194: toneL = `hc;   12'd195: toneL = `hc;
                    12'd196: toneL = `hc;   12'd197: toneL = `hc;
                    12'd198: toneL = `hc;   12'd199: toneL = `hc;
                    12'd200: toneL = `hc;   12'd201: toneL = `hc;
                    12'd202: toneL = `hc;   12'd203: toneL = `hc;
                    12'd204: toneL = `hc;   12'd205: toneL = `hc;
                    12'd206: toneL = `hc;   12'd207: toneL = `hc;

                    12'd208: toneL = `g;	12'd209: toneL = `g; // G (one-beat)
                    12'd210: toneL = `g;	12'd211: toneL = `g;
                    12'd212: toneL = `g;	12'd213: toneL = `g;
                    12'd214: toneL = `g;	12'd215: toneL = `g;
                    12'd216: toneL = `g;	12'd217: toneL = `g;
                    12'd218: toneL = `g;	12'd219: toneL = `g;
                    12'd220: toneL = `g;	12'd221: toneL = `g;
                    12'd222: toneL = `g;	12'd223: toneL = `g;

                    12'd224: toneL = `e;	12'd225: toneL = `e; // E (one-beat)
                    12'd226: toneL = `e; 	12'd227: toneL = `e;
                    12'd228: toneL = `e;	12'd229: toneL = `e;
                    12'd230: toneL = `e;	12'd231: toneL = `e;
                    12'd232: toneL = `e;	12'd233: toneL = `e;
                    12'd234: toneL = `e;	12'd235: toneL = `e;
                    12'd236: toneL = `e;	12'd237: toneL = `e;
                    12'd238: toneL = `e;	12'd239: toneL = `e;

                    12'd240: toneL = `c;	12'd241: toneL = `c; // C (one-beat)
                    12'd242: toneL = `c;    12'd243: toneL = `c;
                    12'd244: toneL = `c;	12'd245: toneL = `c;
                    12'd246: toneL = `c;    12'd247: toneL = `c;
                    12'd248: toneL = `c;	12'd249: toneL = `c;
                    12'd250: toneL = `c;	12'd251: toneL = `c;
                    12'd252: toneL = `c;	12'd253: toneL = `c;
                    12'd254: toneL = `c;	12'd255: toneL = `c;

                    12'd256: toneL = `g;   12'd257: toneL = `g; // G (two-beat)
                    12'd258: toneL = `g;   12'd259: toneL = `g;
                    12'd260: toneL = `g;   12'd261: toneL = `g;
                    12'd262: toneL = `g;   12'd263: toneL = `g;
                    12'd264: toneL = `g;   12'd265: toneL = `g;
                    12'd266: toneL = `g;   12'd267: toneL = `g;
                    12'd268: toneL = `g;   12'd269: toneL = `g;
                    12'd270: toneL = `g;   12'd271: toneL = `g;

                    12'd272: toneL = `g;	12'd273: toneL = `g; 
                    12'd274: toneL = `g; 	12'd275: toneL = `g;
                    12'd276: toneL = `g;	12'd277: toneL = `g;
                    12'd278: toneL = `g;	12'd279: toneL = `g;
                    12'd280: toneL = `g;	12'd281: toneL = `g;
                    12'd282: toneL = `g;	12'd283: toneL = `g;
                    12'd284: toneL = `g;	12'd285: toneL = `g;
                    12'd286: toneL = `g;	12'd287: toneL = `g;

                    12'd288: toneL = `f;	12'd289: toneL = `f; // F (one-beat)
                    12'd290: toneL = `f;	12'd291: toneL = `f;
                    12'd292: toneL = `f;	12'd293: toneL = `f;
                    12'd294: toneL = `f;	12'd295: toneL = `f;
                    12'd296: toneL = `f;	12'd297: toneL = `f;
                    12'd298: toneL = `f;	12'd299: toneL = `f;
                    12'd300: toneL = `f;	12'd301: toneL = `f;
                    12'd302: toneL = `f;	12'd303: toneL = `f;

                    12'd304: toneL = `d;	12'd305: toneL = `d; // D (one-beat)
                    12'd306: toneL = `d;    12'd307: toneL = `d;
                    12'd308: toneL = `d;	12'd309: toneL = `d;
                    12'd310: toneL = `d;    12'd311: toneL = `d;
                    12'd312: toneL = `d;	12'd313: toneL = `d;
                    12'd314: toneL = `d;	12'd315: toneL = `d;
                    12'd316: toneL = `d;	12'd317: toneL = `d;
                    12'd318: toneL = `d;	12'd319: toneL = `d;

                    // --- Measure 6 ---
                    12'd320: toneL = `e;     12'd321: toneL = `e; // E (two-beat)
                    12'd322: toneL = `e;     12'd323: toneL = `e;
                    12'd324: toneL = `e;     12'd325: toneL = `e;
                    12'd326: toneL = `e;     12'd327: toneL = `e;
                    12'd328: toneL = `e;     12'd329: toneL = `e;
                    12'd330: toneL = `e;     12'd331: toneL = `e;
                    12'd332: toneL = `e;     12'd333: toneL = `e;
                    12'd334: toneL = `e;     12'd335: toneL = `e;

                    12'd336: toneL = `e;     12'd337: toneL = `e;
                    12'd338: toneL = `e;     12'd339: toneL = `e;
                    12'd340: toneL = `e;     12'd341: toneL = `e;
                    12'd342: toneL = `e;     12'd343: toneL = `e;
                    12'd344: toneL = `e;     12'd345: toneL = `e;
                    12'd346: toneL = `e;     12'd347: toneL = `e;
                    12'd348: toneL = `e;     12'd349: toneL = `e;
                    12'd350: toneL = `e;     12'd351: toneL = `e;

                    12'd352: toneL = `g;     12'd353: toneL = `g; // G (one-beat)
                    12'd354: toneL = `g;     12'd355: toneL = `g;
                    12'd356: toneL = `g;     12'd357: toneL = `g;
                    12'd358: toneL = `g;     12'd359: toneL = `g;
                    12'd360: toneL = `g;     12'd361: toneL = `g;
                    12'd362: toneL = `g;     12'd363: toneL = `g;
                    12'd364: toneL = `g;     12'd365: toneL = `g;
                    12'd366: toneL = `g;     12'd367: toneL = `g;

                    12'd368: toneL = `b;     12'd369: toneL = `b; // B (one-beat)
                    12'd370: toneL = `b;     12'd371: toneL = `b;
                    12'd372: toneL = `b;     12'd373: toneL = `b;
                    12'd374: toneL = `b;     12'd375: toneL = `b;
                    12'd376: toneL = `b;     12'd377: toneL = `b;
                    12'd378: toneL = `b;     12'd379: toneL = `b;
                    12'd380: toneL = `b;     12'd381: toneL = `b;
                    12'd382: toneL = `b;     12'd383: toneL = `b;

                    // --- Measure 7 ---
                    12'd384: toneL = `hc;      12'd385: toneL = `hc; // HC (two-beat)
                    12'd386: toneL = `hc;      12'd387: toneL = `hc;
                    12'd388: toneL = `hc;      12'd389: toneL = `hc;
                    12'd390: toneL = `hc;      12'd391: toneL = `hc;
                    12'd392: toneL = `hc;      12'd393: toneL = `hc;
                    12'd394: toneL = `hc;      12'd395: toneL = `hc;
                    12'd396: toneL = `hc;      12'd397: toneL = `hc;
                    12'd398: toneL = `hc;      12'd399: toneL = `hc;

                    12'd400: toneL = `hc;      12'd401: toneL = `hc;
                    12'd402: toneL = `hc;      12'd403: toneL = `hc;
                    12'd404: toneL = `hc;      12'd405: toneL = `hc;
                    12'd406: toneL = `hc;      12'd407: toneL = `hc;
                    12'd408: toneL = `hc;      12'd409: toneL = `hc;
                    12'd410: toneL = `hc;      12'd414: toneL = `hc;
                    12'd412: toneL = `hc;      12'd413: toneL = `hc;
                    12'd414: toneL = `hc;      12'd415: toneL = `hc;

                    12'd416: toneL = `g;      12'd417: toneL = `g; // G (one-beat)
                    12'd418: toneL = `g;      12'd419: toneL = `g;
                    12'd420: toneL = `g;      12'd421: toneL = `g;
                    12'd422: toneL = `g;      12'd423: toneL = `g;
                    12'd424: toneL = `g;      12'd425: toneL = `g;
                    12'd426: toneL = `g;      12'd427: toneL = `g;
                    12'd428: toneL = `g;      12'd429: toneL = `g;
                    12'd430: toneL = `g;      12'd431: toneL = `g;

                    12'd432: toneL = `b;      12'd433: toneL = `b; // B (one-beat)
                    12'd434: toneL = `b;      12'd435: toneL = `b;
                    12'd436: toneL = `b;      12'd437: toneL = `b;
                    12'd438: toneL = `b;      12'd439: toneL = `b;
                    12'd440: toneL = `b;      12'd441: toneL = `b;
                    12'd442: toneL = `b;      12'd443: toneL = `b;
                    12'd444: toneL = `b;      12'd445: toneL = `b;
                    12'd446: toneL = `b;      12'd447: toneL = `b;

                    // --- Measure 8 ---
                    12'd448: toneL = `hc;     12'd449: toneL = `hc; // HC (half-beat)
                    12'd450: toneL = `hc;     12'd451: toneL = `hc;
                    12'd452: toneL = `hc;     12'd453: toneL = `hc;
                    12'd454: toneL = `hc;     12'd455: toneL = `hc;
                    12'd456: toneL = `hc;     12'd457: toneL = `hc;
                    12'd458: toneL = `hc;     12'd459: toneL = `hc;
                    12'd460: toneL = `hc;     12'd461: toneL = `hc;
                    12'd462: toneL = `hc;     12'd463: toneL = `hc;

                    12'd464: toneL = `g;     12'd465: toneL = `g; // G (one-beat)
                    12'd466: toneL = `g;     12'd467: toneL = `g;
                    12'd468: toneL = `g;     12'd469: toneL = `g;
                    12'd470: toneL = `g;     12'd471: toneL = `g;
                    12'd472: toneL = `g;     12'd473: toneL = `g;
                    12'd474: toneL = `g;     12'd475: toneL = `g;
                    12'd476: toneL = `g;     12'd477: toneL = `g;
                    12'd478: toneL = `g;     12'd479: toneL = `g;

                    12'd480: toneL = `c;     12'd481: toneL = `c; // C (two-beat)
                    12'd482: toneL = `c;     12'd483: toneL = `c;
                    12'd484: toneL = `c;     12'd485: toneL = `c;
                    12'd486: toneL = `c;     12'd487: toneL = `c;
                    12'd488: toneL = `c;     12'd489: toneL = `c;
                    12'd490: toneL = `c;     12'd491: toneL = `c;
                    12'd492: toneL = `c;     12'd493: toneL = `c;
                    12'd494: toneL = `c;     12'd495: toneL = `c;

                    12'd496: toneL = `c;     12'd497: toneL = `c;
                    12'd498: toneL = `c;     12'd499: toneL = `c;
                    12'd500: toneL = `c;     12'd501: toneL = `c;
                    12'd502: toneL = `c;     12'd503: toneL = `c;
                    12'd504: toneL = `c;     12'd505: toneL = `c;
                    12'd506: toneL = `c;     12'd507: toneL = `c;
                    12'd508: toneL = `c;     12'd509: toneL = `c;
                    12'd510: toneL = `c;     12'd511: toneL = `c;

                    default : toneL = `sil;
            endcase
        end
        else begin
            toneL = `sil;
        end
    end
endmodule

module clock_divider(clk, clk_div);   
    parameter n = 26;     
    input clk;   
    output clk_div;   
    
    reg [n-1:0] num;
    wire [n-1:0] next_num;
    
    always@(posedge clk)begin
        num<=next_num;
    end
    
    assign next_num = num +1;
    assign clk_div = num[n-1];
    
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
	input _play, 
	input _slow, 
	input _mode, 
    input _music,
	output reg [11:0] ibeat
);
	parameter LEN = 4095;
    reg [11:0] next_ibeat;

	reg [1:0] count, count_next;
    reg music_now;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			ibeat <= 0;
			count <= 0;
            music_now <= 0;
		end else begin
            ibeat <= next_ibeat;
			count <= count_next;
            music_now <= _music;
		end
	end
	always @* begin
        if(_music != music_now) begin
            next_ibeat = 0;
            count_next = 0;
        end
		else if(_play && _mode && ((count==2 && _slow) || !_slow)) begin
            next_ibeat = (ibeat + 1 <= LEN) ? (ibeat+1) : 0;
            count_next = 0;
		end
		else begin
			next_ibeat = ibeat;
			if(_slow && _mode) begin
				count_next = count + 1;
			end
			else begin
				count_next = count;
			end
		end
    end

endmodule


module lab8(
    clk,        // clock from crystal
    rst,        // BTNC: active high reset
    _play,      // SW0: Play/Pause
    _mute,      // SW1: Mute
    _slow,      // SW2: Slow
    _music,     // SW3: Music
    _mode,      // SW15: Mode
    _volUP,     // BTNU: Vol up
    _volDOWN,   // BTND: Vol down
    _higherOCT, // BTNR: Oct higher
    _lowerOCT,  // BTNL: Oct lower
    PS2_DATA,   // Keyboard I/O
    PS2_CLK,    // Keyboard I/O
    _led,       // LED: [15:13] octave & [4:0] volume
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck,  // serial clock
    audio_sdin, // serial audio data input
    DISPLAY,    // 7-seg
    DIGIT       // 7-seg
);
    // I/O declaration
    input clk; 
    input rst; 
    input _play, _mute, _slow, _music, _mode; 
    input _volUP, _volDOWN, _higherOCT, _lowerOCT; 
    inout PS2_DATA; 
	inout PS2_CLK; 
    output [15:0] _led; 
    output audio_mclk; 
    output audio_lrck; 
    output audio_sck; 
    output audio_sdin; 
    output [6:0] DISPLAY; 
    output [3:0] DIGIT; 

    reg [3:0] BCD0, BCD0_next, BCD1, BCD1_next;
    reg [3:0] DIGIT_now;
    reg [6:0] DISPLAY_now;
    reg [6:0] value;

    wire seven_clk;
    clock_divider #(.n(10)) clock_10(.clk(clk), .clk_div(seven_clk));

    wire clkDiv13;
    clock_divider #(.n(13)) clock_13(.clk(clk), .clk_div(clkDiv13));

    // clkDiv22
    wire clkDiv22;
    clock_divider #(.n(22)) clock_22(.clk(clk), .clk_div(clkDiv22));    // for keyboard and audio

    wire _volUP_temp, _VOLUP;
    debounce btnu_d(.pb_debounced(_volUP_temp), .pb(_volUP), .clk(clkDiv13));
    onepulse btnu_1p(.signal(_volUP_temp), .clk(clkDiv13), .op(_VOLUP));

    wire _volDOWN_temp, _VOLDOWN;
    debounce btnd_d(.pb_debounced(_volDOWN_temp), .pb(_volDOWN), .clk(clkDiv13));
    onepulse btnd_1p(.signal(_volDOWN_temp), .clk(clkDiv13), .op(_VOLDOWN));

    wire _higherOCT_temp, _HIGHEROCT;
    debounce btnr_d(.pb_debounced(_higherOCT_temp), .pb(_higherOCT), .clk(clkDiv13));
    onepulse btnr_1p(.signal(_higherOCT_temp), .clk(clkDiv13), .op(_HIGHEROCT));

    wire _lowerOCT_temp, _LOWEROCT;
    debounce btnl_d(.pb_debounced(_lowerOCT_temp), .pb(_lowerOCT), .clk(clkDiv13));
    onepulse btnl_1p(.signal(_lowerOCT_temp), .clk(clkDiv13), .op(_LOWEROCT));

    parameter [8:0] KEY_CODES [0:6] = {
		9'b0_0001_1100,	// a => 1C
		9'b0_0001_1011,	// s => 1B
		9'b0_0010_0011,	// d => 23
		9'b0_0010_1011,	// f => 2B
		9'b0_0011_0100,	// g => 34
		9'b0_0011_0011,	// h => 33
		9'b0_0011_1011	// j => 3B
	};

    

    

    //volume control
    reg [2:0] vol, vol_next;
    always @(posedge clkDiv13 or posedge rst) begin
        if(rst) begin
            vol <= 3;
        end
        else begin
            vol <= vol_next;
        end
    end
    always @* begin
        if(_VOLUP) begin
            vol_next = (vol==5) ? 5 : vol+1;
        end
        else if(_VOLDOWN) begin
            vol_next = (vol==1) ? 1 : vol-1;
        end
        else begin
            vol_next = vol;
        end
    end

    //octave control
    reg [3:0] oct, oct_next;
    always @(posedge clkDiv13 or posedge rst) begin
        if(rst) begin
            oct <= 2;
        end
        else begin
            oct <= oct_next;
        end
    end
    always @* begin
        if(_LOWEROCT) begin
            oct_next = (oct==1) ? 1 : oct-1;
        end
        else if(_HIGHEROCT) begin
            oct_next = (oct==3) ? 3 : oct+1;
        end
        else begin
            oct_next = oct;
        end
    end

    //BCD0, BCD1
    always @(posedge clkDiv13 or posedge rst) begin
        if(rst) begin
            BCD0 <= 4'd8;
            BCD1 <= 4'd8;
        end
        else begin
            BCD0 <= BCD0_next;
            BCD1 <= BCD1_next;
        end
    end
    always @* begin
        if(!_mode) begin
            BCD1_next = 4'd8;

            if(PLAY_NOTE == 1) begin
                BCD0_next = 4'd2;
            end
            else if(PLAY_NOTE == 2) begin
                BCD0_next = 4'd3;
            end
            else if(PLAY_NOTE == 3) begin
                BCD0_next = 4'd4;
            end
            else if(PLAY_NOTE == 4) begin
                BCD0_next = 4'd5;
            end
            else if(PLAY_NOTE == 5) begin
                BCD0_next = 4'd6;
            end
            else if(PLAY_NOTE == 6) begin
                BCD0_next = 4'd0;
            end
            else if(PLAY_NOTE == 7) begin
                BCD0_next = 4'd1;
            end
            else begin
                BCD0_next = 4'd8;
            end
        end
        else begin
            BCD1_next = 4'd8;

            if(freqR == `hg) begin
                BCD0_next = 4'd6;
            end
            else if(freqR == `he) begin
                BCD0_next = 4'd4;
            end
            else if(freqR == `hf) begin
                BCD0_next = 4'd5;
            end
            else if(freqR == `hd) begin
                BCD0_next = 4'd3;
            end
            else if(freqR == `hc) begin
                BCD0_next = 4'd2;
            end
            else if(freqR == `do) begin
                BCD0_next = 4'd2;
            end
            else if(freqR == `re) begin
                BCD0_next = 4'd3;
            end
            else if(freqR == `mi) begin
                BCD0_next = 4'd4;
            end
            else if(freqR == `fa) begin
                BCD0_next = 4'd5;
            end
            else if(freqR == `so) begin
                BCD0_next = 4'd6;
            end
            else begin
                BCD0_next = 4'd8;
            end
        end
    end

    //LED
    reg [15:0] LED, LED_next;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            LED[15:13] <= 3'b010;
            LED[4:0] <= 5'b00111;
        end
        else begin
            LED[15:13] <= LED_next[15:13];
            LED[4:0] <= LED_next[4:0];
        end
    end
    always @* begin
        if(oct==1) begin
            LED_next[15:13] = 3'b001;
        end
        else if(oct==2) begin
            LED_next[15:13] = 3'b010;
        end
        else if(oct==3) begin
            LED_next[15:13] = 3'b100;
        end
        else begin
            LED_next[15:13] = LED[15:13];
        end

        if(vol==1) begin
            LED_next[4:0] = 5'b00001;
        end
        else if(vol==2) begin
            LED_next[4:0] = 5'b00011;
        end
        else if(vol==3) begin
            LED_next[4:0] = 5'b00111;
        end
        else if(vol==4) begin
            LED_next[4:0] = 5'b01111;
        end
        else if(vol==5) begin
            LED_next[4:0] = 5'b11111;
        end
        else begin
            LED_next[4:0] = LED[4:0];
        end
    end
    
    // Modify these
    assign _led[12:5] = 8'b00000000;
    assign _led[15:13] = LED[15:13];
    assign _led[4:0] = _mute ? 5'b00000 : LED[4:0];
    assign DIGIT = DIGIT_now;
    assign DISPLAY = DISPLAY_now;

    // Internal Signal
    wire [15:0] audio_in_left, audio_in_right;

    wire [11:0] ibeatNum;               // Beat counter
    wire [31:0] freqL_DEMO, freqR_DEMO;           // Raw frequency, produced by music module
    wire [21:0] freq_outL, freq_outR;    // Processed frequency, adapted to the clock rate of Basys3

    // Player Control
    // [in]  reset, clock, _play, _slow, _music, and _mode
    // [out] beat number
    player_control #(.LEN(511)) playerCtrl_00 ( 
        .clk(clkDiv22),
        .reset(rst),
        ._play(_play),
        ._slow(_slow), 
        ._mode(_mode),
        ._music(_music),
        .ibeat(ibeatNum)
    );

    // Music module
    // [in]  beat number and en
    // [out] left & right raw frequency
    music_example music_00 (
        .ibeatNum(ibeatNum),
        .en(_play),
        .toneL(freqL_DEMO),
        .toneR(freqR_DEMO)
    );

    wire [31:0] freqL_DEMO2, freqR_DEMO2;
    music_2 music_02 (
        .ibeatNum(ibeatNum),
        .en(_play),
        .toneL(freqL_DEMO2),
        .toneR(freqR_DEMO2)
    );

    reg [3:0] key_num;
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;

    KeyboardDecoder k_d(
        .rst(rst),
        .clk(clk),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid)
    );

    
    reg [3:0] PLAY_NOTE;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            PLAY_NOTE <= 0;
        end
        else begin
            if(!_mode) begin
                if(key_down[last_change]==1'b1) begin
                    if(key_num == 4'b0000) begin
                        PLAY_NOTE <= 1;
                    end
                    else if(key_num == 4'b0001) begin
                        PLAY_NOTE <= 2;
                    end
                    else if(key_num == 4'b0010) begin
                        PLAY_NOTE <= 3;
                    end
                    else if(key_num == 4'b0011) begin
                        PLAY_NOTE <= 4;
                    end
                    else if(key_num == 4'b0100) begin
                        PLAY_NOTE <= 5;
                    end
                    else if(key_num == 4'b0101) begin
                        PLAY_NOTE <= 6;
                    end
                    else if(key_num == 4'b0110) begin
                        PLAY_NOTE <= 7;
                    end
                    else begin
                        PLAY_NOTE <= 0;
                    end
                end
                else begin
                    PLAY_NOTE <= 0;
                end
            end
            else begin
                PLAY_NOTE <= 0;
            end
        end
    end

    reg [31:0] freqL_play, freqR_play;
    always @(posedge clkDiv13 or posedge rst) begin
        if(rst) begin
            freqL_play <= `silence;
            freqR_play <= `silence;
        end
        else begin
            case(PLAY_NOTE)
                0: begin
                    freqL_play <= `silence;
                    freqR_play <= `silence;
                end
                1: begin
                    freqL_play <= `A;
                    freqR_play <= `A;
                end
                2: begin
                    freqL_play <= `S;
                    freqR_play <= `S;
                end
                3: begin
                    freqL_play <= `D;
                    freqR_play <= `D;
                end
                4: begin
                    freqL_play <= `F;
                    freqR_play <= `F;
                end
                5: begin
                    freqL_play <= `G;
                    freqR_play <= `G;
                end
                6: begin
                    freqL_play <= `H;
                    freqR_play <= `H;
                end
                7: begin
                    freqL_play <= `J;
                    freqR_play <= `J;
                end
                default: begin
                    freqL_play <= `silence;
                    freqR_play <= `silence;
                end
            endcase
        end
    end

    wire [31:0] freqL, freqR;
    assign freqL = (_mode) ? ((_music) ? freqL_DEMO : freqL_DEMO2) : freqL_play;
    assign freqR = (_mode) ? ((_music) ? freqR_DEMO : freqR_DEMO2) : freqR_play;

    // freq_outL, freq_outR
    // Note gen makes no sound, if freq_out = 50000000 / `silence = 1
    assign freq_outL = (oct==2)? 50000000 / freqL : (oct==1) ? 25000000 / freqL : 100000000 / freqL;
    assign freq_outR = (oct==2)? 50000000 / freqR : (oct==1) ? 25000000 / freqR : 100000000 / freqR;

    wire [2:0] VOL;
    assign VOL = _mute ? 0 : vol;

    // Note generation
    // [in]  processed frequency
    // [out] audio wave signal (using square wave here)
    note_gen noteGen_00(
        .clk(clk), 
        .rst(rst), 
        .vol(VOL),
        .note_div_left(freq_outL), 
        .note_div_right(freq_outR), 
        .audio_left(audio_in_left),     // left sound audio
        .audio_right(audio_in_right)    // right sound audio
    );

    // Speaker controller
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


    always @(posedge seven_clk) begin
        case (DIGIT)
            4'b1110: begin
                value = BCD1;
                DIGIT_now = 4'b1101;
            end
            4'b1101: begin
                value = 4'd8;
                DIGIT_now = 4'b1011;
            end
            4'b1011: begin
                value = 4'd8;
                DIGIT_now = 4'b0111;
            end
            4'b0111: begin
                value = BCD0;
                DIGIT_now = 4'b1110;
            end
            default: begin
                value = 4'd2;
                DIGIT_now = 4'b1110;
            end
        endcase
    end

    always @* begin
        case (value)
            4'd0: DISPLAY_now = 7'b010_0000; //A La
            4'd1: DISPLAY_now = 7'b000_0011; //B Si
            4'd2: DISPLAY_now = 7'b010_0111; //C Do
            4'd3: DISPLAY_now = 7'b010_0001; //D Re
            4'd4: DISPLAY_now = 7'b000_0110; //E Mi
            4'd5: DISPLAY_now = 7'b000_1110; //F Fa
            4'd6: DISPLAY_now = 7'b100_0010; //G So
            4'd7: DISPLAY_now = 7'b001_1100; //o
            4'd8: DISPLAY_now = 7'b011_1111; //-
        endcase
    end

    always @ * begin
		case (last_change)
			KEY_CODES[00] : key_num = 4'b0000; //a
			KEY_CODES[01] : key_num = 4'b0001; //s
			KEY_CODES[02] : key_num = 4'b0010; //d
			KEY_CODES[03] : key_num = 4'b0011; //f
			KEY_CODES[04] : key_num = 4'b0100; //g
			KEY_CODES[05] : key_num = 4'b0101; //h
			KEY_CODES[06] : key_num = 4'b0110; //j
			default		  : key_num = 4'b1111;
		endcase
	end


endmodule
