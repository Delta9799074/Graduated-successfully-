`timescale 1ns/1ps
module clk_div #(
    parameter Baud_rate = 9600
)(
    input      clk,
    output reg clk_out
);
    localparam div_num = 100000000 / Baud_rate;
    reg [31:0] num;

    initial 
        num = 0;
    
    always @(posedge clk) begin
        if(num == div_num)begin
            num <= 0;
            clk_out = 1;
        end
        else begin
            num <= num + 1;
            clk_out <= 0;
        end
    end
endmodule