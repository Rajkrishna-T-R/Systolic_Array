`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 20:43:21
// Design Name: 
// Module Name: tb_Design1
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


module tb_Design1;

reg [31:0]in_west0,in_west1;
reg [31:0]in_north0,in_north1;



wire [63:0]result0,result1,result2,result3;
reg clk;
reg rst;
wire [31:0]out_east0,out_east1,out_south0,out_south1;

design_1_wrapper
   dut (.clk_0(clk),
    .in_north_0(in_north0),
    .in_north_2(in_north1),
    .in_west_0(in_west0),
    .in_west_1(in_west1),
    .out_east_0(out_east0),
    .out_east_1(out_east1),
    .out_south_0(out_south0),
    .out_south_1(out_south1),
    .result_0(result0),
    .result_1(result1),
    .result_2(result2),
    .result_3(result3),
    .rst_0(rst));



always #5 clk = ~clk;   // 100 MHz clock
initial begin
    // Initialize
    clk = 0;
    rst = 1;

    in_west0  = 0;
    in_west1  = 0;
    in_north0 = 0;
    in_north1 = 0;

    // Hold reset
    #20 rst = 0;
    #20 rst = 1;
    // Apply stimulus
    #10 in_west0  = 2;
        in_west1  = 0;
        in_north0 = 7;
        in_north1 = 0;
        
        
        
    #10 in_west0  = 1;
        in_west1  = 4;
        in_north0 = 5;
        in_north1 = 8;
        
        
    #10 in_west0  = 0;
        in_west1  = 3;
        in_north0 = 0;
        in_north1 = 6;
        
    
        
    

   $finish;
end


endmodule
