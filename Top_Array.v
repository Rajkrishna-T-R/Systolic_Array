`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2026 16:01:59
// Design Name: 
// Module Name: Top_Array
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


module Top_Array#(parameter data_width=32,parameter dims=2)(
    input wire [dims*data_width-1:0]North_in, // matrix input data line
    input wire [dims*data_width-1:0]West_in,  // matrix input data line
    
    input wire rst_bar,
    input wire clk,
    
    output wire [dims*data_width-1:0]South_out,
    output wire [dims*data_width-1:0]East_out,
    
    output wire [(dims*dims*(2*data_width))-1:0]Result_out // result line from each of the units

    );
    
    
    wire [data_width-1:0]North[0:dims][0:dims-1]; 
    // North need one extra for implementing the south end wire
    // This extra wire is needed the dimension number of times.
    // put the extra wire in the row loop
    wire [data_width-1:0]West[0:dims-1][0:dims];
    // West need one extra for implementing the East end wire
    // This extra wire is needed the dimension number of times.
    // put the extra wire in the Col loop
    wire [2*data_width-1:0]Result[0:dims-1][0:dims-1];
    // result data width is twice that of the input data line width
   genvar i,j;
   // MAU connection generate loop
   generate for(i=0;i<dims;i=i+1)begin:ROW_wise
                for(j=0;j<dims;j=j+1)begin:COL_wise
                       MAU #(.data_in_width(data_width))Unit
                                    (.in_west(West[i][j]),
                                     .in_north(North[i][j]),
                                     .clk(clk),
                                     .rst(rst_bar),
                                     .result(Result[i][j]),
                                     .out_east(West[i][j+1]),   
                                     // j+1 -> N th east_out need N+1 th j wire
                                     // dims means the last wire of west group 
                                            
                                     .out_south(North[i+1][j])
                                     // i+1 -> K th south need  K+1 th j i wire   
                                     //  dims means the last wire of north group
                                     ); 
                                     
                              assign Result_out[((i*dims+j)*(2*data_width))+:(2*data_width)]=Result[i][j];
                              // result of MAU unit at the ith row a j th colums get assigned to the wires (64 bit group)
                            end // Close COL
                        end // Close ROW
                     
         endgenerate
         
    // Wire connection generate loop    
     generate for(i=0;i<dims;i=i+1)begin:inter_wire
                assign North[0][i]=North_in[i*data_width+:data_width];
            // Top North wire connected with North_in output 
            // The 'i*data_width+:data_width' will connect the wires as group of data_width                 
                assign West[i][0]=West_in[i*data_width+:data_width];
            // Top West wire connected with West_in output 
            // The 'i*data_width+:data_width' will connect the wires as group of data_width
                
                   
                   
              assign South_out[i*data_width+:data_width]=North[dims][i];
              // [dims][i] last wire of each column
            
              assign East_out[i*data_width+:data_width]=West[i][dims];
              
              // [i][dims] last wire of each row
              
             
        
              
     end 
   endgenerate
    
    
endmodule
