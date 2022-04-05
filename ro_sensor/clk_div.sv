`timescale 1ns/1ps
module clk_div #(
    parameter CPU_F = 800
)(
    input  logic clk,
    output logic clk_out
);
    localparam div_num = 100000000 / CPU_F;
    logic [31:0] num = 0;

    always_ff @(posedge clk) begin
        if(num == div_num)begin
            num     <= 0;
            clk_out <= 1;
        end
        else begin
            num     <= num + 1;
            clk_out <= 0;
        end
    end
endmodule