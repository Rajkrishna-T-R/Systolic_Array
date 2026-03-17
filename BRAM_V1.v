`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 17:57:44
// Design Name: 
// Module Name: BRAM_V1
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


module BRAM_V1#(parameter data_in_width=32,parameter dims=4)(
            input wire clk,
            input wire RST,
            input wire write,
            input wire[$clog2(dims)-1:0]addr,
            input wire [data_in_width-1:0]data_in,
           output wire [data_in_width-1:0]data_out
           
    );
    (* ram_style="block" *)
    reg [data_in_width-1:0]memory[dims-1:0];
    
    
    
    reg [data_in_width-1:0]outreg;
    
    
    // To avoid 'X' states in simulation reset initially
    integer k;
    initial begin
        for (k = 0; k < dims; k = k + 1) begin
            memory[k] = {data_in_width{1'b0}};
        end
        outreg = {data_in_width{1'b0}};
    end
    
    always@(posedge clk)
        begin
            if(write==1'b1) 
                begin
                    memory[addr]<=data_in;
                end
           
                    outreg<=memory[addr];
            
                         
            
            
        end
     assign data_out=outreg;
     
            
            
endmodule
