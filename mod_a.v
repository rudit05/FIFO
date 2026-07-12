module mod_a (
    input [7:0] data_in,
    input clk, rst,
    output reg [7:0] data_out,
    output reg wr_en
);

    always @(posedge clk) begin
        if (rst) begin
            data_out <= 0;
            wr_en <= 0;
        end else begin
            data_out <= data_in;
            wr_en <= 1'b1; // Explicitly set to write every cycle [9]
        end
    end
endmodule
