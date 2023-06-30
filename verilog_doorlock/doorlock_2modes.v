module doorlock_2modes(
	clk,
	n_rst,
	star, //X
	sharp,
	number,
	open,
	alarm,
	mode_active,
	mode_set
);


localparam A_IDLE  = 3'h0;
localparam A_PW1   = 3'h1;
localparam A_PW2   = 3'h2;
localparam A_PW3   = 3'h3;
localparam A_ERR   = 3'h4;
localparam A_CHECK = 3'h5;
localparam A_OPEN  = 3'h6;
localparam A_ALARM = 3'h7;

localparam S_IDLE = 3'h0;
localparam S_RDY  = 3'h1;
localparam S_SET1 = 3'h2;
localparam S_SET2 = 3'h3;
localparam S_SET3 = 3'h4;

localparam G_ACTIVE = 1'b0;
localparam G_SET = 1'b1;

localparam L_3 = 1'b1;
localparam L_2 = 1'b0;

input clk;
input n_rst;
input star;
input sharp;
input [9:0] number;

output open;
output alarm;
output mode_active;
output mode_set;


reg [9:0] pw_1, pw_2, pw_3;
reg [9:0] user_pw1, user_pw2, user_pw3;
reg 	  pw_length;

reg       g_state, g_next_state;	
reg [2:0] a_state, a_next_state;
reg [2:0] s_state, s_next_state;


always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		g_state <= G_ACTIVE;
	end
	else begin
		g_state <= g_next_state;
	end

always @(g_state or sharp)	
	case (g_state)
		G_ACTIVE : g_next_state = (sharp == 1'b1)? G_SET    : g_state;
		G_SET    : g_next_state = (sharp == 1'b1)? G_ACTIVE : g_state;
		default  : g_next_state = G_ACTIVE;
	endcase

assign mode_active = (g_state == G_ACTIVE)? 1'b1 : 1'b0;
assign mode_set    = (g_state == G_SET)?    1'b1 : 1'b0;


always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		a_state <= A_IDLE;
	end
	else begin
		a_state <= a_next_state;
	end

wire equal, diff;

always @(a_state or g_state or number or star or equal or diff)	
	if (g_state == G_ACTIVE) begin
		case (a_state)
			A_IDLE  : a_next_state = (number != 10'h000)? A_PW1 : a_state;
			A_PW1   : a_next_state = (number != 10'h000)? A_PW2 : 
								     (star == 1'b1)? A_ALARM : a_state;
			A_PW2   : a_next_state = (number != 10'h000)? A_PW3 :
								     (star == 1'b1)? A_CHECK : a_state;
			A_PW3   : a_next_state = (number != 10'h000)? A_ERR :
									 (star == 1'b1)? A_CHECK : a_state;
			A_ERR   : a_next_state = (star == 1'b1)? A_ALARM : a_state;
			A_CHECK : a_next_state = (equal == 1'b1)? A_OPEN : 
							  	     (diff == 1'b1)? A_ALARM : a_state;
			A_OPEN  : a_next_state = A_IDLE;
			A_ALARM : a_next_state = A_IDLE;
			default : a_next_state = A_IDLE;
		endcase
	end
	else begin
		a_next_state = a_state;
	end

always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		user_pw1 <= 10'h000;
		user_pw2 <= 10'h000;
		user_pw3 <= 10'h000;
	end
	else begin
		if (g_state == G_ACTIVE) begin
			user_pw1 <= ((a_state == A_IDLE)&&(number != 10'h000))? number : 
						 (a_next_state == A_IDLE)? 10'h000 : user_pw1;
			user_pw2 <= ((a_state == A_PW1)&&(number != 10'h000))?  number : 
						 (a_next_state == A_IDLE)? 10'h000 : user_pw2;
			user_pw3 <= ((a_state == A_PW2)&&(number != 10'h000))?  number : 
						 (a_next_state == A_IDLE)? 10'h000 : user_pw3;
		end
	end

assign check = ((user_pw1 == pw_1) && (user_pw2 == pw_2) && 
			    (((pw_length == L_3)&&(user_pw3 == pw_3))|| 
				 ((pw_length == L_2)&&(user_pw3 == 10'h000))));

assign equal = ((a_state == A_CHECK) && (check==1'b1));
assign diff  = ((a_state == A_CHECK) && (check==1'b0));

assign open = (a_state == A_OPEN)? 1'b1 : 1'b0;
assign alarm = (a_state == A_ALARM)? 1'b1 : 1'b0;


wire 	   set_1, set_2, set_3;
reg  [9:0] set_pw_1;
reg [9:0] set_pw_2, set_pw_3;

//
always @(posedge clk or negedge n_rst)
  if(!n_rst) begin
    s_state <= S_IDLE;
  end
  else begin
    s_state <= s_next_state;
  end
  
always @(s_state or g_state or number or sharp)
  if (g_state == G_SET) begin
    case (s_state)
      S_IDLE: s_next_state = S_RDY;
      S_RDY: s_next_state = (number != 10'h000)? S_SET1 : s_state;
      S_SET1: s_next_state = (number != 10'h000)? S_SET2 :
                                                  (sharp == 1'b1)? S_IDLE : s_state;
      S_SET2: s_next_state = (number != 10'h000)? S_SET3 :
                                                  (sharp == 1'b1)? S_IDLE : s_state;
      S_SET3: s_next_state = (sharp == 1'b1)? S_IDLE :
                                              (number != 10'h000)? S_SET3 : s_state;
      default: s_next_state = S_IDLE;
    endcase
  end 
  else begin
    s_next_state = s_state;
  end
  
  
always @(posedge clk or negedge n_rst) begin
   if (!n_rst) begin
	   set_pw_1 <= 10'h000;
		set_pw_2 <= 10'h000;
		set_pw_3 <= 10'h000;
	end
	
	else begin
	   if (g_state == G_SET) begin
		   set_pw_1 <= (s_state == S_IDLE)? 10'h000 :
			            ((s_state == S_RDY) && (number != 10'h000))? number : set_pw_1;
			set_pw_2 = (s_state == S_IDLE)? 10'h000 :
                  ((s_state == S_SET1) && (number != 10'h000))? number : set_pw_2;
			set_pw_3 = (s_state == S_IDLE)? 10'h000 :
                  ((s_state == S_SET2) && (number != 10'h000))? number : set_pw_3;
		end
	end
	
end

/*
assign set_pw_2 = (s_state == S_IDLE)? 10'h000 :
                  ((s_state == S_SET1) && (number != 10'h000))? number : set_pw_2;
						
assign set_pw_3 = (s_state == S_IDLE)? 10'h000 :
                  ((s_state == S_SET2) && (number != 10'h000))? number : set_pw_3;
*/                                                               
  
assign set_1 = (s_next_state == S_SET2)? 1'b1 : 1'b0;
assign set_2 = (s_state == S_SET2)? 1'b1 : 1'b0;
assign set_3 = (s_state == S_SET3)? 1'b1 : 1'b0;
//

always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		pw_1 <= 10'h001;  //00000_00001
		pw_2 <= 10'h001;
		pw_3 <= 10'h001;
	end
	else begin
		pw_1 <= (set_1==1'b1)? set_pw_1 : pw_1;
		pw_2 <= (set_2==1'b1)? set_pw_2 : pw_2;
		pw_3 <= (set_3==1'b1)? set_pw_3 : pw_3;
	end

wire set_length_2, set_length_3;
always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		pw_length <= L_2;
	end
	else begin
		pw_length <= (set_length_3 == 1'b1)? L_3 :
					 (set_length_2 == 1'b1)? L_2 : pw_length;
	end

//
assign set_length_2 = (pw_3 == 10'h001)? 1'b1 : 1'b0;
assign set_length_3 = (pw_3 != 10'h001)? 1'b1 : 1'b0;
//



endmodule

