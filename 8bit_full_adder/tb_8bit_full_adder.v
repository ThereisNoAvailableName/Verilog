`timescale 1ns/1ps
`define T_CLK 10

module tb_full_adder_8bit();
  
  integer i, j;
  
  reg [7:0] a, b;
  reg cin;
  
  wire [7:0] s;
  wire cout;
  
  
  initial begin
    
    //1st case, cin = 0
    cin = 1'b0;
    
    //I set the range 0 to 9.
    //You can test the range 0 to 255(2^8 - 1) by setting i<256, j<256.
    // But it will take a while.
    for(i=0; i<10; i=i+1) begin
      for(j=0; j<10; j=j+1) begin
        a = i;
        b = j;
        #(`T_CLK);
        $display("%d + %d + %d = %d", a, b, cin, {cout, s});
      end
    end
    
    //2nd case, cin = 1'b1
    cin = 1'b1;
    
    for(i=0; i<10; i=i+1) begin
      for(j=0; j<10; j=j+1) begin
        a = i;
        b = j;
        #(`T_CLK);
        $display("%d + %d + %d = %d", a, b, cin, {cout, s});
      end
    end
    
    $stop;
  end
  
  
  full_adder_8bit full_adder_8bit_u(
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
    );
    
endmodule
    
    
