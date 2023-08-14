//4-bit ALU
`timescale 1ns/1ps

module alu(
  a,
  b,
  sel,
  out
  );
  
  input [3:0] a, b;
  input [1:0] sel; 
  
  output [7:0] out;
  reg [7:0] out;
  
  always @(a or b or sel or out) begin
    case(sel)
      2'b00 : out = (a + b);
      2'b01 : out = (a - b);
      2'b10 : out = (a * b);
      2'b11 : out = (a ^ b);
      default : out = 8'h00;
    endcase
  end
  
  
endmodule
