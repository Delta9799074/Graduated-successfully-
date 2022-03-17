`define UNICNT 5
`define MULTCNT 10
`define DIVCNT 15
module sensor_top(
    input clk,      //must input 100M clk
    input cpu_clk,  //input cpu_clk
    input rst,
    output txd
);

wire inst_end;
reg [3:0] pipe_cnt;
/*
wire cpu_clk;
clk_div #(800) cpu_gen(
    .clk(clk),
    .clk_out(cpu_clk)
);
*/


always @(posedge cpu_clk or negedge rst) begin
    if(~rst|(pipe_cnt == 15))begin
        pipe_cnt <= 0;
    end
    else begin
        pipe_cnt <= pipe_cnt + 1;
    end
end

assign inst_end = (pipe_cnt == 15);


reg sg_inst_end_reg;
always @(posedge inst_end or negedge rst) begin
    if(~rst)begin
        sg_inst_end_reg <= 0;
    end
    else begin
        sg_inst_end_reg <= 1;
    end
end


test_top test0(
    .clk(clk),
    .rst(rst),
    .single_inst_end(sg_inst_end_reg), //�?旦一条指令流进流水线，这个信号就始终拉高
    .txd(txd)
);

endmodule