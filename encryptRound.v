/******************************************************************************
 ***									    ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024   ***
 ***									    ***
 *** Final Project							    ***
 ***									    ***
 ******************************************************************************
 *** Filename: AES.v			   Created by John Truong, 5/3/24   ***
 ***									    ***
 ******************************************************************************
 *** This module models the encryption round of a AES algorithm which 	    ***
 *** instantiates each of the four algorithms for one round.		    ***
 ***		________4x4 State Array__________			    ***
 ***		|Col0	|Col1	|Col2	|Col3	|			    ***
 ***	Row0	|7:0	|39:32	|71:64	|103:96	|  		 	    ***
 ***	Row1	|15:8	|47:40	|79:72	|111:104|  			    ***
 ***	Row2	|23:16	|55:48	|87:80	|119:112|  			    ***
 ***	Row3	|31:24	|63:56	|95:88	|127:120|  			    ***
 ******************************************************************************
 ******************************************************************************/



module encryptRound(stateArray, key, newState);
	// Declaration of Input and Outputs
	input [127:0] stateArray, key;
	output [127:0] newState;

	// wire declaration for the subsequent state array outputs from the respective algorithm
	wire [127:0] afterSubBytes, afterShiftRows, afterMixColumns, afterAddroundKey;

	// subBytes instantiation utilizing input state array
	subBytes SB(stateArray, afterSubBytes);			
	
	// shiftRows instantiaton utilizing previous state array
	shiftRows SR(afterSubBytes,afterShiftRows);	
	
	// mixColumns instantiation utilizing previous state array
	mixColumns MC(afterShiftRows,afterMixColumns);	

	// addRoundkey instantiation utilizing previous state array
	addRoundKey ARK(afterMixColumns, newState, key);		
	
	// this output would then be used as the input state array for the next round
endmodule
