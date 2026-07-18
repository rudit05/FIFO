module fifo_8_8(
    input clk, rst, wr_en, rd_en,
    input [7:0] data_in, output reg [7:0] data_out,
    output full, empty
    );
    
    reg [2:0] wr_ptr=0, rd_ptr=0;
    reg [3:0] count=0; 
    
    reg [7:0] mem [0:7];
    wire [1:0] fifo_case;
    
    integer i;
    
    always @(posedge clk)
        begin
            if(rst) 
                begin  
                    for(i=0; i<=7; i=i+1)
                        mem[i] <= 0;
                    wr_ptr <= 0;
                    rd_ptr <= 0;
                    count <= 0;
                    data_out <= 0;
                end
            case ({wr_en && !full, rd_en && !empty})
                2'b10: begin
                     mem[wr_ptr] <= data_in;
                     wr_ptr <= wr_ptr + 1;
                     count <= count + 1;
                end
                2'b01: begin
                    data_out <= mem[rd_ptr];
                    rd_ptr <= rd_ptr + 1;
                    count <= count - 1;
                end
                2'b11: begin
                    mem[wr_ptr] <= data_in;
                    data_out <= mem[rd_ptr];
                    wr_ptr <= wr_ptr + 1;
                    rd_ptr <= rd_ptr + 1;
                end
                2'b00: begin
                end
            endcase
        end

        assign full =  (count == 4'd8); 
        assign empty = (count == 0);   
        assign fifo_case = {wr_en && !full, rd_en && !empty};        
endmodule
