//4bit ripple carry adder 
`timescale 1ns/1ps

module ripple_carry_adder(
  a,
  b,
  cin,
  s,
  cout
  );
  
  input [3:0] a, b;
  input cin;
  
  output [3:0] s;
  output cout;
  
  wire c0, c1, c2;
  
  full_adder_1bit u_full_adder_0(
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .s(s[0]),
    .cout(c0)
    );
    
  full_adder_1bit u_full_adder_1(
    .a(a[1]),
    .b(b[1]),
    .cin(c0),
    .s(s[1]),
    .cout(c1)
    );
    
  full_adder_1bit u_full_adder_2(
    .a(a[2]),
    .b(b[2]),
    .cin(c1),
    .s(s[2]),
    .cout(c2)
    );
    
  full_adder_1bit u_full_adder_3(
    .a(a[3]),
    .b(b[3]),
    .cin(c2),
    .s(s[3]),
    .cout(cout)
    );

endmodule