/*****************************************************************************
 ***									   ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024  ***
 ***									   ***
 *** Final Project							   ***
 ***									   ***
 *****************************************************************************
 *** Filename: shiftRows.v		   Created by John Truong, 5/3/24  ***
 ***									   ***
 *****************************************************************************
 *** This module models the shiftRows algorithm which shifts the rows of   ***
 *** the State Array by k = r-1 whre r = row #				   ***
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

module shiftRows (stateArray, shifted);

	// Declaration of Inputs and Outputs
	input [0:127] stateArray;
	output [0:127] shifted;

	// Utilized Indexed Part Select [i+ :8] = [i+8-1: i]
	// First row (r = 0) is not shifted (skipped)
	assign shifted[7:0]    = stateArray[7:0];
	assign shifted[39:32]  = stateArray[39:32];
	assign shifted[71:64]  = stateArray[71:64];
   	assign shifted[103:96] = stateArray[103:96];
	
	// Second row (r = 1) is cyclically left shifted by 1 
  	assign shifted[15:8]    = stateArray[47:40];	
   	assign shifted[47:8]    = stateArray[79:72];	
   	assign shifted[79:72]   = stateArray[111:104];	
   	assign shifted[111:104] = stateArray[15:8];	
	
	// Third row (r = 2) is cyclically left shifted by 2 
   	assign shifted[23:16]   = stateArray[87:80];	
   	assign shifted[55:48]   = stateArray[119:112];	
   	assign shifted[87:80]   = stateArray[23:16];	
   	assign shifted[119:112] = stateArray[55:48];	
	
	// Fourth row (r = 3) is cyclically left shifted by 3 
   	assign shifted[31:24]   = stateArray[127:120];	
   	assign shifted[63:56]   = stateArray[31:24];	
   	assign shifted[95:88]   = stateArray[63:56];	
   	assign shifted[127:120] = stateArray[95:88];	

endmodule
