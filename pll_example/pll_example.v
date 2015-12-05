// Using a PLL to make an LED blink at ~1.072Hz
// Thanks to Clifford Wolf for his explanation on PLL usage (https://github.com/cliffordwolf/yosys/issues/107#issuecomment-162163626)

module program(
    input   clk, // set_io clk 21
    output  LED  // set_io LED 99
);

    wire clk;
    wire LED;

    wire clk_new;
    wire BYPASS;
    wire RESETB;

    SB_PLL40_CORE #(
        .FEEDBACK_PATH("PHASE_AND_DELAY"),
        .DELAY_ADJUSTMENT_MODE_FEEDBACK("FIXED"),
        .DELAY_ADJUSTMENT_MODE_RELATIVE("FIXED"),
        .PLLOUT_SELECT("SHIFTREG_0deg"),
        .SHIFTREG_DIV_MODE(1'b0),
        .FDA_FEEDBACK(4'b0000),
        .FDA_RELATIVE(4'b0000),
        .DIVR(4'b0000),
        .DIVF(7'b0000010), // frecuency multiplier = 2+1 = 3
        .DIVQ(3'b010),
        .FILTER_RANGE(3'b001),
    ) uut (
        .REFERENCECLK   (clk),
        .PLLOUTCORE     (clk_new), // output frequency = 3 * input frequency
        .BYPASS         (BYPASS),
        .RESETB         (RESETB)
        //.LOCK (LOCK )
    );

    //assign LED = clk_new;
    assign BYPASS = 0;
    assign RESETB = 1;

    // Prescaler from https://github.com/Obijuan/open-fpga-verilog-tutorial/wiki/Cap%C3%ADtulo-5%3A-Prescaler-de-N-bits
    parameter N = 25;
    reg [N-1:0] count = 0;
    assign LED = count[N-1]; // MSB to output
    always @(posedge(clk_new)) begin
      count <= count + 1;
    end

endmodule

