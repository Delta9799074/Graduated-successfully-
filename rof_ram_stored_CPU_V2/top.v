`timescale 1ns/1ps
module cnt_n_store_top(
    input               clk,
    input               rst,
   /*(*Mark_debug = "TRUE"*)*/ input               ro_freq,

   //read ram to uart

    input                inst_end,   

    input                read_enable,
    input                read_clk,
    output      [31:0]   read_data
    //output reg [31:0]    frequency
);

//clk_in is 400MHz

//parameter FREQUENCY = 100000000;


// add store logic
//double logic 
//wire write_enable;
reg write_enable;
always@(posedge clk or negedge rst)begin
    write_enable <= (~rst) ? 1'b1 : (valid & (~add_ov_reg) & (~inst_end));
end
//assign write_enable = (~rst) ? 1'b1 : (valid & (~add_ov_reg) & (~inst_end));
/*
reg [31:0] data_sim;
always@(posedge valid or negedge rst)begin
    if(~rst)begin
        data_sim <= 0;
    end
    else begin
        data_sim <= data_sim + 32'hef;
    end
end
*/
//double logic 
//wire [31:0] wram_value;
reg [31:0] wram_value;
always@(posedge clk or negedge rst)begin
    wram_value <= (~rst) ? 32'd0 : cnt_value;
end
//assign wram_value = (~rst) ? 32'd0 : cnt_value;

cnt_ram ram2048 (
//write
  .clka(clk),    // input wire clka
  .wea(write_enable),      // input wire [0 : 0] wea
  .addra(wr_addr),  // input wire [10 : 0] addra
  //.dina(wr_cnt),
  //.dina(data_sim),
  .dina(wram_value),    // input wire [31 : 0] dina

//read
  .clkb(read_clk),    // input wire clkb
  .enb(read_enable),      // input wire enb
  .addrb(rd_addr),  // input wire [10 : 0] addrb
  .doutb(read_data)  // output wire [31 : 0] doutb
);


//wire [31:0] wr_addr;
reg [31:0] wr_addr;
//assign wr_addr = (~rst) ? wrst_addr : wnor_addr;
always@(posedge clk or negedge rst)begin
    wr_addr <= (~rst) ? wrst_addr : wnor_addr;
end
/*
//
reg [31:0] wr_cnt;
always@(posedge write_enable or negedge rst)begin
    if(!rst)begin
        wr_cnt <= 0;
     end
     else begin
        wr_cnt <= wr_cnt + 1;
     end
end

//
*/

/*reg [4:0] rd_addr;
reg [4:0] wr_addr;*/
reg [10:0] rd_addr;
reg [10:0] wrst_addr = 11'd0;
reg [10:0] wnor_addr;
wire add_overflow;
reg add_ov_reg;
//assign add_overflow = (wr_addr == 11'b11111_11111_1);
assign add_overflow = (wr_addr == 11'd2047);
always@(posedge add_overflow or negedge rst)begin
    if(~rst)begin
        add_ov_reg <= 0;
    end
    else begin
        add_ov_reg <= 1;
    end
end

//ram waddr gen
//reg [10:0] rd_addr;

always @(posedge read_clk or negedge rst) begin
    if(~rst)begin
        rd_addr <= 0;
    end
    else if(read_enable)begin
        rd_addr <= rd_addr + 1;
    end
    else begin
        rd_addr <= rd_addr;
    end
end

/*wire valid_rising;
reg valid1,valid2;
    //always @(posedge clk)begin
    //    if (!rst) freq_0 <= 0;
    //    else freq_0 <= ro_freq;
    //end
    always @(posedge clk)begin
        if (!rst) valid1 <= 0;
        else valid1 <= valid;
    end
   
    // This is the rising edge detection
    always @(posedge clk)begin
        if (!rst) valid2 <= 0;
        else valid2 <= valid1;
    end
    assign valid_rising = valid1 && ~valid2;
*/

/*
    reg [31:0] rst_cnt;
    always @(posedge clk or negedge rst) begin
    if(~rst)begin
        rst_cnt <= 0;
    end
    else begin
        rst_cnt <= rst_cnt + 1;
    end
*/



//ram raddr gen
//integer i;
always @(posedge valid or negedge rst) begin
    if(~rst)begin
        wnor_addr <= 0;
    end
    /*else if(valid_rising)begin
        if((valid_cnt == 32'd1))begin
            wr_addr <= 0;
        end*/
        else begin
            wnor_addr <= wnor_addr + 1;
        end   
    //end
end

/*
//detect rst negedge
WARNING:AMBIGUOUS CLOCK
wire rst_neg;
reg rst1,rst2;      //rst2 is earlier state
    //always @(posedge clk)begin
    //    if (!rst) freq_0 <= 0;
    //    else freq_0 <= ro_freq;
    //end
    always @(posedge clk)begin
        if (!rst) rst1 <= 0;
        else rst1 <= rst;
    end
   
    // This is the rising edge detection
    always @(posedge clk)begin
        if (!rst) rst2 <= 0;
        else rst2 <= rst1;
    end
    assign rst_neg = ~rst1 && rst2;

*/

always @(posedge clk or negedge rst) begin
    if(~rst)begin //negedge rst 
    //    wrst_addr <= 0;
    //end
    //else begin
        wrst_addr <= wrst_addr + 1;
    end   
//end
end



wire [31:0] cnt_value;
wire valid;
    ro_counter rocnt0(
        .ro_freq(ro_freq),
        .rst(rst),
        .clk(clk),
        .clk_cnt(cnt_value),
        .valid(valid)
    );

/*wire [31:0] cnt_value;
    cnt cnt0(
        .clk(clk_400m),
        .rst(rst),
        .cnt_value(cnt_value)
    );*/

/*always@(posedge clk)begin
    if(!rst)begin
        frequency  <= 0;
    end
    else if (cnt_stop) begin
        frequency   <= cnt_value;
    end
    else begin
        frequency   <= frequency;
    end
end*/

/*always @(posedge clk) begin
    if(!rst)begin
        frequency <= 32'd0;
    end
    //else if(valid)begin
        //frequency <= cnt_value;
    //end
    else begin 
        frequency <= cnt_value;
    end
end
*/
endmodule