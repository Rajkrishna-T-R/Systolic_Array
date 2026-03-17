`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 12:58:57
// Design Name: 
// Module Name: BRAM_tb
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


module BRAM_tb;

    // Parameters
    parameter DATA_WIDTH = 32;
    parameter DIMS = 2; // 2x2 matrix context (2 locations per bank)
    parameter ADDR_WIDTH = $clog2(DIMS);

    // Inputs
    reg clk;
    reg RST;
    reg write;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;

    // Output
    wire [DATA_WIDTH-1:0] data_out;

    // Instantiate UUT
    BRAM_V1 #(
        .data_in_width(DATA_WIDTH),
        .dims(DIMS)
    ) uut (
        .clk(clk),
        .RST(RST),
        .write(write),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz

    initial begin
        // Initialize
        RST = 1;
        write = 0;
        addr = 0;
        data_in = 0;

        #20;
        RST = 0;
        #10;

        // --- WRITE PHASE ---
        // Write to Location 0
        @(posedge clk);
        write = 1;
        addr = 0;
        data_in = 32'hAAAA_AAAA;
        
        // Write to Location 1
        @(posedge clk);
        write = 1;
        addr = 1;
        data_in = 32'hBBBB_BBBB;

        // --- READ PHASE ---
        @(posedge clk);
        write = 0;
        addr = 0; // Request data from Addr 0
        
        @(posedge clk);
        $display("Data at Addr 0: %h", data_out);
        addr = 1; // Request data from Addr 1

        @(posedge clk);
        $display("Data at Addr 1: %h", data_out);

        #20;
        $stop;
    end

endmodule