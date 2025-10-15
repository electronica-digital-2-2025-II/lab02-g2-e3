module sumador_1bit (
  input A,
  input B,
  input Ci,
  output Co,
  output So
);
  assign Co = ((A & Ci) | (A & B) | (B & Ci)); // Esta es una operacion de AND y OR, Co sera 1 cuando al menos dos entradas sean 1
  assign So = (( A ^ B ^ Ci) ); // Esta es una XOR, So sera 1 cuando un numero impar de entradas sea 1
endmodule

