`timescale 1ns/1ps
module sensor_top(
    input   logic clk_origin,       //must input 100M clk
    input   logic cpu_clk,          //input cpu_clk
    input   logic [31:0] inst_data,
    input   logic rst,
    output  logic txd
);

localparam INST = 32'h0110b020; //ADD


logic       inst_end;
(* MARK_DEBUG = "TRUE" *)logic [31:0] pipe_cnt;

always_ff @(posedge cpu_clk or negedge rst) begin
    if(~rst)begin
        pipe_cnt <= 0;
    end
    else if(inst_valid)begin
        pipe_cnt <= pipe_cnt + 1;
    end
    else begin
        pipe_cnt <= pipe_cnt;
    end
end

assign inst_valid = (inst_data == INST);
logic record_valid;
assign record_valid = (pipe_cnt > 0) & (pipe_cnt < 6); //valid add data

/*(* MARK_DEBUG = "TRUE" *)*/logic add_end;
assign add_end = (pipe_cnt == 6);
/*(* MARK_DEBUG = "TRUE" *)*/logic add_end_reg = 0;
always_ff @(posedge clk_origin/* or negedge rst*/) begin
    if(~rst)begin
        add_end_reg <= 0;
    end
    //else begin
    //    add_end_reg <= 1;
    //end
    else if(add_end)begin
        add_end_reg <= 1;
    end
end
/* reg sg_inst_valid_reg;
always @(posedge inst_valid or negedge rst) begin
    if(~rst)begin
        sg_inst_valid_reg <= 0;
    end
    else begin
        sg_inst_valid_reg <= 1;
    end
end
 */

send_ram test0(
    .clk_origin(clk_origin),
    .rst(rst),
    .single_inst_valid(record_valid & (~add_end_reg)),
    .add_inst_ended(add_end_reg),
    .txd(txd)
);

endmodule