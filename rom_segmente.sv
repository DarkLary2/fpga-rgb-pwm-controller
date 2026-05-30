module rom_segmente (
    input  logic [2:0] sel_seg, 
    output logic [6:0] segmente 
);
    always_comb begin
        unique case (sel_seg)
          
            3'd1:    segmente = 7'b1110111;
            3'd2:    segmente = 7'b0100100;
            3'd3:    segmente = 7'b0000011;
            3'd4:    segmente = 7'b0001100;
            default: segmente = 7'b1111111; 
        endcase
    end
endmodule