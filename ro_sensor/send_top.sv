`timescale 1ns/1ps
module send_top(
    input  logic           clk,
    input  logic           rst,
    input  logic [31:0]    send_f,
    input  logic           trans_ack,
    output logic           txd,
    output logic           done
);
//sampling send_frequency_data
    logic [31:0] send_data;

    always_ff @(posedge clk) begin
        if(~rst)begin
            send_data <= 0;
        end
        else begin
            send_data <= send_f;
        end
    end

//use uart32
    //baud_rate generate
    logic clk_9600;
    clk_div #(9600) div0(
        .clk(clk),
        .clk_out(clk_9600)
    );

    uart32 send0(
       // .data_in(32'hEEFFAABB),
        .data_in(send_data),
        .send_clk(clk_9600),
        .rst(rst),
        // .trans_ack(1'b1),
        .trans_ack(trans_ack),
        .txd(txd),
        .done(done)
    );

endmodule