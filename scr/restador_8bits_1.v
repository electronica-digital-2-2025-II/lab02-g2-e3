//`include "sumador_8bits_1.v"

module restador_8bits_1(
    input  [7:0] A, B,
    output [7:0] D,      // Resultado de A - B
    output       Borrow, // Borrow (equivalente al carry, pero para resta)
    output       Ovf     // Overflow en complemento a 2
);

    wire [7:0] B_invertido;
    assign B_invertido = ~B; // complemento a 1 de B

    // Señales internas del sumador
    wire [7:0] S;
    wire Carry;

    // Instanciamos el sumador para hacer A + (~B) + 1
    sumador_8bits_1 SUM_REST (
        .A(A),
        .B(B_invertido),
        .Cin(1'b1),    // sumamos el +1 para complemento a 2
        .S(S),
        .Carry(Carry),
        .Ovf(Ovf)
    );

    // Asignamos las salidas
    assign D = S;
    assign Borrow = ~Carry; // interpretado como "borrow" en la resta

endmodule
