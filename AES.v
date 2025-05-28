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
 *** This module is the top module of the AES Encryption process. It uses   ***
 *** localparam as an assurance that the WIDTH of the input and output does ***
 *** not change from the fixed size of 128 bits. For parameters that need   ***		   		    
 *** to be changed like N (size of key) Nr (# of rounds) and Nk (# of words)***
 *** I use module parameraters so that it can be overriden during 	    ***
 *** instantiation.
 ***		________4x4 State Array__________			    ***
 ***		|Col0	|Col1	|Col2	|Col3	|			    ***
 ***	Row0	|7:0	|39:32	|71:64	|103:96	|  		 	    ***
 ***	Row1	|15:8	|47:40	|79:72	|111:104|  			    ***
 ***	Row2	|23:16	|55:48	|87:80	|119:112|  			    ***
 ***	Row3	|31:24	|63:56	|95:88	|127:120|  			    ***
 ******************************************************************************
 ******************************************************************************/


module AES#(parameter N=128,parameter Nr=10,parameter Nk=4)(ciphertext, plaintext, key);

// Declaration of localparam WIDTH
localparam WIDTH = 128;

// Declaration of Inputs and Outputs
output wire [WIDTH-1:0] ciphertext;
input  wire [WIDTH-1:0] plaintext;
input  wire [N-1:0] key;

// The result of the encryption module for every type
wire[127:0] encryptedOut;

// Instantiate Encryption Process
AES_Encrypt #(N, Nr, Nk) a(plaintext, key, encryptedOut);

assign ciphertext = encryptedOut; // assign output

endmodule
