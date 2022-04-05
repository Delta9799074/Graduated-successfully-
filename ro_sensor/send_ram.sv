`timescale 1ns/1ps
module send_ram(
    input  logic  clk_origin,
    input  logic  rst,
    input  logic  single_inst_valid,
    input  logic  add_inst_ended,
    output logic  txd
);
    logic clk_400m, read_ram_clk;
    logic [31:0] clk_cnt;
    logic ro_f, single_value_end;

//generate all clk
//use pll
//use clock divider
    clk_div #(240) clk_send32(
        .clk(clk_origin),
        .clk_out(read_ram_clk)
    );

//use RING OSCILLATOR
/*    logic ro_enable;
    always_ff @(posedge clk_origin) begin
        if(~rst)begin
            ro_enable <= 1'b0;
        end
        else begin
            ro_enable <= 1'b1;
        end
    end
*/
/*clk_div #(50000000) ro_sim(
        .clk(clk_origin),
        .clk_out(ro_f)
);*/
     RO ring_osc(
        //.enable(ro_enable),
        .CLK_O(ro_f)
    );

//generate read enable: when add inst ended (after:pipe_cnt = 11)



//use RO frequency counter
counter_top cnt0(
    .clk_origin(clk_origin),
    //.clk_400m(clk_400m),        /*//100m*/ //should be clk_400m
    .read_clk(read_ram_clk),        //240hz
    .rst(rst),
    .ro_freq(ro_f),
    .inst_valid(single_inst_valid),   
    .read_enable(add_inst_ended),
    .read_data(clk_cnt)
);


//
    logic [2:0] read_cnt;
    always @(posedge read_ram_clk or negedge rst) begin
        if(!rst)begin
          read_cnt <= 0;
        end
        else if(read_cnt == 3'd2)begin
            read_cnt <= read_cnt;
        end
        else if(add_inst_ended)begin
            read_cnt <= read_cnt + 1;
        end    
    end


    logic  trans_enable;
    assign trans_enable = (read_cnt == 3'd2) & add_inst_ended;




//use uart 32
    send_top send_ro(
        .clk(clk_origin),
        .rst(rst),
        .send_f(clk_cnt),
        .trans_ack(trans_enable),
        .txd(txd),
        .done(single_value_end)
    );



    
endmodule