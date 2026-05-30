module rom_cifra (
    input  logic [2:0] cifra, 
    output logic [3:0] sel_cifra 
);
    always_comb begin
        unique case (cifra)
            3'd1:    sel_cifra = 4'b0111; 
            3'd2:    sel_cifra = 4'b1011; 
            3'd3:    sel_cifra = 4'b1101;
            3'd4:    sel_cifra = 4'b1110; 
            default: sel_cifra = 4'b1111;
        endcase
    end
endmodule