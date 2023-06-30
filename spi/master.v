module master(
  clk,
  n_rst,
  sdata,
  start,
  sclk,
  cs_n,
  fnd_0,
  fnd_1
  );
  
  input clk, n_rst, sdata, start;
  wire start_deb, start_ed;
  
  output sclk, cs_n;
  reg [7:0] dout;
  reg [7:0] dout_fnd;
  
  output [6:0] fnd_0, fnd_1;
  
  parameter PUSH = 1'b0;
  
  
  //start debounce & edge detector
  debounce debounce_u(
    .clk(clk),
	 .n_rst(n_rst), 
	 .din(start), 
	 .dout(start_deb)
  );
	
  edge_detector_sclk edge_detector_sclk_u(
    .clk(clk),
    .n_rst(n_rst),
    .din(start_deb),
    .dout(start_ed),
	 .cnt1(cnt1)
	 );
  
  //cnt1
  reg [4:0] cnt1;
  
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      cnt1 <= 5'h00;
    end
    else begin
      cnt1 <= (cnt1 == 5'h19)? 5'h01 : (cnt1 + 5'h01); //1, 2, ..., 25, 1, 2, ...
    end
  end
  
  //sclk
  assign sclk = (cnt1 < 5'h0d)? 1'b1 : 1'b0; //1 ~ 12: UP,  13 ~ 25: DOWN
  
  
  //cnt2
  reg [3:0] cnt2;
  
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      cnt2 <= 4'h0;
    end
    else begin
      if (cnt1 == 5'h01) begin
        cnt2 <= (start_ed == 1'b1)? 4'h1 :
                (cnt2 == 4'h0)? cnt2 :
                (cnt2 == 4'hf)? 4'h0 : (cnt2 + 4'h1);
      end
    end
  end
  
  //cs_n
  assign cs_n = (cnt2 != 4'h0)? PUSH : ~PUSH;
  
  
  //dout
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      dout <= 8'h00;
    else begin
      if ((cs_n == PUSH) && (cnt1 == 5'h19)) begin
        dout <= (cnt2 == 4'hb)? (dout + sdata) :
                 ((cnt2 > 4'h3) && (cnt2 < 4'hb))? ({dout[6:0], 1'b0} + {sdata, 1'b0}) : dout;
      end
    end
  end
  
  
  //dout_fnd
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
	   dout_fnd <= 8'h00;
	 else
	   dout_fnd <= (cs_n == PUSH)? dout : dout_fnd;
  end
  
  //fnd_encoder
  fnd_encoder_4to7 fnd_encoder_0(
    .number(dout_fnd[3:0]),
	 .fnd(fnd_0)
	 );
	
  fnd_encoder_4to7 fnd_encoder_1(
    .number(dout_fnd[7:4]),
	 .fnd(fnd_1)
	 );
	 


endmodule