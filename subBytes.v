/*****************************************************************************
 ***									   ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024  ***
 ***									   ***
 *** Final Project							   ***
 ***									   ***
 *****************************************************************************
 *** Filename: subBytes.v		   Created by John Truong, 5/3/24  ***
 ***									   ***
 *****************************************************************************
 *** This module substitutes each byte of the state array with the 	   ***
 *** corresponding sbox equivalent.					   ***
 ***								 	   ***
 ***		________4x4 State Array__________			   ***
 ***		|Col0	|Col1	|Col2	|Col3	|			   ***
 ***	Row0	|7:0	|39:32	|71:64	|103:96	|	  		   ***
 ***	Row1	|15:8	|47:40	|79:72	|111:104|			   ***
 ***	Row2	|23:16	|55:48	|87:80	|119:112|			   ***
 ***	Row3	|31:24	|63:56	|95:88	|127:120|			   ***
 ***									   ***
 ***	Table Above is the State Array in question.			   ***
 *****************************************************************************
 *****************************************************************************/

module subBytes(stateArray, newState);
// Declaration of Inputs and Outputs
input [127:0] stateArray;	
output [127:0] newState;

genvar i;

// Generate to instantiate sbox 16 times to substitute all 128 bits (16 bytes)
generate 
	// Substitutes the state array with the sbox equivalent
	for(i=0 ; i < 128 ; i = i + 8 ) begin :sub_Bytes 	
		sbox s(stateArray[i +:8], newState[i +:8]);	
	// Indexed part select equivalent of [i+8-1 : i]
	// Essesentially taking a byte and outputing a byte
	end

endgenerate


endmodule
