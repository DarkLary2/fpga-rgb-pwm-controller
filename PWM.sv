module PWM #(
    parameter bit [29:0] limit_period = 30'd1000,    
    parameter bit [29:0] limit_duty_cicle = 30'd500  
)(
    input  logic clk, 
    input  logic en, 
    input  logic rst, 
    output logic out  
);
    logic [29:0] count;
    logic        w_less_eq;
    logic        w_gr;
    logic        internal_rst;

    comp_less_eq u_comp_less_eq (
        .in0(count),
        .in1(limit_period),
        .out(w_less_eq)
    );

   
    assign internal_rst = rst || (!w_less_eq);

    counter_30b u_counter (
        .clk,  
        .en,
        .rst(internal_rst),
        .count
    );

    comp_gr u_comp_gr (
        .in0(count),
        .in1(limit_duty_cicle),
        .out(w_gr)
    );

    assign out = w_gr && en;

endmodule