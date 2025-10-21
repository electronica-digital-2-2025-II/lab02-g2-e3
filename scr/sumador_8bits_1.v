`include "sumador_1bit.v"

module sumador_8bits_1(
    input  [7:0] A, B,
    input        Cin,
    output [7:0] S,
    output       Carry,   // carry final (bit 8)
    output       Ovf      // overflow en complemento a 2
);

    wire [7:0] C;  // wires para los carrys internos

    // Instanciamos los sumadores de 1 bit en cascada
    sumador_1bit FA0 (.A(A[0]), .B(B[0]), .Ci(Cin),  .So(S[0]), .Co(C[0]));
    sumador_1bit FA1 (.A(A[1]), .B(B[1]), .Ci(C[0]), .So(S[1]), .Co(C[1]));
    sumador_1bit FA2 (.A(A[2]), .B(B[2]), .Ci(C[1]), .So(S[2]), .Co(C[2]));
    sumador_1bit FA3 (.A(A[3]), .B(B[3]), .Ci(C[2]), .So(S[3]), .Co(C[3]));
    sumador_1bit FA4 (.A(A[4]), .B(B[4]), .Ci(C[3]), .So(S[4]), .Co(C[4]));
    sumador_1bit FA5 (.A(A[5]), .B(B[5]), .Ci(C[4]), .So(S[5]), .Co(C[5]));
    sumador_1bit FA6 (.A(A[6]), .B(B[6]), .Ci(C[5]), .So(S[6]), .Co(C[6]));
    sumador_1bit FA7 (.A(A[7]), .B(B[7]), .Ci(C[6]), .So(S[7]), .Co(C[7]));

    // El carry final (bit 8 de la suma completa)
    assign Carry = C[7];

    // Overflow en complemento a 2 (cuando los signos de A y B son iguales
    // y el signo del resultado difiere de ellos)
    assign Ovf = (A[7] == B[7]) && (S[7] != A[7]);

endmodule
