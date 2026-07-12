module mod_b (
    input clk, rst,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg rd_en
);
    parameter idle = 2'b00, s1 = 2'b01, data_state = 2'b10;
    reg [1:0] ps, ns;

    // State Transition Logic [11]
    always @(posedge clk) begin
        if (rst) ps <= idle;
        else ps <= ns;
    end

    // Next State & Output Logic [11, 12]
    always @(*) begin
        case (ps)
            idle: begin
                    ns = s1; 
                    rd_en = 0;
                  end
            s1:  begin 
                    ns = data_state;  
                  end
            data_state: begin 
                    ns = idle; 
                    rd_en = 1; 
                    data_out = data_in;
                  end // Read only in data_state
        endcase
    end

endmodule
