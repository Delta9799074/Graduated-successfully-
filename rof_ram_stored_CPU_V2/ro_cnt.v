`timescale 1ns/1ps
module ro_counter(
    input           ro_freq,
    input           rst,
    input           clk,
    output  [31:0]  clk_cnt,
    output          valid
);
    parameter PERIOD = 32'd2048;
    
    reg [31:0] ro_cnt;
    wire rising_edge;
    reg [31:0] t_cnt;
    reg [31:0] clock_cnt;
    //count the clk_period num of 2047 ro period

    // Try to avoid metastability by running the input signal through
    // a D flip flop.
    reg freq_0,freq_1, freq_2;
    /*always @(posedge clk)begin
        if (!rst) freq_0 <= 0;
        else freq_0 <= ro_freq;
    end*/
    always @(posedge clk)begin
        if (!rst) freq_1 <= 0;
        else freq_1 <= ro_freq;
    end
   
    // This is the rising edge detection
    always @(posedge clk)begin
        if (!rst) freq_2 <= 0;
        else freq_2 <= freq_1;
    end
    assign rising_edge = freq_1 && ~freq_2;
    /*
    // This is period counter
    //count 1 period
    always @(posedge clk)begin
        if (~rst || rising_edge) begin
            t_cnt  <= ro_cnt;
            valid  <= 1'b1;
            ro_cnt <= 0;
        end
        else begin
            valid <= 1'b0;
            ro_cnt <= ro_cnt + 1;
        end
    end
    */
    
    //this is count 2047 periods
    //
    /*always @(posedge clk or negedge rst)begin
        if (~rst) begin
            //t_cnt  <= 0;
            valid  <= 1'b0;
            ro_cnt <= 0;
        end
        else if(rising_edge)begin
            if(ro_cnt == PERIOD)begin //osc 2047 periods
                valid       <= 1'b1;
                //t_cnt       <= clock_cnt;
                ro_cnt      <= 0;
            end
            else begin
                valid <= 1'b0;
                ro_cnt <= ro_cnt + 1;
                //t_cnt <= t_cnt;
            end
        end
    end*/
    
    always @(posedge rising_edge or negedge rst)begin   //��⵽�����ؾͼ���??
        if (~rst) begin
            ro_cnt <= 0;
        end
        else if(ro_cnt == PERIOD)begin //osc 2047 periods
            ro_cnt      <= 0;
        end
        else begin
            ro_cnt <= ro_cnt + 1;
        end
    end
    
    //count clock
    always @(posedge clk or negedge rst)begin
        if (~rst || (ro_cnt == PERIOD)) begin
            clock_cnt   <= 0;
        end
        else begin
            clock_cnt   <= clock_cnt + 1;
        end
    end
    
    /* 2/20
    reg cnt_stop;
    always @(posedge clk or negedge rst)begin           //count clk period
        if (~rst) begin
            clock_cnt   <= 0;
        end
        else if (cnt_stop) begin
            clock_cnt   <= clock_cnt;
        end
        else begin
            clock_cnt   <= clock_cnt + 1;
        end
    end
    */
    
    wire fresh;
    assign fresh = ro_cnt == PERIOD;
/*    always@(posedge clk or negedge rst)begin
        if(~rst)begin
            valid <= 1'b0;
        end
        else if (fresh) begin
            valid <= 1'b1;
        end
        else begin
            valid <= 1'b0;
        end
    end
*/
//modify 2022/2/28 21:26
//like rising_edge
   reg fresh_1, fresh_2;
    always @(posedge clk)begin
        if (!rst) fresh_1 <= 0;
        else fresh_1 <= fresh;
    end
   
    // This is the rising edge detection
    always @(posedge clk)begin
        if (!rst) fresh_2 <= 0;
        else fresh_2 <= fresh_1;
    end
    assign valid = fresh_1 && ~fresh_2;



    /* 2/20
    always@(posedge fresh or negedge rst)begin
        if(~rst)begin
            cnt_stop <= 0;
        end
        else begin
            cnt_stop <= 1;
        end
    end
    */
    
    always@(posedge fresh or negedge rst)begin
        if(~rst)begin
            t_cnt <= 0;
        end
        else begin
            t_cnt <= clock_cnt;
        end
    end
    
    //always@(posedge fresh or negedge rst)begin
        /*if(~rst)begin 
            t_cnt <= 0;
        end*/
        /*else if(ro_cnt == PERIOD)begin*/
            //t_cnt <= clock_cnt;
        //end
    //end
    
    assign clk_cnt = t_cnt;
    //assign clk_cnt = clock_cnt;
    
    
    /*always @(posedge ro_freq or negedge rst) begin
        if(!rst)begin
            ro_cnt <= 0;
        end
        else if(ro_cnt == PERIOD)begin
            ro_cnt <= ro_cnt;
        end
        else begin
            ro_cnt <= ro_cnt + 1;
        end
    end*/
    //assign ro_cnt_finish = (ro_cnt == PERIOD);
endmodule