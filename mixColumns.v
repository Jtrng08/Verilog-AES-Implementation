/*****************************************************************************
 ***									   ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024  ***
 ***									   ***
 *** Final Project							   ***
 ***									   ***
 *****************************************************************************
 *** Filename: mixColumns.v		   Created by John Truong, 5/3/24  ***
 ***									   ***
 *****************************************************************************
 *** This module multiplies the input state array with a constant matrix   ***
 *** which is done by multiplying the state array's column with the 	   ***
 *** constant matrix's row. Doing this would result in the new state 	   ***
 *** array's column. This would be repeated for each column.		   ***
 ***								 	   ***
 ***		________4x4 State Array__________			   ***
 ***		|Col0	|Col1	|Col2	|Col3	|			   ***
 ***	Row0	|7:0	|39:32	|71:64	|103:96	|	  		   ***
 ***	Row1	|15:8	|47:40	|79:72	|111:104|			   ***
 ***	Row2	|23:16	|55:48	|87:80	|119:112|			   ***
 ***	Row3	|31:24	|63:56	|95:88	|127:120|			   ***
 ***									   ***
 ***	Table Above is the State Array in question. 			   ***
 ***		________4x4 Constant Matrix__________			   ***
 ***		|Col0	|Col1	|Col2	|Col3	|			   ***
 ***	Row0	|02	|03	|01	|01	|	  		   ***
 ***	Row1	|01	|02	|03	|01     |			   ***
 ***	Row2	|01	|01	|02	|03	|			   ***
 ***	Row3	|03	|01	|01	|02	|			   ***
 ***									   ***
 ***	Table Above is the Constant Matrix in question. 		   ***
 *****************************************************************************
 *****************************************************************************/


module mixColumns(state_in,state_out);

input [127:0] state_in;
output[127:0] state_out;

	genvar i;

	// Generate statement to instantiate though each column 
	generate 
	for( i = 0 ; i < 4 ; i = i + 1 ) begin : m_col
	
		// when i = 0 : col 0 | when i = 1 : col 1 | when i = 2 : col 2 | when i = 3 : col 3
		// XOR (add) each output of the matrix multiplication to create new columns

		// multiply column i of state array with constant matrix row 0
	   	assign state_out[i*32+:8]        = mb3(state_in[(i*32 + 24)+:8]) ^ state_in[(i*32 + 16)+:8] ^ state_in[(i*32 + 8)+:8] ^ mb2(state_in[i*32+:8]); // row 0
		// multiply column i of state array with constant matrix row 1
		assign state_out[(i*32 + 8)+:8]  = state_in[(i*32 + 24)+:8] ^ state_in[(i*32 + 16)+:8] ^ mb2(state_in[(i*32 + 8)+:8]) ^ mb3(state_in[i*32+:8]); // row 1
		// multiply column i of state array with constant matrix row 2
		assign state_out[(i*32 + 16)+:8] = state_in[(i*32 + 24)+:8] ^ mb2(state_in[(i*32 + 16)+:8]) ^ mb3(state_in[(i*32 + 8)+:8]) ^ state_in[i*32+:8]; // row 2
		// multiply column i of state array with constant matrix row 3
		assign state_out[(i*32 + 24)+:8] = mb2(state_in[(i*32 + 24)+:8]) ^ mb3(state_in[(i*32 + 16)+:8]) ^ state_in[(i*32 + 8)+:8] ^ state_in[i*32+:8]; // row 3



		// Utilize Indexed Part Select to select the necessary bits for each column using a non-constant variable
	end

	endgenerate

endmodule

function [7:0] mb2; //multiply by 2
	input [7:0] x;
	begin 
	/* multiplication by 2 can be defined by shifting the bit to the left by 1, 
	and if the original 8 bits had a 1 at the MSB then xor the result with {1b}*/
			if(x[7] == 1) mb2 = ((x << 1) ^ 8'h1b);
			else mb2 = x << 1; 
	end 	
endfunction


	/* multiplication by 3 can done be defined as (11 = 10 XOR 01 = 2 XOR 1), therefore 
	mb3 can be done by multiplication of 2 and then xor the result with the input*/
function [7:0] mb3;
	input [7:0] x;
	begin 	
		mb3 = mb2(x) ^ x;
	end 
endfunction