//1-bit full adder
`timescale 1ns/1ps

module full_adder_1bit(
  a,
  b,
  cin,
  s,
  cout
  );
  
  input a, b, cin;
  output s, cout;
  
  wire sin, c0;
  
  half_adder_1bit u_half_adder_1bit(
    .a(a),
    .b(b),
    .s(sin),
    .cout(c0)
    );
  
  assign s = sin ^ cin;
  assign cout = c0|(sin & cin);
  
endmodule
