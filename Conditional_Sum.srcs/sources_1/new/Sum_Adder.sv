`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2019 02:14:10 PM
// Design Name: 
// Module Name: Sum_Adder
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


module Sum_Adder(
    input  logic a,
    input  logic b,
    output logic [1:0] carry_sum_1,
    output logic [1:0] carry_sum_2   
    );
    
    Half_Adder HA(.a(a), .b(b), .sum(carry_sum_1[0]), .cout(carry_sum_1[1]));
    Full_Adder FA(.a(a), .b(b), .sum(carry_sum_2[0]), .cout(carry_sum_2[1]), .cin(1'b1));
endmodule
