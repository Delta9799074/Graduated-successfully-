`timescale 1ns/1ps
module send_top(
    input           clk,
    //input           clk_400m,
    input           rst,
    input [31:0]    send_f,
    input           trans_ack,
    output          txd,
    output          done
);
//wire txd;
reg [31:0] send_data;

always @(posedge clk)begin
    if(~rst)begin
        send_data <= 0;
    end
    else begin
        send_data <= send_f;
    end
end

wire clk_9600;
clk_div div0(
    .clk(clk),
    .clk_out(clk_9600)
);

send send0(
    .data_o(send_data),
    .send_clk(clk_9600),
    .rst(rst),
    .trans_ack(trans_ack),
    .txd(txd),
    .done(done)
);
endmodule