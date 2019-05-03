`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 06:28:44 PM
// Design Name: 
// Module Name: Full_Adder
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


module Full_Adder(
    input logic  a,
    input logic  b,
    input logic  cin,
    output logic cout,
    output logic sum
    );
    
    //Wires
    logic cout_HA_1, cout_HA_2;
    logic sum_HA_1;
    
    assign cout = cout_HA_1 | cout_HA_2;
    
    //Instantiation
    Half_Adder HA_1(.a(a),        .b(b),   .cout(cout_HA_1),    .sum(sum_HA_1));
    Half_Adder HA_2(.a(sum_HA_1), .b(cin), .cout(cout_HA_2),    .sum(sum));
    
endmodule
