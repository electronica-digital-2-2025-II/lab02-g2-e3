module nor_1bit (
    input  A,
    input  B,
    output Y
);
    assign Y = ~(A | B); // NOR = negación del OR
endmodule
