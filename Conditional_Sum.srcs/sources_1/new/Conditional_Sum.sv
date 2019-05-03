    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 03/26/2019 09:50:18 AM
    // Design Name: 
    // Module Name: Conditional_Sum
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
    
    
module Conditional_Sum #(parameter longint Bits = 8, Logbits = $clog2(Bits))
(
  	input logic clk, 
    input  logic [Bits - 1:0] a,
    input  logic [Bits - 1:0] b,
    input  logic cin, mode,
    output logic cout,
    output logic [Bits - 1:0] sum
);
        
        
    //Wires
    logic [4 * Bits - 1 : 0]intWires[Logbits : 0];
    logic [Bits : 0] out;
  	logic [Bits - 1:0]num_b;
  	logic cin_b, cout_b;
  
  	always_comb begin
      	if(mode)begin
        	num_b = ~b;
        	cin_b = 1'b1;
        	cout  = ~cout_b; 
        end
        else begin
        	num_b = b;
          	cin_b = cin;
          	cout  = cout_b;
        end 
	end       
 
  	assert property(@(posedge(clk))  (mode == 0 |-> a + b + cin == sum + longint'(2)**Bits * cout)) 
		else begin
          	$error("Addition is incorrect");
        	$info(a);
       		$info(num_b);
        	$info(cin_b);
        	$info(sum);
          	$info(2**Bits * cout);
      	end  
    
	assert property(@(posedge(clk))  (mode == 1 |-> a - b == sum - longint'(2)**Bits * cout))
    	else begin
        	$error("Subtraction is incorrect");
          	$info("%d, %b", a, a);
          	$info("%d, %b", $signed(num_b + 1'b1), num_b + 1'b1);
          	$info("%d, %b", $signed(sum), sum);
          	$info(2**Bits * cout);	
          
        end  
             
    function int K(input int i);
            K = 2**($clog2(Bits) - i);
        endfunction
    
    genvar LVL, pair_LVL;
    generate  
            for(LVL = Logbits; LVL > 0; LVL--) begin  
                for(pair_LVL = 2**(LVL - 1) - 1; pair_LVL >= 0; pair_LVL--) begin
                
                    assign intWires[LVL - 1][2 * K(LVL) + pair_LVL * 2 * (2 * K(LVL) +1) : pair_LVL * 2 * (2 * K(LVL) + 1)] = {intWires[LVL][K(LVL) + pair_LVL * 4 * (K(LVL) + 1)] ? 
                           intWires[LVL][4 * K(LVL) + 3 + pair_LVL * 4 * (K(LVL) + 1) : 3 * K(LVL) + 3 + pair_LVL * 4 * (K(LVL) + 1)] : 
                           intWires[LVL][3 * K(LVL) + 2 + pair_LVL * 4 * (K(LVL) + 1) : 2 * K(LVL) + 2 + pair_LVL * 4 * (K(LVL) + 1)], 
                           intWires[LVL][K(LVL) - 1 + pair_LVL * 4 * (K(LVL) + 1) : pair_LVL * 4 * (K(LVL) + 1)]}; 
                           
                    assign intWires[LVL - 1][4 * K(LVL) + 1 + pair_LVL * 2 * (2 * K(LVL) +1) : 2 * K(LVL) + 1 + pair_LVL * 2 * (2 * K(LVL) + 1)] = {intWires[LVL][2 * K(LVL) + 1 + pair_LVL * 4 * (K(LVL) + 1)] ? 
                           intWires[LVL][4 * K(LVL) + 3 + pair_LVL * 4 * (K(LVL) + 1) : 3 * K(LVL) + 3 + pair_LVL * 4 * (K(LVL) + 1)] : 
                           intWires[LVL][3 * K(LVL) + 2 + pair_LVL * 4 * (K(LVL) + 1) : 2 * K(LVL) + 2 + pair_LVL * 4 * (K(LVL) + 1)], 
                           intWires[LVL][2 * K(LVL) + 0 + pair_LVL * 4 * (K(LVL) + 1) : 1 * K(LVL) + 1 + pair_LVL * 4 * (K(LVL) + 1)]};               
                end
            end
        endgenerate
        
    //Sum Block
    genvar i;
    generate 
  	      for(i = 0; i < Bits; i++) begin: Sum_Carry_Blocks
            Sum_Adder sum_carry(.a(a[i]), .b(num_b[i]), .carry_sum_1(intWires[Logbits][1 + 4 * i : 4 * i]), .carry_sum_2(intWires[Logbits][3 + 4 * i : 2 + 4 * i]));
        end   
    endgenerate 
       
  	assign out  = cin_b ? intWires[0][2 * Bits + 1 : Bits + 1] : intWires[0][Bits:0];
    assign sum  = out[Bits - 1 : 0];
    assign cout_b = out[Bits]; 
   
endmodule
