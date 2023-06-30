
module de0_doorlock_2modes(
	CLOCK_50,
	BUTTON,
	SW,
	LEDG,
	HEX0_D /*,
	HEX1_D,
	HEX2_D,
	HEX3_D */
); 

input CLOCK_50;
input [2:0] BUTTON;
input [9:0] SW;

output [3:0] LEDG;
output [6:0] HEX0_D;
/*
output [6:0] HEX1_D;
output [6:0] HEX2_D;
output [6:0] HEX3_D;
*/

wire star_de;
wire sharp_de;
wire star_ed;
wire sharp_ed;

wire [9:0] number_d1;

wire open, alarm, mode_active, mode_set;

//input 
//debounce
debounce 
  //#(.N(2))
  u_debounce_star(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(BUTTON[1]),
  .dout(star_de)
  );

debounce
  //#(.N(2))
  u_debounce_sharp(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(BUTTON[2]),
  .dout(sharp_de)
  );
//

//edge detection
edge_detector u_edge_detector_star(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(star_de),
  .dout(star_ed)
);

edge_detector u_edge_detector_sharp(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(sharp_de),
  .dout(sharp_ed)
);


edge_detector u_edge_detector_0(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[0]),
  .dout(number_d1[0])
);

edge_detector u_edge_detector_1(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[1]),
  .dout(number_d1[1])
);

edge_detector u_edge_detector_2(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[2]),
  .dout(number_d1[2])
);

edge_detector u_edge_detector_3(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[3]),
  .dout(number_d1[3])
);

edge_detector u_edge_detector_4(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[4]),
  .dout(number_d1[4])
);

edge_detector u_edge_detector_5(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[5]),
  .dout(number_d1[5])
);

edge_detector u_edge_detector_6(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[6]),
  .dout(number_d1[6])
);

edge_detector u_edge_detector_7(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[7]),
  .dout(number_d1[7])
);

edge_detector u_edge_detector_8(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[8]),
  .dout(number_d1[8])
);

edge_detector u_edge_detector_9(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(SW[9]),
  .dout(number_d1[9])
);
//

doorlock_2modes u_doorlock_2modes(
  .clk(CLOCK_50),
	.n_rst(BUTTON[0]),
	.star(star_ed),
	.sharp(sharp_ed),
	.number(number_d1),
	.open(open),
	.alarm(alarm),
	.mode_active(mode_active),
	.mode_set(mode_set)
);

//output
//delay
delay u_delay_open(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(open),
  .dout(LEDG[0])
);

delay u_delay_alarm(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(alarm),
  .dout(LEDG[1])
);

delay u_delay_active(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(mode_active),
  .dout(LEDG[2])
);

delay u_delay_set(
  .clk(CLOCK_50),
  .n_rst(BUTTON[0]),
  .din(mode_set),
  .dout(LEDG[3])
);
//

//fnd
//number_d1 -> SW to find error
fnd_encoder u_fnd_encoder(
  .number(SW),
  .fnd(HEX0_D)
);
//

endmodule
