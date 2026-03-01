`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2026 19:34:38
// Design Name: 
// Module Name: MAU
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


module MAU #(parameter data_in_width=32)(
            input wire [data_in_width-1:0]in_west,
            input wire [data_in_width-1:0]in_north,
            input wire clk,
            input wire rst_bar,
            output reg [(2*data_in_width)-1:0]result,
            output reg [data_in_width-1:0]out_east,
            output reg [data_in_width-1:0]out_south
            
    );
    
    
    reg [63:0]acc;
    always@(posedge clk or negedge rst_bar)
        begin
            if(rst_bar==0)
                begin
                    result<=64'd0;
                    out_east<=32'd0;
                    out_south<=32'd0;
                    
                end
                
            else
                begin
                    out_east<=in_west;
                    out_south<=in_north;
                    result<=result+(in_west*in_north);
                end
        end
        
    
                    
    
    
    
endmodule
