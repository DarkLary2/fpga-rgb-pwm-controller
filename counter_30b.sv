module counter_30b (
    input  logic        clk,
    input  logic        en,
    input  logic        rst,
    output logic [29:0] count
);
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= '0; 
        end else if (en) begin
            count <= count + 1'b1;
        end
    end
endmodule