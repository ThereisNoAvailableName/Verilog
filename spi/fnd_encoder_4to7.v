module fnd_encoder_4to7(
  number,
  fnd
  );
  
  input [3:0] number; 
  output [6:0] fnd;
  reg [6:0] fnd;

  //case for fnd_0
  always @(number) begin
    case(number)
      4'h0 : fnd = 7'b100_0000; //0
      4'h1 : fnd = 7'b111_1001; //1
      4'h2 : fnd = 7'b010_0100; //2
      4'h3 : fnd = 7'b011_0000;
      4'h4 : fnd = 7'b001_1001;
      4'h5 : fnd = 7'b001_0010;
      4'h6 : fnd = 7'b000_0010;
      4'h7 : fnd = 7'b111_1000;
      4'h8 : fnd = 7'b000_0000;
      4'h9 : fnd = 7'b001_0000;
		4'ha : fnd = 7'b000_1000;
		4'hb : fnd = 7'b000_0011;
		4'hc : fnd = 7'b100_0110;
		4'hd : fnd = 7'b010_0001;
		4'he : fnd = 7'b000_0110;
		4'hf : fnd = 7'b000_1110;
      default : fnd = 7'b111_1111;
    endcase
  end

endmodule
