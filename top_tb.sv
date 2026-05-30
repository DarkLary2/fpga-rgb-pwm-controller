`timescale 1ns / 1ps

module top_tb;

 
    logic       clk;
    logic [1:0] sw;
    logic       btn;
    logic       out_red;
    logic       out_green;
    logic       out_blue;
    logic [3:0] cifra_display;
    logic [6:0] segmente;

  
    top uut (.*);

   
    defparam uut.u_debounce.LIMIT = 5;

 
    always #5 clk = ~clk;

    initial begin
    
        clk = 0;
        sw  = 2'b10; 
        btn = 0;
        
        #40;
        sw[1] = 0; 
        #20;
        sw[0] = 1;  
        #20;

      
        btn = 1; #100;
        btn = 0; #200;

     
        btn = 1; #100;
        btn = 0; #200;

     
        btn = 1; #100;
        btn = 0; #200;

      
        #3000;
        
        $finish; 
    end

endmodule