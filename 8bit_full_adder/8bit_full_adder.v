//8bit full adder
`timescale 1ns/1ps

module full_adder_8bit(
  a,
  b,
  cin,
  s,
  cout
  );
  
  input [7:0] a, b;
  input cin;
  
  output [7:0] s;
  output cout;
  
  wire c0;
  
  
  ripple_carry_adder u_fa_0(
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(cin),
    .s(s[3:0]),
    .cout(c0)
    );
    
  ripple_carry_adder u_fa_1(
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(c0),
    .s(s[7:4]),
    .cout(cout)
    );


endmodule