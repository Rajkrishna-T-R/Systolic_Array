`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2026 18:34:19
// Design Name: 
// Module Name: BRAM_array_V1
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


module BRAM_array_V1#(parameter data_in_width=32,parameter dims=4)(
                        
                        input wire clk,              // Master clock
                        input wire RST,              // RST signal 
                        input wire [dims-1:0]WR_en,  // Write enable signal for each ROW
                        input wire [($clog2(dims)*dims)-1:0] addr_ROW, // array needed revisit 
                        input wire [(data_in_width*dims)-1:0] data_in_ROW, // Data_input Row wise
                        output wire [(data_in_width*dims)-1:0] data_out_ROW // Data_output Row_wise

    );
    localparam inaddr_width=$clog2(dims); // input address line 
    localparam indata_width=dims*data_in_width; // input data width
    localparam outdata_width=dims*data_in_width;// output data width
    
    
    
    genvar i;    
   
    generate 

            for(i=0;i<dims;i=i+1) begin:row_banks
                BRAM_V1#(.data_in_width(data_in_width),
                         .dims(dims))
                         
                ROW_inst(.clk(clk),// clk
                         .RST(RST),// RST
                .data_in(data_in_ROW[i*data_in_width+:data_in_width]),
                // data input
                .data_out(data_out_ROW[i*data_in_width+:data_in_width]),
                // data output
                .addr(addr_ROW[i*inaddr_width+:inaddr_width]),
                // address line bundle for each row 
                .write(WR_en[i])
                // write enable signal for each ROW
                );
            end
      endgenerate
     
endmodule
