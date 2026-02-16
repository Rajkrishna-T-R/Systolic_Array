
module design_1_wrapper
   (clk_0,
    in_north_0,
    in_north_2,
    in_west_0,
    in_west_1,
    out_east_0,
    out_east_1,
    out_south_0,
    out_south_1,
    result_0,
    result_1,
    result_2,
    result_3,
    rst_0);
  input clk_0;
  input [31:0]in_north_0;
  input [31:0]in_north_2;
  input [31:0]in_west_0;
  input [31:0]in_west_1;
  output [31:0]out_east_0;
  output [31:0]out_east_1;
  output [31:0]out_south_0;
  output [31:0]out_south_1;
  output [63:0]result_0;
  output [63:0]result_1;
  output [63:0]result_2;
  output [63:0]result_3;
  input rst_0;

  wire clk_0;
  wire [31:0]in_north_0;
  wire [31:0]in_north_2;
  wire [31:0]in_west_0;
  wire [31:0]in_west_1;
  wire [31:0]out_east_0;
  wire [31:0]out_east_1;
  wire [31:0]out_south_0;
  wire [31:0]out_south_1;
  wire [63:0]result_0;
  wire [63:0]result_1;
  wire [63:0]result_2;
  wire [63:0]result_3;
  wire rst_0;

  design_1 design_1_i
       (.clk_0(clk_0),
        .in_north_0(in_north_0),
        .in_north_2(in_north_2),
        .in_west_0(in_west_0),
        .in_west_1(in_west_1),
        .out_east_0(out_east_0),
        .out_east_1(out_east_1),
        .out_south_0(out_south_0),
        .out_south_1(out_south_1),
        .result_0(result_0),
        .result_1(result_1),
        .result_2(result_2),
        .result_3(result_3),
        .rst_0(rst_0));
endmodule
