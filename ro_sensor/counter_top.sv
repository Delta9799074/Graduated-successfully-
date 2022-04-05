`timescale 1ns/1ps
module counter_top(
    input      logic          clk_origin,   
    input      logic          read_clk,  
    input      logic          rst,
    input      logic          ro_freq,
    /*(*MARK_DEBUG = "TRUE"*)*/input      logic          inst_valid,   
    /*(*MARK_DEBUG = "TRUE"*)*/input      logic          read_enable,
    output     logic  [31:0]  read_data
);

//write RAM logic
//�???????? rst valid, wirte 0;
//�???????? data valid,write data

//generate sim writing data
    //logic [31:0] wsim_value;
    /* always_ff @(posedge clk_origin or negedge rst) begin
        wsim_value <= (~rst) ? 32'd0 : sim_value;
    end */

    
    /* always_ff @(posedge valid or negedge rst) begin
        if(~rst)begin
            sim_value <= 0;
        end
        else begin
            sim_value = sim_value + 1;
        end
    end */

/* 
    logic [31:0] sim_value;
    always_ff @(posedge clk_origin or negedge rst) begin
        if(~rst)begin
            sim_value <= 0;
        end
        else if(valid)begin
            sim_value <= sim_value + 1;
        end
        else begin
            sim_value <= sim_value;
        end   
    end */


    (*mark_debug = "true"*) logic write_enable;
    always_ff @(posedge clk_origin /*or negedge rst*/) begin
        write_enable <= (~rst) ? 1'b1 : (valid & /*(~overflow_reg)*/ & inst_valid);
    end
    
    (*mark_debug = "true"*) logic [31:0] wram_value;
    /* always_ff @(posedge clk_origin or negedge rst) begin
        wram_value <= (~rst) ? 32'd0 : cnt_value;
    end */

    logic [12:0] wrst_addr = 11'd0;
    logic [12:0] wnor_addr;
    always_ff @(posedge clk_origin or negedge rst) begin   //question: when rst is valid, is there clk_origin?
        if(~rst)begin
            wrst_addr <= wrst_addr + 1;
        end
    end

    always_ff @(posedge valid /*or negedge rst*/) begin
        if(~rst)begin
            wnor_addr <= 0;
        end
        else if(wnor_addr == 13'd08191)begin
            wnor_addr <= wnor_addr;
        end
        else if(inst_valid)begin
            wnor_addr <= wnor_addr + 1;
        end
        else begin
            wnor_addr <= wnor_addr;
        end
    end

(*mark_debug = "true"*) logic [31:0] data_counter;

always_ff @( posedge write_enable or negedge rst) begin : VALID_DATA_COUNTING
    if(~rst)begin
        data_counter <= 0;
    end
    else begin
        data_counter <= data_counter + 1;
    end
end


    /*always_ff @(posedge clk_origin or negedge rst) begin
        if(~rst)begin
            wnor_addr <= 0;
        end
        else if(valid)begin
            wnor_addr <= wnor_addr + 1;
        end
        else begin
            wnor_addr <= wnor_addr;
        end   
    end
*/

(*mark_debug = "true"*)logic [12:0] wr_addr;
    /* always_ff @(posedge clk_origin or negedge rst) begin
        wr_addr <= (~rst) ? wrst_addr : wnor_addr;
    end */

    //combinational logic
    always_comb begin
        //write_enable  = (~rst) ? 1'b1 : (valid & (~overflow_reg) & (~inst_end));
    //    wr_addr       = (~rst) ? wrst_addr : wnor_addr;
        wr_addr       = (~rst) ? wrst_addr : data_counter;
        //wram_value    = (~rst) ? 32'd0 : sim_value;
        wram_value    = (~rst) ? 32'd0 : cnt_samp;
        //wram_value    = (~rst) ? 32'd0 : cnt_value;
    end

    logic [31:0] cnt_samp;
    always_ff @(posedge valid /*or negedge rst*/) begin
        if(~rst)begin
            cnt_samp <= 0;
        end
        else if(valid)begin
            cnt_samp <= cnt_value;
        end
        else begin
            cnt_samp <= cnt_samp;
        end   
    end 


    //avoid writing overflow
    logic overflow;
    /*(*MARK_DEBUG = "TRUE"*)*/logic overflow_reg;
    assign overflow = (wnor_addr == 13'd8192);
    always_ff @(posedge overflow or negedge rst) begin
        if(~rst)begin
            overflow_reg <= 1'b0;
        end
        else begin
            overflow_reg <= 1'b1;
        end
    end

//read RAM logic
//when 1 inst finished, begin read RAM
    logic [12:0] rd_addr;
    always_ff @(posedge read_clk or negedge rst) begin
        if(~rst)begin
            rd_addr <= 0;
        end
        else if (read_enable) begin
            rd_addr <= rd_addr + 1;
        end
        else begin
            rd_addr <= rd_addr;
        end
    end

//use RO frequency counter

//Generate counter clock

logic clk_400m;
    clk_400 clk_pll0(
        .clk_in1(clk_origin),
        .clk_out1(clk_400m)
    );

    logic [31:0] cnt_value;
    logic valid;

    ro_counter rocnt0(
        .ro_freq(ro_freq),
        .rst(rst),
        .clk_400m(clk_400m),
        .clk_400m_cnt(cnt_value),
        .valid(valid)
    );



//use RAM 2048
    cnt_ram ram2048 (
        //write
          .clka(clk_origin),
        //  .clka(clk_400m),        // input wire clk_origina
          .wea(write_enable),       // input wire [0 : 0] wea
          .addra(wr_addr),          // input wire [10 : 0] addra
          .dina(wram_value),        // input wire [31 : 0] dina

        //read
          .clkb(read_clk),          // input wire clk_originb
          .enb(read_enable),        // input wire enb
          .addrb(rd_addr),          // input wire [10 : 0] addrb
          .doutb(read_data)         // output wire [31 : 0] doutb
    );

endmodule