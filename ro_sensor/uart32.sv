`timescale 1ns/1ps
module uart32(
    input  logic [31:0] data_in,
    input  logic        send_clk,   //9600hz
    input  logic        rst,
    input  logic        trans_ack,
    output logic        txd,
    output logic        done
);
    localparam NUMBER = 37;
    localparam IDLE = 0;
    localparam START = 1;
    localparam SENDING = 2;
    localparam END = 3;

    logic [3:0] cur_state, nxt_state;
    logic [6:0] count;
    //sampling input data
    logic [31:0] send_data_sample;

//state transfer 
//sequence logic
    always_ff @(posedge send_clk) begin
        if(~rst)begin
            cur_state <= IDLE;
        end
        else begin
            cur_state <= nxt_state;
        end
    end

//next state logic
//combinational logic

    always_comb begin
        nxt_state = cur_state;  //question
        case(cur_state)
            IDLE    : if(trans_ack)begin nxt_state = START;end
            START   : nxt_state = SENDING;
            SENDING : if(count == NUMBER)begin nxt_state = END;end
            END     : if(trans_ack)begin nxt_state = START;end
            default : nxt_state = IDLE;
        endcase
    end

//sampling input data
    always_ff @(posedge send_clk) begin
        if (cur_state == START) begin
            send_data_sample <= data_in;
        end
    end

//sending data bit counter
    always_ff @(posedge send_clk) begin
        if(cur_state == SENDING)begin
            count <= count + 1;
        end
        else if (cur_state == IDLE | cur_state == END) begin
            count <= 0;
        end
    end

//sending bit
    always_ff @(posedge send_clk) begin
        if(cur_state == START)begin
            txd <= 0;
        end
        else if (cur_state == SENDING) begin
            case(count)
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
				
				9:  txd <= 1'b0; 	    //start
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
				default: txd <= 1'b1;
            endcase
        end
        else if (cur_state == END) begin
            txd <= 1;
        end
        else begin
            txd <= 1;
        end
    end

    always_ff @(posedge send_clk) begin
        if (nxt_state == END) begin
            done <= 1;
        end
        else begin
            done <= 0;
        end
    end
endmodule