`timescale 1ns / 1ps

module FIFO_tb(

    );
    reg clk, rst;
    reg [7:0] data_in;
    wire [7:0] data_out;
        
    top_fifo dut(clk, rst, data_in, data_out);
        
    always #5 clk = ~clk;
    
    initial 
        begin
            clk = 0; rst = 1; data_in = 0;
            #10 rst = 0; data_in = 5;
            #10 data_in = 10;
            #10 data_in = 50;
            #10 data_in = 5;
            #10 data_in = 10;
            #10 data_in = 50;
            #10 data_in = 5;
            #10 data_in = 10;
            #10 data_in = 50;
            #10 data_in = 5;
            #10 data_in = 10;
            #10 data_in = 50;
            #200
            $finish;
        end
        
endmodule
