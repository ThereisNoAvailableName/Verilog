module fnd_encoder(
  number,
  fnd
  );

input [9:0] number; //0~9
output [6:0] fnd;
reg [6:0] fnd;

//case for fnd_0
always @(number) begin
  case(number)
    10'b00000_00001 : fnd = 7'b100_0000; //0
    10'b00000_00010 : fnd = 7'b111_1001; //1
    10'b00000_00100 : fnd = 7'b010_0100; //2
    10'b00000_01000 : fnd = 7'b011_0000;
    10'b00000_10000 : fnd = 7'b001_1001;
    10'b00001_00000 : fnd = 7'b001_0010;
    10'b00010_00000 : fnd = 7'b000_0010;
    10'b00100_00000 : fnd = 7'b111_1000;
    10'b01000_00000 : fnd = 7'b000_0000;
    10'b10000_00000 : fnd = 7'b001_0000;
    default : fnd = 7'b111_1111;
  endcase
end

endmodule