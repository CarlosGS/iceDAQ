// Prueba de lectura muy rápida (con el módulo FTDI modificado)
// Basado en los tutoriales de Juan Gonzalez ( https://github.com/Obijuan/open-fpga-verilog-tutorial )

// Patched for increased TX speed using the icepll to change CLK speed to 48MHz

module program(
    input   clk,
    input   [7:0] logic_input,
    input   FSDO,
    input   FSCTS,
    output  FSDI,
    output  FSCLK,
    output  LED
);
    wire clk48;

    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .PLLOUT_SELECT("GENCLK"),
        .DIVR(4'b0000),
        .DIVF(7'b0111111),  
        .DIVQ(3'b100),
        .FILTER_RANGE(3'b001)
    ) uut (
        .LOCK(lock),
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .REFERENCECLK(clk),
        .PLLOUTCORE(clk48)
    );

    wire FSDO;
    wire FSCTS;
    reg FSDI = 0;
    wire FSCLK;

    wire [7:0] logic_input;

    reg send = 1;

    wire [10:0] output_frame;

    assign output_frame[0] = 1; // FSDI=1 (idle state)
    assign output_frame[1] = 0;
    assign output_frame[9:2] = logic_input;
    assign output_frame[10] = 1; // Destination bit (1=portB)

    reg [3:0] current_bit = 0;


    assign FSCLK = clk48;
    assign LED = send;

    always @(posedge clk48) begin
        if (((send & FSCTS) | current_bit > 0) & current_bit < 10)
            current_bit <= current_bit + 1;
         else
            current_bit <= 0;
        FSDI <= output_frame[current_bit];
    end


endmodule

