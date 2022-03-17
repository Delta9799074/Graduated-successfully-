module test_top(
    input clk,
    input rst,
    input single_inst_end,
    output txd
);

    wire clk_400m;
    clk_400 clk_pll0(
        .clk_in1(clk),
        .clk_out1(clk_400m)
    );

    wire [31:0] clk_cnt;
    wire ro_f;
    wire single_value_end;
    send_top send_ro(
        .clk(clk),
        .rst(rst),
        //.clk_400m(clk_400m),
        //.send_f(32'HAABBCCDD),
        .send_f(clk_cnt),
        .trans_ack(trans_enable),
        .txd(txd),
        .done(single_value_end)
    );

    wire read_ram_clk;

    clk_div #(240) clk_send32(
        .clk(clk),
        .clk_out(read_ram_clk)
    );



    reg [2:0] read_cnt;
    always @(posedge read_ram_clk or negedge rst) begin
        if(!rst)begin
          read_cnt <= 0;
        end
        else if(read_cnt == 3'd2)begin
            read_cnt <= read_cnt;
        end
        else if(single_inst_end)begin
            read_cnt <= read_cnt + 1;
        end    
    end


    wire trans_enable;
    assign trans_enable = (read_cnt == 3'd2) & single_inst_end;


    cnt_n_store_top cnt0(
        .rst(rst),
        .clk(clk_400m),
        .ro_freq(ro_f),

        .inst_end(single_inst_end),

        .read_enable(single_inst_end/* & single_value_end*/),
        .read_clk(read_ram_clk),
        .read_data(clk_cnt)     
        //.frequency(clk_cnt)
    );
   
    reg ro_enable;
    always@(posedge clk_400m)begin
        if(~rst)begin
            ro_enable <= 1'b0;
        end
        else begin
            ro_enable <= 1'b1;
        end
    end

    RO ring_osc(
        .enable(ro_enable),
        .CLK_O(ro_f)
    );
    
    /*
    //simulate 50M ro_f
    clk_div #(50000000) ro_sim(
        .clk(clk),
        .clk_out(ro_f)
    );
*/
endmodule