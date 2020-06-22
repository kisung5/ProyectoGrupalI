module clock_divider_tb;

logic clk, clk_div;

clock_divider DUT(clk, clk_div);

initial begin
    clk = 0;
end

always
    #10 clk = ~clk;
      
endmodule // ClockDividerTest
