module top (
    input  logic       clk, 
    input  logic [1:0] sw, 
    input  logic       btn, 
    output logic       out_red,
    output logic       out_green,
    output logic       out_blue,
    output logic [3:0] cifra_display,
    output logic [6:0] segmente
);
 
    logic rst; 
    logic en; 
    
    assign rst = sw[1]; 
    assign en  = sw[0]; 
    
    logic btn_pulse;
    logic en_red, en_green, en_blue;
    logic [2:0] w_cifra;

  
    debounce #(
        .LIMIT(250000) 
    ) u_debounce (
        .clk,
        .rst,
        .in_buton(btn), 
        .out(btn_pulse)
    );

    fsm_control u_fsm (
        .clk,
        .rst,
        .btn_pulse,
        .en_red,
        .en_green,
        .en_blue,
        .cifra(w_cifra)
    );

 
    PWM #(
        .limit_period(30'd1000), 
        .limit_duty_cicle(30'd300) 
    ) u_pwm_red (
        .clk,
        .en(en && en_red),
        .rst,
        .out(out_red) 
    );

    PWM #(
        .limit_period(30'd1000), 
        .limit_duty_cicle(30'd500) 
    ) u_pwm_green (
        .clk,
        .en(en && en_green),
        .rst,
        .out(out_green)
    );

    PWM #(
        .limit_period(30'd1000), 
        .limit_duty_cicle(30'd700)
    ) u_pwm_blue (
        .clk,
        .en(en && en_blue),
        .rst,
        .out(out_blue) 
    );

    rom_cifra u_rom_cifra (
        .cifra(w_cifra),
        .sel_cifra(cifra_display)
    );

    rom_segmente u_rom_segmente (
        .sel_seg(w_cifra),
        .segmente
    );

endmodule