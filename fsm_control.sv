module fsm_control (
    input  logic       clk,
    input  logic       rst,
    input  logic       btn_pulse,
    output logic       en_red,
    output logic       en_green,
    output logic       en_blue,
    output logic [2:0] cifra 
);
    
    typedef enum logic [2:0] {
        ST_ALL_OFF = 3'd0, 
        ST_RED     = 3'd1, 
        ST_GREEN   = 3'd2, 
        ST_BLUE    = 3'd3,
        ST_WHITE   = 3'd4  
    } state_t;

    state_t current_state, next_state;


    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= ST_ALL_OFF;
        else
            current_state <= next_state;
    end

 
    always_comb begin
        next_state = current_state;
        if (btn_pulse) begin
            if (current_state == ST_WHITE)
                next_state = ST_ALL_OFF;
            else
                next_state = state_t'(current_state + 1'b1); 
        end
    end

 
    always_comb begin
     
        en_red   = 1'b0;
        en_green = 1'b0;
        en_blue  = 1'b0;
        cifra    = current_state; 

        unique case (current_state) 
            ST_ALL_OFF: begin
                en_red   = 1'b0;
                en_green = 1'b0;
                en_blue  = 1'b0;
            end
            ST_RED: begin
                en_red   = 1'b1;
            end
            ST_GREEN: begin
                en_green = 1'b1;
            end
            ST_BLUE: begin
                en_blue  = 1'b1;
            end
            ST_WHITE: begin
                en_red   = 1'b1;
                en_green = 1'b1;
                en_blue  = 1'b1;
            end
        endcase
    end
endmodule