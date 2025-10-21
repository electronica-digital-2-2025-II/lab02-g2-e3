//`include "sumador_8bits_1.v"

module multiplicador_4bits(
    input  [3:0] A,  // multiplicando
    input  [3:0] B,  // multiplicador
    output [7:0] P   // producto
);
    // Productos parciales
    wire [7:0] PP0, PP1, PP2, PP3;
    wire [7:0] S1, S2, S3;
    wire Carry1, Carry2, Carry3;

    // Generación de productos parciales (cada bit de B multiplica a A)
    assign PP0 = B[0] ? {4'b0000, A}       : 8'b00000000;
    assign PP1 = B[1] ? {3'b000,  A, 1'b0} : 8'b00000000;
    assign PP2 = B[2] ? {2'b00,   A, 2'b00}: 8'b00000000;
    assign PP3 = B[3] ? {1'b0,    A, 3'b000}:8'b00000000;

    // Suma de productos parciales usando el sumador estructural
    sumador_8bits_1 SUM1 (.A(PP0), .B(PP1), .Cin(1'b0), .S(S1), .Carry(Carry1));
    sumador_8bits_1 SUM2 (.A(S1),  .B(PP2), .Cin(1'b0), .S(S2), .Carry(Carry2));
    sumador_8bits_1 SUM3 (.A(S2),  .B(PP3), .Cin(1'b0), .S(S3), .Carry(Carry3));

    // Resultado final
    assign P = S3;

endmodule
