module debounce #(
    parameter int LIMIT = 250000 
)(
    input  logic clk,
    input  logic rst,
    input  logic in_buton, 
    output logic out
);
    logic [19:0] counter;
    logic        btn_sync0, btn_sync1;
    logic        btn_stable;
    logic        btn_stable_delayed;

   
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            btn_sync0 <= 1'b0;
            btn_sync1 <= 1'b0;
        end else begin
            btn_sync0 <= in_buton;
            btn_sync1 <= btn_sync0;
        end
    end

  
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter    <= '0;
            btn_stable <= 1'b0;
        end else begin
            if (btn_sync1 != btn_stable) begin
                if (counter == LIMIT) begin
                    btn_stable <= btn_sync1;
                    counter    <= '0;
                end else begin
                    counter <= counter + 1'b1;
                end
            end else begin
                counter <= '0;
            end
        end
    end

    // Detector de front crescator
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            btn_stable_delayed <= 1'b0;
        end else begin
            btn_stable_delayed <= btn_stable;
        end
    end

    assign out = btn_stable && !btn_stable_delayed;

endmodule