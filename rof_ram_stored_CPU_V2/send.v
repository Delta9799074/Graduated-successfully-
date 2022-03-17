`define NUMBER 37
`timescale 1ns/1ps
module send(
    input [31:0] data_o,
    input        send_clk,
    input        rst,
    input        trans_ack,
    output reg   txd,
    output reg   done
);

    localparam IDLE = 0;
    localparam START = 1;
    localparam SENDING = 2;
    localparam END = 3;

    reg [3:0] cur_st,nxt_st;
    reg [6:0] count;

    //send temp data

    reg [31:0] send_data_sample;

    always @(posedge send_clk) begin
        if(rst == 0)begin
            cur_st <= IDLE;
        end
        else begin
            cur_st <= nxt_st;
        end
    end
    
    always @(*) begin
        nxt_st = cur_st;
        case(cur_st)
            IDLE    : if(trans_ack)begin nxt_st = START;end
            START   : nxt_st = SENDING;
            SENDING : if(count == `NUMBER)begin nxt_st = END;end
            //
            END     : if(trans_ack)begin nxt_st = START;end
            default : nxt_st = IDLE;
        endcase
    end

    always @(posedge send_clk) begin
        if(cur_st == START)begin
            send_data_sample <= data_o;
        end
    end



    always @(posedge send_clk) begin
        if(cur_st == SENDING)begin
            count <= count + 1;
        end
        else if (cur_st == IDLE | cur_st == END) begin
            count <= 0;
        end
    end

    /*always @(posedge send_clk) begin
        if(cur_st == START)begin
            data_o_tmp <= data_o;
        end
        else if (cur_st == SENDING) begin
            data_o_tmp[6:0] <= data_o_tmp[7:1];
            //data_o_tmp = data_o_tmp >> 1;
        end
    end*/

    always @(posedge send_clk) begin
        if(cur_st == START)begin
            txd <= 0;
        end
        else if (cur_st == SENDING) begin
            case(count)
                        /*
                        
                        //0 : txd <= 1'b0; 	        //start
						0 : txd <= data_o[0];	//data[7:0]
						1 : txd <= data_o[1];	
						2 : txd <= data_o[2];	
						3 : txd <= data_o[3];	
						4 : txd <= data_o[4];
						5 : txd <= data_o[5];
						6 : txd <= data_o[6];
						7 : txd <= data_o[7];	
						8 : txd <= 1'b1;	        //stop
						//9 : txd <= 1'b1;
						
						9: txd <= 1'b0; 	    //start
						10: txd <= data_o[8];	//data[23:16]
						11: txd <= data_o[9];	
						12: txd <= data_o[10];	
						13: txd <= data_o[11];	
						14: txd <= data_o[12];	
						15: txd <= data_o[13];	
						16: txd <= data_o[14];	
						17: txd <= data_o[15];	
						18: txd <= 1'b1;	        //stop
						
						19: txd <= 1'b0; 	    //start
						20: txd <= data_o[16];	//data[15:8]
						21: txd <= data_o[17];	
						22: txd <= data_o[18];	
						23: txd <= data_o[19];	
						24: txd <= data_o[20];
						25: txd <= data_o[21];
						26: txd <= data_o[22];
						27: txd <= data_o[23];	
						28: txd <= 1'b1;	        //stop
						
						29: txd <= 1'b0; 	    //start
						30: txd <= data_o[24];	//data[7:0]
						31: txd <= data_o[25];	
						32: txd <= data_o[26];	
						33: txd <= data_o[27];	
						34: txd <= data_o[28];
						35: txd <= data_o[29];
						36: txd <= data_o[30];
						37: txd <= data_o[31];	
						38: txd <= 1'b1;	        //stop
                        */
                        
                        0 : txd <= send_data_sample[24];	//data[31:24] AA
						1 : txd <= send_data_sample[25];	
						2 : txd <= send_data_sample[26];	
						3 : txd <= send_data_sample[27];	
						4 : txd <= send_data_sample[28];
						5 : txd <= send_data_sample[29];
						6 : txd <= send_data_sample[30];
						7 : txd <= send_data_sample[31];	
						8 : txd <= 1'b1;	        //stop
						//9 : txd <= 1'b1;
						
						9: txd <= 1'b0; 	    //start
						10: txd <= send_data_sample[16];	//data[23:16] BB
						11: txd <= send_data_sample[17];	
						12: txd <= send_data_sample[18];	
						13: txd <= send_data_sample[19];	
						14: txd <= send_data_sample[20];	
						15: txd <= send_data_sample[21];	
						16: txd <= send_data_sample[22];	
						17: txd <= send_data_sample[23];	
						18: txd <= 1'b1;	        //stop
						
						19: txd <= 1'b0; 	    //start
						20: txd <= send_data_sample[8];	//data[15:8] CC 
						21: txd <= send_data_sample[9];	
						22: txd <= send_data_sample[10];	
						23: txd <= send_data_sample[11];	
						24: txd <= send_data_sample[12];
						25: txd <= send_data_sample[13];
						26: txd <= send_data_sample[14];
						27: txd <= send_data_sample[15];	
						28: txd <= 1'b1;	        //stop
						
						29: txd <= 1'b0; 	    //start
						30: txd <= send_data_sample[0];	//data[7:0] DD
						31: txd <= send_data_sample[1];	
						32: txd <= send_data_sample[2];	
						33: txd <= send_data_sample[3];	
						34: txd <= send_data_sample[4];
						35: txd <= send_data_sample[5];
						36: txd <= send_data_sample[6];
						37: txd <= send_data_sample[7];	
					//	38: txd <= 1'b1;	       //stop

                    
					 	default: txd <= 1'b1;
            endcase
        end
        else if (cur_st == END) begin
            txd <= 1;
        end
        else begin
            txd <= 1;
        end
    end

    always @(posedge send_clk) begin
        if (nxt_st == END) begin
            done <= 1;
        end
        else begin
            done <= 0;
        end
    end
endmodule