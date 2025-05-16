`timescale 1ns / 1ps

module timsort8_tb;

    // Inputs
    reg clk;
    reg rst;
    reg start;
    reg [31:0] in0, in1, in2, in3, in4, in5, in6, in7;

    // Outputs
    wire done;
    wire [31:0] out0, out1, out2, out3, out4, out5, out6, out7;

    // Instantiate the Unit Under Test (UUT)
    timsort8 uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        .done(done),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .out4(out4),
        .out5(out5),
        .out6(out6),
        .out7(out7)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        start = 0;
        in0 = 32'd56;
        in1 = 32'd12;
        in2 = 32'd89;
        in3 = 32'd33;
        in4 = 32'd7;
        in5 = 32'd98;
        in6 = 32'd45;
        in7 = 32'd21;

        // Reset pulse
        #10;
        rst = 0;

        // Start sorting
        #10;
        start = 1;
        #10;
        start = 0;

        // Wait for sorting to complete
        wait (done == 1);

        // Display sorted output
        #10;
        $display("Sorted Output:");
        $display("%d", out0);
        $display("%d", out1);
        $display("%d", out2);
        $display("%d", out3);
        $display("%d", out4);
        $display("%d", out5);
        $display("%d", out6);
        $display("%d", out7);

        #10;
        $finish;
    end

endmodule
