module fifo_8_8(
    input clk, rst, wr_en, rd_en,
    input [7:0] data_in, output reg [7:0] data_out,
    output full, empty
    );
    
    reg [2:0] wr_ptr=0, rd_ptr=0; // signals to represent our 8 locations
    
    reg [7:0] mem [0:7]; // 8 register (0(MSB) -> 7(LSB)) each of 8 bits(7(MSB) -> 0(LSB))
    
    integer i;
    
    always @(posedge clk)
        begin
            if(rst) 
                begin  
                    for(i=0; i<=7; i=i+1)
                        mem[i] <= 0;
                end
            if (wr_en && (full==0)) 
                begin
                    mem[wr_ptr] <= data_in;
                    wr_ptr <= wr_ptr + 1'b1;
                end
            if(rd_en && (empty == 0)) 
                begin
                    data_out <= mem[rd_ptr];
                    rd_ptr <= rd_ptr + 1'b1;
                end
        end
        
        assign full =  ((wr_ptr + 1'b1) == rd_ptr) ? 1'b1 : 1'b0; 
        assign empty = (wr_ptr == rd_ptr);                
endmodule
