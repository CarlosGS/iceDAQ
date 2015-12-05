// Based on code by Clifford Wolf ( https://github.com/cliffordwolf/icestorm/blob/master/icefuzz/tests/sb_pll40_core.v )

module program(
    input   clk,
    output  LED
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
        .DIVR(4'b1111),
        .DIVF(7'b0000000),
        .DIVQ(3'b000),
        .FILTER_RANGE(3'b001),
    ) uut (
        .REFERENCECLK   (clk),
        .PLLOUTCORE     (clk_new),
        .BYPASS         (BYPASS),
        .RESETB         (RESETB)
        //.LOCK (LOCK )
    );

    assign LED = clk_new;
    assign BYPASS = 0;
    assign RESETB = 0;

endmodule

