// Prueba de lectura muy rápida (con el módulo FTDI modificado)
// Basado en los tutoriales de Juan Gonzalez ( https://github.com/Obijuan/open-fpga-verilog-tutorial )

module program(input clk, input [7:0] logic_input, input FSDO, input FSCTS, output FSDI, output FSCLK, output LED);
wire clk;
wire FSDO;
wire FSCTS;
reg FSDI = 0;
wire FSCLK;

wire [7:0] logic_input;

wire [10:0] logic_input_registered;

assign logic_input_registered[0] = 1; // FSDI=1 (idle state)
assign logic_input_registered[1] = 0;
assign logic_input_registered[9:2] = logic_input;
assign logic_input_registered[10] = 1; // Destination bit (1=portB)

reg [3:0] current_bit = 0;


assign FSCLK = clk;
assign LED = FSDI;


always @(negedge clk)
    if ((FSCTS || current_bit > 0) && current_bit < 10) current_bit <= current_bit + 1;
    else current_bit <= 0;

always @(posedge clk)
    FSDI <= logic_input_registered[current_bit];

endmodule


