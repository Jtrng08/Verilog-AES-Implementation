/*****************************************************************************
 ***									   ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024  ***
 ***									   ***
 *** Final Project							   ***
 ***									   ***
 *****************************************************************************
 *** Filename: addRoundKey.v		   Created by John Truong, 5/3/24  ***
 ***									   ***
 *****************************************************************************
 *** This module models the addRoundKey algorithm which XORs the input 	   ***
 *** state array with the key. This operation essentially adds the key with***   		
 *** the input state array.						   ***
 *****************************************************************************/


module addRoundKey(stateArray, newState, key);
	
	// Declaration of Input and Output
	input [127:0] stateArray;
	input [127:0] key;
	output [127:0] newState;
	
	// Add key to the state array
	assign newState = key ^ stateArray;

endmodule
