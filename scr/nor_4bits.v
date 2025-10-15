`include "nor_1bit.v"

module nor_4bits (
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] Y
);

    // Instanciamos las 4 puertas NOR de 1 bit
    nor_1bit N0 (.A(A[0]), .B(B[0]), .Y(Y[0]));
    nor_1bit N1 (.A(A[1]), .B(B[1]), .Y(Y[1]));
    nor_1bit N2 (.A(A[2]), .B(B[2]), .Y(Y[2]));
    nor_1bit N3 (.A(A[3]), .B(B[3]), .Y(Y[3]));

endmodule
