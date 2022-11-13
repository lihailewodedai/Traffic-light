module trafficlight ( output reg [4:0] 	lightseq,	//the 5-bit light sequence
		      input             clock,		//clock that drives the fsm
		      input             reset,		//reset signal 
		      input             start);		//input from pedestrian


// declare internal variables here (how many bits required?)
reg[3:0]	current_state, next_state;


// implement your next state combinatorial logic block here
always @(*)
begin
	case(current_state)
		'b0000:	if(start) 	next_state = 'b0001; // State 0 
				else	  	next_state = 'b0000;
		'b0001: 		  next_state = 'b0010; // State 1
		'b0010: 		  next_state = 'b0011; // State 2
		'b0011: 		  next_state = 'b0100; // State 3
		'b0100: 		  next_state = 'b0101; // State 4
		'b0101:	if(start) 	next_state = 'b1000; // State 5
				else 		next_state = 'b0110;
		'b0110:	if(start) 	next_state = 'b1001; // State 6
				else	  	next_state = 'b0111;
		'b0111:	if(start) next_state = 'b1010; // State 7
				else	  next_state = 'b0000;
		'b1000:		  next_state = 'b1001;// State 8
		'b1001:		  next_state = 'b1010;// State 9
		'b1010: 		  next_state = 'b0001;// State 10
		default: next_state = 'b0000;
	endcase
end


// implement your current state assignment, register, here
always @ (posedge clock, posedge reset) 
begin
	if (reset)
		current_state <= 0;
	else
		current_state <= next_state;
end
	


// implement your output logic here
always @ (*) 
begin
	case(current_state)
		'b0000: lightseq = 'b01001; // output for state 0: d'9
		'b0001: lightseq = 'b01010; // output for state 1: d'10
		'b0010: lightseq = 'b10100; // output for state 2: d'20
		'b0011: lightseq = 'b10100; // output for state 3: d'20
		'b0100: lightseq = 'b10100; // output for state 4: d'20
		'b0101: lightseq = 'b01110; // output for state 5: d'14
		'b0110: lightseq = 'b01001; // output for state 6: d'9
		'b0111: lightseq = 'b01001; // output for state 7: d'9
		'b1000: lightseq = 'b01001; // output for state 8: d'9
		'b1001: lightseq = 'b01001; // output for state 9: d'9
		'b1010: lightseq = 'b01001; // output for state 10: d'9
	endcase
end



endmodule
