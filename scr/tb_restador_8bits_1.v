`timescale 1ns/1ps
`include "restador_8bits_1.v"

module tb_restador_8bits_1;

    reg  [7:0] A, B;
    wire [7:0] D;
    wire Borrow, Ovf;

    // Instanciamos el restador de 8 bits
    restador_8bits_1 uut (
        .A(A),
        .B(B),
        .D(D),
        .Borrow(Borrow),
        .Ovf(Ovf)
    );

    initial begin
        $dumpfile("restador_8bits_tb.vcd");
        $dumpvars(0, tb_restador_8bits_1);

        $display("Tiempo |      A      |      B      |     D (A-B)    | Borrow | Ovf");
        $display("-------------------------------------------------------------------");

        // Caso 1: 10 - 3 = 7
        A = 8'd10; B = 8'd3; #10;
        $display("%4dns | %8b | %8b | %8b (%3d) |   %b    |  %b", $time, A, B, D, D, Borrow, Ovf);

        // Caso 2: 20 - 25 = -5 (resultado negativo en complemento a 2)
        A = 8'd20; B = 8'd25; #10;
        $display("%4dns | %8b | %8b | %8b (%3d) |   %b    |  %b", $time, A, B, D, $signed(D), Borrow, Ovf);

        // Caso 3: 127 - 1 = 126
        A = 8'd127; B = 8'd1; #10;
        $display("%4dns | %8b | %8b | %8b (%3d) |   %b    |  %b", $time, A, B, D, D, Borrow, Ovf);

        // Caso 4: 0 - 1 = -1
        A = 8'd0; B = 8'd1; #10;
        $display("%4dns | %8b | %8b | %8b (%3d) |   %b    |  %b", $time, A, B, D, $signed(D), Borrow, Ovf);

        // Caso 5: Overflow: (-128) - (1)
        A = 8'b10000000; B = 8'b00000001; #10;
        $display("%4dns | %8b | %8b | %8b (%3d) |   %b    |  %b", $time, A, B, D, $signed(D), Borrow, Ovf);

        $finish;
    end
endmodule
