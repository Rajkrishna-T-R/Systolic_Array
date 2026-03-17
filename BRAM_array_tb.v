`timescale 1ns / 1ps

module BRAM_array_tb;

    parameter data_in_width = 32;
    parameter dims = 2;
    parameter addr_width = $clog2(dims); // This is 1
    
    reg clk;
    reg RST;
    reg [dims-1:0] WR_en;
    reg [(addr_width*dims)-1:0] addr_ROW;
    reg [(data_in_width*dims)-1:0] data_in_ROW;
    wire [(data_in_width*dims)-1:0] data_out_ROW;

    // Unflattened wires for easier viewing in waveform
    wire [31:0] row0_out = data_out_ROW[0+:32];
    wire [31:0] row1_out = data_out_ROW[32+:32];

    BRAM_array_V1 #(.data_in_width(data_in_width), .dims(dims)) uut (
        .clk(clk), .RST(RST), .WR_en(WR_en),
        .addr_ROW(addr_ROW), .data_in_ROW(data_in_ROW), .data_out_ROW(data_out_ROW)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize everything
        RST = 1; WR_en = 2'b00; addr_ROW = 0; data_in_ROW = 0;
        #20 RST = 0;

        // --- CORRECTED WRITE PHASE ---
        
        // Write a11 (Row 0, Addr 0)
        @(negedge clk);
        WR_en = 2'b01; 
        addr_ROW[0*addr_width +: addr_width] = 1'b0;
        data_in_ROW[0*32 +: 32] = 32'h00000011; 

        // Write a12 (Row 0, Addr 1)
        @(negedge clk);
        addr_ROW[0*addr_width +: addr_width] = 1'b1;
        data_in_ROW[0*32 +: 32] = 32'h00000012;

        // Write a21 (Row 1, Addr 0)
        @(negedge clk);
        WR_en = 2'b10;
        addr_ROW[1*addr_width +: addr_width] = 1'b0;
        data_in_ROW[1*32 +: 32] = 32'h00000021;

        // Write a22 (Row 1, Addr 1)
        @(negedge clk);
        addr_ROW[1*addr_width +: addr_width] = 1'b1;
        data_in_ROW[1*32 +: 32] = 32'h00000022;

        @(negedge clk);
        WR_en = 2'b00;
        data_in_ROW = 0;

       
        #20; 

        // Cycle 1: Request a12 from Row 0
        @(negedge clk);
        addr_ROW[0*addr_width +: addr_width] = 1'b1; 
        addr_ROW[1*addr_width +: addr_width] = 1'b1; // Row 1 idle or reading a21 early

        // Cycle 2: Request a11 (Row 0) and a22 (Row 1)
        @(negedge clk);
        addr_ROW[0*addr_width +: addr_width] = 1'b0; 
        addr_ROW[1*addr_width +: addr_width] = 1'b0; 

        // Cycle 3: Request a21 (Row 1)
      

        #25 $finish;
    end
    
endmodule