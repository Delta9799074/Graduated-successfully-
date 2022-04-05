`timescale 1ns/1ps
module ro_counter(
    input   logic         ro_freq,
    input   logic         rst,
    input   logic         clk_400m,
    /*(*mark_debug = "true"*)*/output  logic [31:0]  clk_400m_cnt,
    (*mark_debug = "true"*)output  logic         valid
);
//RO counts period
localparam PERIOD = 32'd512;

//detect rising edge logic

    logic freq_1,freq_2;
    logic rising_edge;
    always_ff @(posedge clk_400m) begin
        if(~rst)begin
            freq_1 <= 0;
        end
        else begin
            freq_1 <= ro_freq;
        end
    end

    always_ff @(posedge clk_400m) begin
        if(~rst)begin
            freq_2 <= 0;
        end
        else begin
            freq_2 <= freq_1;
        end
    end

    assign rising_edge = freq_1 && ~freq_2;

// count ro periods
    logic [31:0] ro_cnt;
    always_ff @(posedge rising_edge or negedge rst) begin
        if (~rst) begin
            ro_cnt <= 0;
        end
        else if(ro_cnt == PERIOD)begin
            ro_cnt <= 0;
        end
        else begin
            ro_cnt <= ro_cnt + 1;
        end
    end

    
//count 400M clock
logic [31:0] clock_cnt;
always_ff @(posedge clk_400m or negedge rst) begin
    if (~rst || (ro_cnt == PERIOD)) begin
        clock_cnt <= 0;
    end
    else begin
        clock_cnt <= clock_cnt + 1;
    end
end

//generate valid signal 
//in order to write ram, write ram clock is 100M
    logic fresh;
    logic fresh_1, fresh_2;

    assign fresh = (ro_cnt == PERIOD);

    always_ff @(posedge clk_400m) begin
        if(~rst)begin
            fresh_1 <= 0;
        end
        else begin
            fresh_1 <= fresh;
        end
    end

    always_ff @(posedge clk_400m) begin
        if(~rst)begin
            fresh_2 <= 0;
        end
        else begin
            fresh_2 <= fresh_1;
        end
    end

   // assign valid = fresh_1 && ~fresh_2;
    assign valid = (ro_cnt == PERIOD);
//give valid value to RAM
//    logic [31:0] clk_400m_cnt;

    always_ff @(posedge fresh or negedge rst) begin
        if(~rst)begin
            clk_400m_cnt <= 0;
        end
        else begin
            clk_400m_cnt <= clock_cnt;
        end
    end
/*     always_ff @(posedge valid or negedge rst) begin
        if(~rst)begin
            clk_400m_cnt <= 0;
        end
        else begin
            clk_400m_cnt <= clock_cnt;
        end
    end */
endmodule