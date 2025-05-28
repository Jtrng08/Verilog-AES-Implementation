/*****************************************************************************
 ***									   ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024  ***
 ***									   ***
 *** Final Project							   ***
 ***									   ***
 *****************************************************************************
 *** Filename: AES_Encrypt.v		   Created by John Truong, 5/3/24  ***
 ***									   ***
 *****************************************************************************
 *** This module implements the AES encryption process. 		   ***
 *** Parameter N is the WIDTH of the key. (Default 128, 192, 256)	   ***
 *** Parameter Nr is the complement number of rounds for each variable key ***
 *** size (Default 10, 12, 14)						   ***
 *** Parameter Nk indicates number of words for each key size 		   ***
 *** (Default 4, 6, 8) 							   ***
 *** Can be found by through key(in bits) / 8 = #(bytes) / 4 = #(words)    ***
 ***								 	   ***
 ***		________4x4 State Array__________			   ***
 ***		|Col0	|Col1	|Col2	|Col3	|			   ***
 ***	Row0	|7:0	|39:32	|71:64	|103:96	|  no shift	 	   ***
 ***	Row1	|15:8	|47:40	|79:72	|111:104|  shift by 1		   ***
 ***	Row2	|23:16	|55:48	|87:80	|119:112|  shift by 2		   ***
 ***	Row3	|31:24	|63:56	|95:88	|127:120|  shift by 3		   ***
 ***									   ***
 ***	Table Above is the State Array in question.			   ***
 *****************************************************************************
 *****************************************************************************/


module AES_Encrypt#(parameter N = 128, parameter Nr = 10,parameter Nk = 4)(stateArray, key, newState);
input [127:0] stateArray;
input [N-1:0] key;
output [127:0] newState;
wire [(128*(Nr+1))-1 :0] fullkeys;
wire [127:0] states [Nr+1:0] ;		// vector of size 128, and array of [Nr+1:0]
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;

// First generate the round keys for the encryption process (11, 13, and 15 for the respective key sizes)
keyExpansion #(Nk, Nr) ke (key, fullkeys);

// Before encryption round first add the round key with the state array.
addRoundKey addrk1 (stateArray, states[0], fullkeys[((128*(Nr+1))-1)-:128]);	

genvar i;
generate
	// Loop for the encryption rounds (10, 12, 14 for respective key sizes)
	for(i = 1; i < Nr ; i = i + 1)begin : round
		// Instantiate the Encryption Round module
		// utilizes the previous state array to generate the next state array
		encryptRound ER( states[i-1], fullkeys[(((128*(Nr+1))-1)-128*i)-:128], states[i]);	
	end
	// Final Round
	// Instantiate the necessary algorithms except mixColumns
	subBytes sb(states[Nr-1],afterSubBytes);
	shiftRows sr(afterSubBytes,afterShiftRows);		
	addRoundKey addrk2(afterShiftRows,states[Nr],fullkeys[127:0]);
	// Assign the output to the previously generated state array
	assign newState = states[Nr];

endgenerate

endmodule
