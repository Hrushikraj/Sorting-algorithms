`timescale 1ns / 1ps

module ins_tb;
    // Inputs
    reg clk;
    reg [31:0] in1, in2, in3, in4, in5, in6, in7, in8;
    
    // Outputs
    wire [31:0] out1, out2, out3, out4, out5, out6, out7, out8;
    
    // Instantiate the Unit Under Test (UUT)
    ins uut (
        .clk(clk),
        .in1(in1), .in2(in2), .in3(in3), .in4(in4),
        .in5(in5), .in6(in6), .in7(in7), .in8(in8),
        .out1(out1), .out2(out2), .out3(out3), .out4(out4),
        .out5(out5), .out6(out6), .out7(out7), .out8(out8)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end
    
    // Test vectors
    initial begin
        // Initialize inputs
        in1 = 0; in2 = 0; in3 = 0; in4 = 0;
        in5 = 0; in6 = 0; in7 = 0; in8 = 0;
        
        // Wait for global reset
        #100;
        
        // Test Case 1: Already sorted (descending)
        in1 = 290; in2 = 255; in3 = 256; in4 = 270;
        in5 = 260;  in6 = 258; in7 = 257; in8 = 300;
        #20;
        
        // Test Case 2: Reverse sorted (ascending)
        in1 = 10; in2 = 20; in3 = 30; in4 = 40;
        in5 = 50; in6 = 60; in7 = 70; in8 = 80;
        #20;
        
        // Test Case 3: Random values
        in1 = 42; in2 = 17; in3 = 93; in4 = 25;
        in5 = 51; in6 = 38; in7 = 64; in8 = 70;
        #20;
        
        // Test Case 4: Duplicate values
        in1 = 50; in2 = 50; in3 = 30; in4 = 70;
        in5 = 30; in6 = 70; in7 = 50; in8 = 30;
        #20;
        
        // Test Case 5: All same values
        in1 = 25; in2 = 25; in3 = 25; in4 = 25;
        in5 = 25; in6 = 25; in7 = 25; in8 = 25;
        #20;
        
        // Test Case 6: Edge values (0 and 255)
        in1 = 0;   in2 = 255; in3 = 128; in4 = 64;
        in5 = 192; in6 = 32;  in7 = 224; in8 = 16;
        #20;
        
        // End simulation
        #20;
        $finish;
    end
    
    // Monitor results
    initial begin
        $monitor("Time=%0t | Inputs: %d %d %d %d %d %d %d %d | Outputs: %d %d %d %d %d %d %d %d",
                 $time,
                 in1, in2, in3, in4, in5, in6, in7, in8,
                 out1, out2, out3, out4, out5, out6, out7, out8);
                 
        // If using a waveform viewer, uncomment below
        // $dumpfile("ins_tb.vcd");
        // $dumpvars(0, ins_tb);
    end
    
    // Verification
    always @(posedge clk) begin
        // Wait 3 clock cycles after inputs change to check outputs (2 clock cycles for processing)
        #30;
        if (out1 < out2 || out2 < out3 || out3 < out4 || out4 < out5 || out5 < out6 || out6 < out7 || out7 < out8)
            $display("ERROR: Output not sorted in descending order at time %0t", $time);
            
        // Verify all input values appear in output (simplistic check)
        if (in1 != out1 && in1 != out2 && in1 != out3 && in1 != out4 && in1 != out5 && in1 != out6 && in1 != out7 && in1 != out8)
            $display("ERROR: Input value %d missing from outputs at time %0t", in1, $time);
    end
    
endmodule