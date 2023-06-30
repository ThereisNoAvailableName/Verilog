module read_ctrl(
  clk,
  n_rst,
  r_data,
  status_vld,
  dout,
  dout_vld,
  r_addr,
  r_done,
  read,
  error
  );
  
  parameter SIZE = 8;
  parameter PUSH = 1'b1; //convert 0 to 1 at debounce
  
  input clk, n_rst;
  input [SIZE-1:0] r_data;
  input [1:0] status_vld;
  input read;
  
  output [SIZE-1:0] dout;
  output dout_vld, r_addr;
  output [1:0] r_done;
  output error;
  
  reg [SIZE-1:0] dout;
  reg dout_vld, r_addr;
  reg [1:0] r_done;
  reg error;
  
  //dout
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      dout <= {SIZE{1'b0}};
    end
    else if (read == PUSH) begin
		dout <= r_data;
    end
	 else
	   dout <= dout;
  end
  
  //dout_vld
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      dout_vld <= 1'b0;
    end
    else if (read == PUSH) begin
      if ((r_addr == 1'b0) && (status_vld[0] == 1'b1))
        dout_vld <= 1'b1;
      else if ((r_addr == 1'b1) && (status_vld[1] == 1'b1))
        dout_vld <= 1'b1;
      else
        dout_vld <= 1'b0;
    end
	 else begin
	   dout_vld <= 1'b0;
	 end
  end
  
  //r_done
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      r_done <= 2'b00;
    end
    else if (read == PUSH) begin
      if ((r_addr == 1'b0) && (status_vld[0] == 1'b1))
        r_done <= 2'b01;
      else if ((r_addr == 1'b1) && (status_vld[1] == 1'b1))
        r_done <= 2'b10;
      else
        r_done <= 2'b00;
    end
  end
  
  //r_addr
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      r_addr <= 1'b0;
    end
    else if ((r_addr == 1'b0) && (r_done[0] == 1'b1)) begin
      r_addr <= ~r_addr;
    end
	 else if ((r_addr == 1'b1) && (r_done[1] == 1'b1))
	   r_addr <= ~r_addr;
	 else
		r_addr = r_addr;
  end
  
  //error
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      error <= 1'b0;
    end
    else if (read == PUSH) begin
      if ((r_addr == 1'b0) && (status_vld[0] == 1'b0))
        error <= 1'b1;
      else if ((r_addr == 1'b1) && (status_vld[1] == 1'b0))
        error <= 1'b1;
      else
        error <= 1'b0;
    end
	 else
	   error <= 1'b0;
  end
  
  
endmodule
