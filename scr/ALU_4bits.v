`include "sumador_8bits_1.v"
`include "restador_8bits_1.v"
`include "multiplicador_4bits.v"
`include "nor_4bits.v"

module ALU_4bits (
    input  [3:0] A, B,
    input  [2:0] sel,       // selector de operación
    output reg [7:0] Y,     // resultado
    output reg overflow,    // bandera de overflow
    output reg zero         // bandera de resultado cero
);

    // --- Señales internas ---
    wire [7:0] sum_result, sub_result, mult_result, nor_result;
    wire ovf_sum, ovf_sub;

    // --- Instancias de los módulos estructurales ---

    // SUMA
    sumador_8bits_1 U_sum (
        .A({4'b0000, A}),
        .B({4'b0000, B}),
        .Cin(1'b0),
        .S(sum_result),
        .Carry(),
        .Ovf(ovf_sum)
    );

    // RESTA
    restador_8bits_1 U_sub (
        .A({4'b0000, A}),
        .B({4'b0000, B}),
        .D(sub_result),
        .Borrow(),
        .Ovf(ovf_sub)
    );

    // MULTIPLICACIÓN
    multiplicador_4bits U_mult (
        .A(A),
        .B(B),
        .P(mult_result)
    );

    // NOR
    nor_4bits U_nor (
        .A(A),
        .B(B),
        .Y(nor_result[3:0])
    );
    assign nor_result[7:4] = 4'b0000; // extensión a 8 bits

    // --- Lógica de selección ---
    always @(*) begin
        case (sel)
            3'b000: begin  // Suma
                Y = sum_result;
                overflow = ovf_sum;
            end
            3'b001: begin  // Resta
                Y = sub_result;
                overflow = ovf_sub;
            end
            3'b010: begin  // Multiplicación
                Y = mult_result;
                overflow = 1'b0;
            end
            3'b011: begin  // NOR
                Y = nor_result;
                overflow = 1'b0;
            end
            3'b100: begin  // Desplazamiento a la izquierda
                Y = {4'b0000, A << 1};
                overflow = 1'b0;
            end
            default: begin
                Y = 8'b00000000;
                overflow = 1'b0;
            end
        endcase

        // Bandera de cero
        zero = (Y == 8'b00000000);
    end

endmodule
