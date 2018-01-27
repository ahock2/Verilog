`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create Date:    11:56:23 11/13/2017                                                                        //
// Name: Adam Hock                                                                                            //
//                                                                                                            //
// Project Name: TrafficLight.v                                                                               //
//                                                                                                            //
// Description:   This program (when connected to an FGPA circuit board)                                      //
//		  simulates a traffic light controller. When one traffic light                                //
//		  is red and there is a car waiting at the traffic light. The light                           //
//		  will wait 12 clock cycles. This clock will stop if the car leaves for a right turn.         //
//		  When the clock reaches 12 clock cycles, the green light will turn yellow. Then, after       //
//		  4 more clock cycles, the yellow light will turn red and the other red light will turn green.//
//		  This project was created in my digital logic class.					      //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module TrafficLight(
    input NS_sensor,
    input EW_sensor,
    input Clock,
    output NS_Red,
    output NS_Yellow,
    output NS_Green,
    output EW_Red,
    output EW_Yellow,
    output EW_Green
    );
	 
	reg[6:1]s;
	parameter[6:1]
	
	A = 6'b000000,
	B = 6'b000001,
	C0 = 6'b000010,
	C1 = 6'b000011,
	C2 = 6'b000100,
	C3 = 6'b000101,
	C4 = 6'b000110,
	C5 = 6'b000111,
	C6 = 6'b001000,
	C7 = 6'b001001,
	C8 = 6'b001010,
	C9 = 6'b001011,
	C10= 6'b001100,
	C11= 6'b001101,
	D0 = 6'b001110,
	D1 = 6'b001111,
	D2 = 6'b010000,
	D3 = 6'b010001,
	D4 = 6'b010010,
	D5 = 6'b010011,
	D6 = 6'b010100,
	D7 = 6'b010101,
	D8 = 6'b010110,
	D9 = 6'b010111,
	D10= 6'b011000,
	D11= 6'b011001,
	E0 = 6'b011010,
	E1 = 6'b011011,
	E2 = 6'b011100,
	E3 = 6'b011101,
	F0 = 6'b011110,
	F1 = 6'b011111,
	F2 = 6'b100000,
	F3 = 6'b100001;
	
	always @(posedge Clock)
		
		case(s)
// A means no cars are waiting and NS is green //
				A: if (EW_sensor)	s <= D0;
					else				s <= A;
// B means no cars are waiting and EW is green //					
				B: if (NS_sensor)	s <= C0;
					else				s <= B;
// C means NS car is waiting //					
				C0 : if (NS_sensor) s <= C1;
					 else				 s <= B;
				C1 : if (NS_sensor) s <= C2;
					 else				 s <= B;
				C2 : if (NS_sensor) s <= C3;
					 else				 s <= B;
				C3 : if (NS_sensor) s <= C4;
					 else				 s <= B;
				C4 : if (NS_sensor) s <= C5;
					 else				 s <= B;
				C5 : if (NS_sensor) s <= C6;
					 else				 s <= B;
				C6 : if (NS_sensor) s <= C7;
					 else				 s <= B;
				C7 : if (NS_sensor) s <= C8;
					 else				 s <= B;
				C8 : if (NS_sensor) s <= C9;
					 else				 s <= B;
				C9 : if (NS_sensor) s <= C10;
					 else				 s <= B;
				C10: if (NS_sensor) s <= C11;
					 else				 s <= B;
				C11: if (NS_sensor) s <= F0;
					 else				 s <= B;
// D means EW car is waiting //					
				D0 : if (EW_sensor) s <= D1;
					 else				 s <= A;
				D1 : if (EW_sensor) s <= D2;
					 else				 s <= A;
				D2 : if (EW_sensor) s <= D3;
					 else				 s <= A;
				D3 : if (EW_sensor) s <= D4;
					 else				 s <= A;
				D4 : if (EW_sensor) s <= D5;
					 else				 s <= A;
				D5 : if (EW_sensor) s <= D6;
					 else				 s <= A;
				D6 : if (EW_sensor) s <= D7;
					 else				 s <= A;
				D7 : if (EW_sensor) s <= D8;
					 else				 s <= A;
				D8 : if (EW_sensor) s <= D9;
					 else				 s <= A;
				D9 : if (EW_sensor) s <= D10;
					 else				 s <= A;
				D10: if (EW_sensor) s <= D11;
					 else				 s <= A;
				D11: if (EW_sensor) s <= E0;
					 else				 s <= A;
// E means NS is at a yellow light //
				E0: s <= E1;
				E1: s <= E2;
				E2: s <= E3;
				E3: s <= B;
// F means EW is at a yellow light //
				E0: s <= F1;
				E1: s <= F2;
				E2: s <= F3;
				E3: s <= A;
				default: s<=A;
		endcase

		assign NS_Red = (
		s==B|| // EW is green //
		s==C0|| // When NS car is waiting //
		s==C1||
		s==C2||
		s==C3||
		s==C4||
		s==C5||
		s==C6||
		s==C7||
		s==C8||
		s==C9||
		s==C10||
		s==C11||
		s==F0|| // When EW is yellow //
		s==F1||
		s==F2||
		s==F3
		);
		assign NS_Yellow = (
		s==E0||
		s==E1||
		s==E2||
		s==E3
		);
		assign NS_Green = (
		s==A|| // NS is green //
		s==D0|| // EW is waiting //
		s==D1||
		s==D2||
		s==D3||
		s==D4||
		s==D5||
		s==D6||
		s==D7||
		s==D8||
		s==D9||
		s==D10||
		s==D11
		);
		assign EW_Red = (
		s==A|| // NS is green //
		s==D0|| // EW is waiting //
		s==D1||
		s==D2||
		s==D3||
		s==D4||
		s==D5||
		s==D6||
		s==D7||
		s==D8||
		s==D9||
		s==D10||
		s==D11||
		s==E0|| // NS is yellow //
		s==E1||
		s==E2||
		s==E3
		);
		assign EW_Yellow = (
		s==F0|| 
		s==F1||
		s==F2||
		s==F3
		);
		assign EW_Green = (
		s==B|| // EW_Green //
		s==C0|| // When NS car is waiting //
		s==C1||
		s==C2||
		s==C3||
		s==C4||
		s==C5||
		s==C6||
		s==C7||
		s==C8||
		s==C9||
		s==C10||
		s==C11
		);
		
endmodule
