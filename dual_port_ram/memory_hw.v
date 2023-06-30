`define FPGA

module memory_hw(
  w_clk,
  r_clk,
  PUSH,
  SW,
  fnd_0,
  fnd_1,
  LED
  );
  //LED[0]: error, LED[2:1]: 2bit_status_vld, LED[3]: dout_vld, LED[4]: full 
  //PUSH[0]: n_rst, PUSH[1]: din_vld, PUSH[2]: read
  
  parameter SIZE = 8;
  
  input w_clk, r_clk;
  
  input [SIZE-1:0] SW;
  wire [SIZE-1:0] din;
  
  input [2:0] PUSH;
  wire din_vld, read;
  wire din_vld_de, read_de;
  
  output [4:0] LED;
  wire error, dout_vld;
  wire [1:0] status_vld;
  
  output [6:0] fnd_0;
  output [6:0] fnd_1;
  
  wire [SIZE-1:0] dout;
  wire w_en;
  wire [3:0] w_addr;
  wire [SIZE-1:0] w_data;
  wire [SIZE-1:0] q;
  wire [3:0] r_addr;
  wire [1:0] r_done;
  
  reg [9:0] fnd_num_0;
  reg [9:0] fnd_num_1;
  
  
  //din_vld, read debounce
  debounce u_debounce_din_vld(
    .clk(w_clk),
    .n_rst(PUSH[0]),
    .din(PUSH[1]),
    .dout(din_vld_de)
    );
  
  debounce u_debounce_read(
    .clk(r_clk),
    .n_rst(PUSH[0]),
    .din(PUSH[2]),
    .dout(read_de)
    );
	 
  
  //din_vld, read edge detect
  edge_detector edge_detector_din_vld(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(din_vld_de),
	 .dout(din_vld)
	 );
	
  edge_detector edge_detector_read(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(read_de),
	 .dout(read)
	 );
  
  
  //SW edge detect
  edge_detector edge_detector_sw_0(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[0]),
	 .dout(din[0])
	 );
	 
	edge_detector edge_detector_sw_1(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[1]),
	 .dout(din[1])
	 );
	
	edge_detector edge_detector_sw_2(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[2]),
	 .dout(din[2])
	 );
	
	edge_detector edge_detector_sw_3(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[3]),
	 .dout(din[3])
	 );
	
	edge_detector edge_detector_sw_4(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[4]),
	 .dout(din[4])
	 );
	
	edge_detector edge_detector_sw_5(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[5]),
	 .dout(din[5])
	 );
	
	edge_detector edge_detector_sw_6(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[6]),
	 .dout(din[6])
	 );
	
	edge_detector edge_detector_sw_7(
    .clk(w_clk),
	 .n_rst(PUSH[0]),
	 .din(SW[7]),
	 .dout(din[7])
	 );
	 
	//
  
  write_ctrl u_write_ctrl(
    .clk(w_clk),
    .din(din),
    .din_vld(din_vld),
    .n_rst(PUSH[0]),
    .r_done(r_done),
    .full(LED[4]),
    .status_vld(status_vld),
    .w_addr(w_addr[0]),
    .w_data(w_data),
    .w_en(w_en)
    );
  
  `ifdef FPGA
  ram_dual_port_2x32 ram_dual_port_2x32_inst(
     .data(w_data),
     .rdaddress(r_addr),
     .rdclock(r_clk),
     .wraddress(w_addr),
     .wrclock(w_clk),
     .wren(w_en),
     .q(q)
     );
	 `endif
  
  read_ctrl u_read_ctrl(
    .clk(r_clk),
    .n_rst(PUSH[0]),
    .r_data(q),
    .status_vld(status_vld),
    .dout(dout),
    .dout_vld(dout_vld),
    .r_addr(r_addr[0]),
    .r_done(r_done),
    .read(read),
    .error(error)
    );
	 
	 //dout_vld, error delay
	 delay delay_dout_vld(
	   .clk(r_clk),
		.n_rst(PUSH[0]),
		.din(dout_vld),
		.dout(LED[3])
		);
	
	 delay delay_error(
	   .clk(r_clk),
		.n_rst(PUSH[0]),
		.din(error),
		.dout(LED[0])
		);
		
    
  assign LED[2:1] = status_vld;
  
  assign w_addr[3:1] = 3'b000;
  assign r_addr[3:1] = 3'b000;
  
  //fnd_num
  always @(posedge r_clk or negedge PUSH[0]) begin
    if (!PUSH[0]) begin
	   fnd_num_0 <= 10'h000;
		fnd_num_1 <= 10'h000;
	  end
	 else begin
	   fnd_num_0 <= (r_done == 2'b01)? {2'b00, dout} : fnd_num_0;
		fnd_num_1 <= (r_done == 2'b10)? {2'b00, dout} : fnd_num_1;
	 end
  end
  
    
  fnd_encoder u_fnd_encoder_0(
    .number(fnd_num_0),
    .fnd(fnd_0)
    );  
  
  fnd_encoder u_fnd_encoder_1(
    .number(fnd_num_1),
    .fnd(fnd_1)
    );
    
 
  
endmodule
