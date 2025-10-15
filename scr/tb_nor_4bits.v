`timescale 1ns/1ps
`include "nor_4bits.v"

module tb_nor_4bits;
    reg  [3:0] A, B;
    wire [3:0] Y;

    nor_4bits uut (
        .A(A),
        .B(B),
        .Y(Y)
    );

    initial begin
        $dumpfile("tb_nor_4bits.vcd");
        $dumpvars(0, tb_nor_4bits);

        // Pruebas
        A = 4'b0000; B = 4'b0000; #10;
        A = 4'b0001; B = 4'b0010; #10;
        A = 4'b0101; B = 4'b0011; #10;
        A = 4'b1111; B = 4'b1111; #10;
        A = 4'b1010; B = 4'b0101; #10;

        $finish;
    end

    initial begin
        $display("Tiempo |    A    |    B    |   Y (A NOR B)");
        $monitor("%4t  | %b | %b | %b", $time, A, B, Y);
    end
endmodule
