`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2026 23:26:32
// Design Name: 
// Module Name: tb_Top_array
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


module tb_Top_array;

parameter data_width = 32;
parameter dims = 4;

reg clk;
reg rst_bar;

reg  [dims*data_width-1:0] North_in;
reg  [dims*data_width-1:0] West_in;

wire [dims*data_width-1:0] South_out;
wire [dims*data_width-1:0] East_out;
wire [(dims*dims*(2*data_width))-1:0] Result_out;

// -------------------------------------------------
// DUT
// -------------------------------------------------
Top_Array #(
    .data_width(data_width),
    .dims(dims)
) DUT (
    .North_in(North_in),
    .West_in(West_in),
    .rst_bar(rst_bar),
    .clk(clk),
    .South_out(South_out),
    .East_out(East_out),
    .Result_out(Result_out)
);

// -------------------------------------------------
// Clock Generation (100 MHz)
// -------------------------------------------------
always #5 clk = ~clk;





wire [63:0] R [0:dims*dims-1];

genvar i;
generate
    for (i = 0; i < dims*dims; i = i + 1) begin : RESULT_SPLIT
        assign R[i] = Result_out[i*64 +: 64];
    end
endgenerate


initial begin

    clk = 0;
    rst_bar = 0;
    North_in = 0;
    West_in  = 0;

    // Reset sequence
    repeat(7) @(posedge clk);
    rst_bar = 1;

    //------------------------------------------
    // Matrix A
    // 7   5
    // 8   6
    //
    // Matrix B
    // 2   1
    // 4   3
    //------------------------------------------

    // ---------------- Cycle 1 ----------------
    // A00 , 0
    // B00 , 0
    @(posedge clk);
    North_in[0*32 +: 32] = 13;   // A00
    North_in[1*32 +: 32] = 0;
    North_in[2*32 +: 32] = 0;
    North_in[3*32 +: 32] = 0;
    

    West_in[0*32 +: 32]  = 4;   // B00
    West_in[1*32 +: 32]  = 0;
    West_in[2*32 +: 32]  = 0;
    West_in[3*32 +: 32]  = 0;

    // ---------------- Cycle 2 ----------------
    // A10 , A01
    // B01 , B10
    @(posedge clk);
    North_in[0*32 +: 32] = 9;   // A10
    North_in[1*32 +: 32] = 14;   // A01
    North_in[2*32 +: 32] = 0;
    North_in[3*32 +: 32] = 0;
    
    West_in[0*32 +: 32]  = 3;   // B01
    West_in[1*32 +: 32]  = 8;   // B10
    West_in[2*32 +: 32]  = 0;
    West_in[3*32 +: 32]  = 0;
    
    
    // ---------------- Cycle 3 ----------------
    // A10 , A01
    // B01 , B10
    @(posedge clk);
    North_in[0*32 +: 32] = 5;   // A10
    North_in[1*32 +: 32] = 10;   // A01
    North_in[2*32 +: 32] = 15;
    North_in[3*32 +: 32] = 0;
    
    West_in[0*32 +: 32]  = 2;   // B01
    West_in[1*32 +: 32]  = 7;   // B10
    West_in[2*32 +: 32]  = 12;
    West_in[3*32 +: 32]  = 0;
    
    
    // ---------------- Cycle 4 ----------------
    // A10 , A01
    // B01 , B10
    @(posedge clk);
    North_in[0*32 +: 32] = 1;   // A10
    North_in[1*32 +: 32] = 6;   // A01
    North_in[2*32 +: 32] = 11;
    North_in[3*32 +: 32] = 16;
    
    West_in[0*32 +: 32]  = 1;   // B01
    West_in[1*32 +: 32]  = 6;   // B10
    West_in[2*32 +: 32]  = 11;
    West_in[3*32 +: 32]  = 16;
    
    // ---------------- Cycle 5 ----------------
    // A10 , A01
    // B01 , B10
    @(posedge clk);
    North_in[0*32 +: 32] = 0;   // A10
    North_in[1*32 +: 32] = 2;   // A01
    North_in[2*32 +: 32] = 7;
    North_in[3*32 +: 32] = 12;
    
    West_in[0*32 +: 32]  = 0;   // B01
    West_in[1*32 +: 32]  = 5;   // B10
    West_in[2*32 +: 32]  = 10;
    West_in[3*32 +: 32]  = 15;

    // ---------------- Cycle 6 ----------------
    // A10 , A01
    // B01 , B10
    @(posedge clk);
    North_in[0*32 +: 32] = 0;   // A10
    North_in[1*32 +: 32] = 0;   // A01
    North_in[2*32 +: 32] = 3;
    North_in[3*32 +: 32] = 8;
    
    West_in[0*32 +: 32]  = 0;   // B01
    West_in[1*32 +: 32]  = 0;   // B10
    West_in[2*32 +: 32]  = 9;
    West_in[3*32 +: 32]  = 14;
    
    // ---------------- Cycle 7 ----------------
    // A10 , A01
    // B01 , B10
    @(posedge clk);
    North_in[0*32 +: 32] = 0;   // A10
    North_in[1*32 +: 32] = 0;   // A01
    North_in[2*32 +: 32] = 0;
    North_in[3*32 +: 32] = 4;
    
    West_in[0*32 +: 32]  = 0;   // B01
    West_in[1*32 +: 32]  = 0;   // B10
    West_in[2*32 +: 32]  = 0;
    West_in[3*32 +: 32]  = 13;
    
    // ---------------- Flush ----------------
    @(posedge clk);
    North_in = 0;
    West_in  = 0;

    repeat(32) @(posedge clk);

    $finish;
end



endmodule
