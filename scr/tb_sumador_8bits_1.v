`timescale 1ns/1ps
`include "sumador_8bits_1.v"

module tb_sumador_8bits_1;

    // Entradas
    reg [7:0] A, B;
    reg Cin;

    // Salidas
    wire [7:0] S;
    wire Carry, Ovf;

    // Instanciamos el DUT (Device Under Test)
    sumador_8bits_1 DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Carry(Carry),
        .Ovf(Ovf)
    );

    // Proceso de prueba
    initial begin
        // Archivo de salida para GTKWave
        $dumpfile("tb_sumador_8bits_1.vcd");
        $dumpvars(0, tb_sumador_8bits_1);

        // Cabecera en consola
        $display("Tiempo |   A      +   B     + Cin | Carry Ovf | S (bin)     | S (dec)");
        $display("---------------------------------------------------------------");

        // Pruebas
        Cin = 0;

        // Caso 1: 10 + 5
        A = 8'd10; B = 8'd5; #10;
        $display("%4dns | %3d (0x%h) + %3d (0x%h) + %b |   %b     %b  | %8b | %3d",
                 $time, A, A, B, B, Cin, Carry, Ovf, S, S);

        // Caso 2: 120 + 50 → overflow esperado
        A = 8'd120; B = 8'd50; #10;
        $display("%4dns | %3d (0x%h) + %3d (0x%h) + %b |   %b     %b  | %8b | %3d",
                 $time, A, A, B, B, Cin, Carry, Ovf, S, S);

        // Caso 3: 200 + 100 → overflow
        A = 8'd200; B = 8'd100; #10;
        $display("%4dns | %3d (0x%h) + %3d (0x%h) + %b |   %b     %b  | %8b | %3d",
                 $time, A, A, B, B, Cin, Carry, Ovf, S, S);

        // Caso 4: 255 + 1 → Carry=1
        A = 8'd255; B = 8'd1; #10;
        $display("%4dns | %3d (0x%h) + %3d (0x%h) + %b |   %b     %b  | %8b | %3d",
                 $time, A, A, B, B, Cin, Carry, Ovf, S, S);

        // Caso 5: 85 + 170 (valores complementarios)
        A = 8'd85; B = 8'd170; #10;
        $display("%4dns | %3d (0x%h) + %3d (0x%h) + %b |   %b     %b  | %8b | %3d",
                 $time, A, A, B, B, Cin, Carry, Ovf, S, S);

        // Caso 6: con Cin=1
        Cin = 1;
        A = 8'd50; B = 8'd25; #10;
        $display("%4dns | %3d (0x%h) + %3d (0x%h) + %b |   %b     %b  | %8b | %3d",
                 $time, A, A, B, B, Cin, Carry, Ovf, S, S);

        // Fin de simulación
        $finish;
    end

endmodule
