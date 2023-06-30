module write_ctrl(
  clk,
  n_rst,
  din,
  din_vld,
  r_done,
  full,
  status_vld,
  w_addr,
  w_data,
  w_en
  );
  
  parameter SIZE = 8;
  parameter PUSH = 1'b1; //convert 0 to 1 at debounce
  
  input clk, n_rst;
  input [SIZE-1:0] din;
  input din_vld;
  input [1:0] r_done;
  
  output full;
  output [1:0] status_vld;
  output w_addr, w_en;
  output [SIZE-1:0] w_data; 
  
  reg [1:0] status_vld;
  reg w_addr, w_en;
  reg [SIZE-1:0] w_data; 
  
  
  
  //w_data
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      w_data <= {SIZE{1'b0}};
    end
    else if (din != 8'h00) begin
      w_data <= din;
    end
	 else 
	   w_data <= w_data;
  end
  
  
  //w_en
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      w_en <= 1'b0;
    else if (din_vld == PUSH) begin
      if ((w_addr == 1'b0) && (status_vld[0] == 1'b0))
        w_en <= 1'b1;
      else if ((w_addr == 1'b1) && (status_vld[1] == 1'b0))
        w_en <= 1'b1;
      else
        w_en <= 1'b0;
    end
	 else
	   w_en <= 1'b0;
  end
  
  //status_vld & w_addr
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      status_vld <= 2'b00;
    end
    else if (din_vld == PUSH) begin
      if ((w_addr == 1'b0) && (status_vld[0] == 1'b0))
        status_vld[0] <= 1'b1;
      else if ((w_addr == 1'b1) && (status_vld[1] == 1'b0))
        status_vld[1] <= 1'b1;
		else
		  status_vld <= status_vld;
	 end
    else if (r_done != 2'b00)
      status_vld <= (status_vld & (~r_done));
    else 
      status_vld <= status_vld;
  end
  
  //w_addr
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      w_addr <= 1'b0;
    end
    else begin 
	   if (full == 1'b1)
		  w_addr <= w_addr;
      else if ((w_addr == 1'b0) && (status_vld[0] == 1'b1))
        w_addr <= 1'b1;
      else if ((w_addr == 1'b1) && (status_vld[1] == 1'b1))
        w_addr <= 1'b0; 
      else
        w_addr <= w_addr;
    end
  end
  
  assign full = (status_vld == 2'b11)? 1'b1 : 1'b0;

endmodule