`timescale 1ns/1ps
`include "multiplicador_4bits.v"

module tb_multiplicador_4bits;

    // Entradas
    reg [3:0] A, B;

    // Salida
    wire [7:0] P;

    // Instancia del módulo bajo prueba (UUT)
    multiplicador_4bits uut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin
        // Archivo de salida para GTKWave
        $dumpfile("tb_multiplicador_4bits.vcd");
        $dumpvars(0, tb_multiplicador_4bits);

        // Pruebas
        $display("Tiempo |   A   |   B   |    Producto (P)");
        $display("--------------------------------------");

        A = 4'b0000; B = 4'b0000; #10;
        $display("%4dns | %b | %b | %b", $time, A, B, P);

        A = 4'b0001; B = 4'b0011; #10; // 1 * 3 = 3
        $display("%4dns | %b | %b | %b", $time, A, B, P);

        A = 4'b0010; B = 4'b0101; #10; // 2 * 5 = 10
        $display("%4dns | %b | %b | %b", $time, A, B, P);

        A = 4'b0110; B = 4'b0011; #10; // 6 * 3 = 18
        $display("%4dns | %b | %b | %b", $time, A, B, P);

        A = 4'b1111; B = 4'b1111; #10; // 15 * 15 = 225 (11100001)
        $display("%4dns | %b | %b | %b", $time, A, B, P);

        A = 4'b1010; B = 4'b0101; #10; // 10 * 5 = 50
        $display("%4dns | %b | %b | %b", $time, A, B, P);

        $finish;
    end

endmodule
