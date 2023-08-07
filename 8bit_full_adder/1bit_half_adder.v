//1-bit half adder
`timescale 1ns/1ps

module half_adder_1bit(
  a,
  b,
  s,
  cout
  );
  
  input a, b;
  output s, cout;
  
  assign s = a ^ b;
  assign cout = a & b;
  
endmodule
