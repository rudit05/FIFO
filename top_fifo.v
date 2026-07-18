module top_fifo (
    input clk, rst,
    input [7:0] data_in_top,
    output [7:0] data_out_top
);
    wire [7:0] data_out_temp; 
    wire [7:0] data_out_fifo; 
    wire wr_en, rd_en;
    wire full, empty;

    mod_a mod1 (
        .data_in(data_in_top), .clk(clk), .rst(rst), .full(full),
        .data_out(data_out_temp), .wr_en(wr_en)
    );

    fifo_8_8 fifo_inst (
        .clk(clk), .rst(rst),
        .wr_en(wr_en), .rd_en(rd_en),
        .data_in(data_out_temp), .data_out(data_out_fifo),
        .full(full), .empty(empty)
    );

    mod_b mod2 (
        .clk(clk), .rst(rst), .empty(empty),
        .data_in(data_out_fifo), .data_out(data_out_top),
        .rd_en(rd_en)
    );
endmodule
