`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 23:23:27
// Design Name: 
// Module Name: TB_sysA
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


module TB_sysA;

    parameter DATA_WIDTH = 32;
    parameter DIMS = 3;
    
    reg clk;
    reg rst_bar;
    reg start;
    
    // Matrix storage buffers from memory files 
    // Store matrix in row major form
    reg [DATA_WIDTH-1:0] mem_A [0:DIMS-1][0:DIMS-1]; // [row][col]
    reg [DATA_WIDTH-1:0] mem_B [0:DIMS-1][0:DIMS-1]; // [row][col]
    
    // Systolic array ports
    reg [DIMS*DATA_WIDTH-1:0] West_in;
    reg [DIMS*DATA_WIDTH-1:0] North_in;
    wire [DIMS*DATA_WIDTH-1:0] South_out, East_out;
    wire [(DIMS*DIMS*(2*DATA_WIDTH))-1:0] Result_out;

    // Pulse for pumbing the data 
    integer pulse;

    // Top_Array
    Top_Array #(.data_width(DATA_WIDTH), .dims(DIMS)) dut (
        .clk(clk),
        .rst_bar(rst_bar),
        .North_in(North_in),
        .West_in(West_in),
        .South_out(South_out),
        .East_out(East_out),
        .Result_out(Result_out)
    );

    // Clock signal
    always #5 clk = ~clk;
    
    
    integer j,k;
  
    initial begin
        // 1. Load data from files into internal simulation buffers
        // We use a temporary flat array because $readmemh doesn't like 2D arrays directly
        begin : loading_logic
            reg [DATA_WIDTH-1:0] temp_A [0:DIMS*DIMS-1];
            reg [DATA_WIDTH-1:0] temp_B [0:DIMS*DIMS-1];
            $readmemh("matrix_a.mem", temp_A);
            $readmemh("matrix_b.mem", temp_B);
            
            
            for(j=0;j<=DIMS-1;j=j+1)
                begin
                    for(k=0;k<=DIMS-1;k=k+1)
                        begin
                            mem_A[j][k]=temp_A[j*DIMS+k];
                            mem_B[j][k]=temp_B[j*DIMS+k]; 
                        end
                    end
                    
                end
            
 
        // 2. Reset Sequence
        clk = 0; rst_bar = 0; start = 0; pulse = 0;
        West_in = 0; North_in = 0;
        #20 rst_bar = 1; 
        #10 start = 1;
        
        if(pulse>2*DIMS)
            $finish;
    end


integer row;
integer col; 
// ROW and COLUMN 

 
    
    
    always@(posedge clk)
        begin
            if(rst_bar==1'b0)
                begin
                    pulse<=0;
                    West_in<=0;
                    North_in<=0;
                end
            else if(start)
                begin
                    pulse<=pulse+1;
                    
           // Input from the left side
           
           for(row=0;row<=DIMS-1;row=row+1)
                begin
                    if(pulse>=row && pulse<row+DIMS)
                         begin  
                            West_in[row*DATA_WIDTH+:DATA_WIDTH]<=mem_A[row][pulse-row];
                         end
                    else
                        begin
                            West_in[row*DATA_WIDTH+:DATA_WIDTH]<=0;
                        end
                        
                end 
                
          // Input from top side
          
          for(col=0;col<=DIMS-1;col=col+1)
                begin
                    if(pulse>=col && pulse<col+DIMS)
                         begin  
                            North_in[col*DATA_WIDTH+:DATA_WIDTH]<=mem_B[pulse-col][col];
                         end
                    else
                        begin
                            North_in[col*DATA_WIDTH+:DATA_WIDTH]<=0;
                        end
                        
                end   
                
          end
       end                         
endmodule
