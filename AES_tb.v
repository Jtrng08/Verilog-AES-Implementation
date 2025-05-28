/******************************************************************************
 ***									    ***
 *** ECE 526 L Final Project 			John Truong, Spring, 2024   ***
 ***									    ***
 *** Final Project							    ***
 ***									    ***
 ******************************************************************************
 *** Filename: AES_tb.v			   Created by John Truong, 5/3/24   ***
 ***									    ***
 ******************************************************************************
 *** This module is the testbench module for the AES top module. It uses    ***
 *** parallel instantiatiation to test the three variable key sizes (128,   ***
 *** 192, and 256 bits). It also use module parameter overrides to change   ***		   		    
 *** parameters N (size of key), Nr (# of rounds) and Nk (# of words).      ***
 *** Finally to test the validity of the design I utilized test case inputs ***
 *** from Github sources and utilized their outputs as expected outputs.    ***
 ***		________4x4 State Array__________			    ***
 ***		|Col0	|Col1	|Col2	|Col3	|			    ***
 ***	Row0	|7:0	|39:32	|71:64	|103:96	|  		 	    ***
 ***	Row1	|15:8	|47:40	|79:72	|111:104|  			    ***
 ***	Row2	|23:16	|55:48	|87:80	|119:112|  			    ***
 ***	Row3	|31:24	|63:56	|95:88	|127:120|  			    ***
 ******************************************************************************
 ******************************************************************************/

`define MONITOR_STR "\n Encrypt128 = %h  Expected128 = %h \n Encrypt192 = %h  Expected192 = %h \n Encrypt256 = %h  Expected256 = %h\n"

module AES_tb();

parameter WIDTH = 128;

// Declaration of Output and Input ports for AES module(s)
wire [WIDTH-1:0] e128;
wire [WIDTH-1:0] e192;
wire [WIDTH-1:0] e256;
reg  [WIDTH-1:0] in, in2;

// The expected outputs from the encryption module
wire[127:0] expected128 = 128'h_3925841d02dc09fbdc118597196a0b32;
wire[127:0] expected192 = 128'h_dda97ca4864cdfe06eaf70a0ec0d7191;
wire[127:0] expected256 = 128'h_8ea2b7ca516745bfeafc49904b496089;

// The different keys used for testing (one of each type)
wire[127:0] key128 = 128'h_2b7e151628aed2a6abf7158809cf4f3c;
wire[191:0] key192 = 192'h_000102030405060708090a0b0c0d0e0f1011121314151617;
wire[255:0] key256 = 256'h_000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

// Instantiate top level module for testing
AES a1 (e128, in, key128);
AES #(192,12,6) a2 (e192, in2, key192);
AES #(256,14,8) a3 (e256, in2, key256);

initial begin
	$vcdpluson; // System task for waveform software
	
	// monitor system task for simv output
	$monitor(`MONITOR_STR, e128, expected128, e192, expected192, e256, expected256);

	// The plain text used as input
	in = 128'h_3243f6a8885a308d313198a2e0370734; in2 = 128'h_00112233445566778899aabbccddeeff;


	#100;
	$finish;
		
end

endmodule
