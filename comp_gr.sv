module comp_gr (
    input  logic [29:0] in0,
    input  logic [29:0] in1,
    output logic        out
);
    assign out = (in0 > in1);
endmodule