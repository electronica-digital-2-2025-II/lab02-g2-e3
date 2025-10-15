`timescale 1ns/1ps
`include "ALU_4bits.v"

module tb_ALU_4bits;

    reg [3:0] A, B;
    reg [2:0] sel;
    wire [7:0] Y;
    wire overflow, zero;

    // Instancia de la ALU
    ALU_4bits uut (
        .A(A),
        .B(B),
        .sel(sel),
        .Y(Y),
        .overflow(overflow),
        .zero(zero)
    );

    // Generación del archivo de simulación
    initial begin
        $dumpfile("ALU_4bits_tb.vcd");
        $dumpvars(0, tb_ALU_4bits);

        // Cabecera de resultados
        $display("-----------------------------------------------------------");
        $display("SEL |   A   |   B   |       Y (Resultado)     | OVF | ZERO ");
        $display("-----------------------------------------------------------");

        // --- SUMA ---
        sel = 3'b000;
        A = 4'd3;  B = 4'd5;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero);
        A = 4'd15; B = 4'd2;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // overflow esperado
        A = 4'd0;  B = 4'd0;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // suma nula

        // --- RESTA ---
        sel = 3'b001;
        A = 4'd9;  B = 4'd3;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero);
        A = 4'd3;  B = 4'd9;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // resultado negativo
        A = 4'd8;  B = 4'd8;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // resultado cero

        // --- MULTIPLICACIÓN ---
        sel = 3'b010;
        A = 4'd3;  B = 4'd2;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero);
        A = 4'd15; B = 4'd15; #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // producto máximo
        A = 4'd7;  B = 4'd0;  #10; $display("%b | %d | %d | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // multiplicar por 0

        // --- NOR ---
        sel = 3'b011;
        A = 4'b0000; B = 4'b0000; #10; $display("%b | %b | %b | %b |  %b  |  %b", sel, A, B, Y[3:0], overflow, zero);
        A = 4'b1111; B = 4'b1111; #10; $display("%b | %b | %b | %b |  %b  |  %b", sel, A, B, Y[3:0], overflow, zero);
        A = 4'b1010; B = 4'b0101; #10; $display("%b | %b | %b | %b |  %b  |  %b", sel, A, B, Y[3:0], overflow, zero);

        // --- DESPLAZAMIENTO IZQ ---
        sel = 3'b100;
        A = 4'b0001; B = 4'bxxxx; #10; $display("%b | %b | ---- | %b |  %b  |  %b", sel, A, Y[3:0], overflow, zero);
        A = 4'b1111; #10; $display("%b | %b | ---- | %b |  %b  |  %b", sel, A, Y[3:0], overflow, zero);

        // --- CASOS LÍMITE ---
        sel = 3'b000; // suma
        A = 4'b1111; B = 4'b1111; #10; $display("%b | %b | %b | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // overflow por saturación
        sel = 3'b001; // resta
        A = 4'b0000; B = 4'b1111; #10; $display("%b | %b | %b | %b (%d) |  %b  |  %b", sel, A, B, Y, Y, overflow, zero); // resta con negativo grande

        $display("-----------------------------------------------------------");
        $finish;
    end

endmodule
