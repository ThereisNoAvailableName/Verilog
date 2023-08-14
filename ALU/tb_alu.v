`timescale 1ns/1ps

module tb_alu();
  
  reg [3:0] a, b;
  reg [1:0] sel;
  wire [7:0] out;
  
  integer i;
  
  initial begin
    //case 1 :  a = 0000, b = 1111
    a = 4'h0; 
    b = 4'hf;
    
    for (i=0; i<4; i=i+1) begin
      sel = i;
      #10;
    end
    
    
    //case 2 : a = 0110, b = 1010
    a = 4'h6; 
    b = 4'ha;
    
    for (i=0; i<4; i=i+1) begin
      sel = i;
      #10;
    end
    
    $stop;
    
  end
  
  
  alu u_alu(
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
  );
  
endmodule
