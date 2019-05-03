`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 11:18:27 PM
// Design Name: 
// Module Name: Conditional_Sum_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Conditional_Sum_tb();

localparam longint BITS = 32;
  	
 	logic clk = 0;
    logic [BITS-1:0]num1 = 0;
    logic [BITS-1:0]num2 = 0;
    logic cin = 0;
  	logic mode = 0;
    logic cout;
    logic [BITS-1:0]sum;
    
  Conditional_Sum #(.Bits(BITS)) dut
  	(.clk(clk),
     .a(num1),
     .b(num2),
     .cin(cin),
     .mode(mode),
     .cout(cout),
     .sum(sum)
    );

    always begin
        #5;
        clk = ~clk;
  
    end
      
    initial begin
    	//$dumpfile("dump.vcd");
      	//$dumpvars;
      repeat(1000)begin
        @(posedge clk);
        mode = $urandom_range(1,0);
      	num1 = $urandom_range(2**BITS - 1,0);
      	num2 = $urandom_range(2**BITS - 1,0);
      	cin  = $urandom_range(1,0);
      end
      	$finish;
    end   
endmodule  