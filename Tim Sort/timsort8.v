module timsort8 (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    input wire [31:0] in4,
    input wire [31:0] in5,
    input wire [31:0] in6,
    input wire [31:0] in7,
    output reg done,
    output reg [31:0] out0,
    output reg [31:0] out1,
    output reg [31:0] out2,
    output reg [31:0] out3,
    output reg [31:0] out4,
    output reg [31:0] out5,
    output reg [31:0] out6,
    output reg [31:0] out7
);

    // Internal storage
    reg [31:0] arr[0:7];
    reg [3:0] i, j;
    reg [3:0] state;
    reg [31:0] key;

    localparam IDLE  = 0,
               LOAD  = 1,
               ISORT_LOAD = 2,
               ISORT_SHIFT = 3,
               ISORT_INSERT = 4,
               DONE  = 5;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) state <= LOAD;
                end

                LOAD: begin
                    arr[0] <= in0;
                    arr[1] <= in1;
                    arr[2] <= in2;
                    arr[3] <= in3;
                    arr[4] <= in4;
                    arr[5] <= in5;
                    arr[6] <= in6;
                    arr[7] <= in7;
                    i <= 1;
                    state <= ISORT_LOAD;
                end

                ISORT_LOAD: begin
                    if (i < 8) begin
                        key <= arr[i];
                        j <= i;
                        state <= ISORT_SHIFT;
                    end else begin
                        state <= DONE;
                    end
                end

                ISORT_SHIFT: begin
                    if (j > 0 && arr[j-1] > key) begin
                        arr[j] <= arr[j-1];
                        j <= j - 1;
                    end else begin
                        state <= ISORT_INSERT;
                    end
                end

                ISORT_INSERT: begin
                    arr[j] <= key;
                    i <= i + 1;
                    state <= ISORT_LOAD;
                end

                DONE: begin
                    out0 <= arr[0];
                    out1 <= arr[1];
                    out2 <= arr[2];
                    out3 <= arr[3];
                    out4 <= arr[4];
                    out5 <= arr[5];
                    out6 <= arr[6];
                    out7 <= arr[7];
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule


//module timsort8 (
//    input wire clk,
//    input wire rst,
//    input wire start,
//    input wire [31:0] in0,
//    input wire [31:0] in1,
//    input wire [31:0] in2,
//    input wire [31:0] in3,
//    input wire [31:0] in4,
//    input wire [31:0] in5,
//    input wire [31:0] in6,
//    input wire [31:0] in7,
//    output reg done,
//    output reg [31:0] out0,
//    output reg [31:0] out1,
//    output reg [31:0] out2,
//    output reg [31:0] out3,
//    output reg [31:0] out4,
//    output reg [31:0] out5,
//    output reg [31:0] out6,
//    output reg [31:0] out7
//);

//    // Internal registers
//    reg [31:0] arr [0:7];
//    integer i, j;
//    reg [31:0] key;
//    reg [3:0] state;

//    localparam IDLE  = 4'd0,
//               LOAD  = 4'd1,
//               ISORT = 4'd2,
//               DONE  = 4'd3;

//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//            state <= IDLE;
//            done <= 0;
//        end else begin
//            case (state)
//                IDLE: begin
//                    done <= 0;
//                    if (start)
//                        state <= LOAD;
//                end

//                LOAD: begin
//                    // Load input values
//                    arr[0] <= in0;
//                    arr[1] <= in1;
//                    arr[2] <= in2;
//                    arr[3] <= in3;
//                    arr[4] <= in4;
//                    arr[5] <= in5;
//                    arr[6] <= in6;
//                    arr[7] <= in7;
//                    i <= 1;
//                    state <= ISORT;
//                end

//                ISORT: begin
//                    if (i < 8) begin
//                        key = arr[i];
//                        j = i - 1;
//                        while (j >= 0 && arr[j] > key) begin
//                            arr[j+1] = arr[j];
//                            j = j - 1;
//                        end
//                        arr[j+1] = key;
//                        i = i + 1;
//                    end else begin
//                        state <= DONE;
//                    end
//                end

//                DONE: begin
//                    // Output sorted values
//                    out0 <= arr[0];
//                    out1 <= arr[1];
//                    out2 <= arr[2];
//                    out3 <= arr[3];
//                    out4 <= arr[4];
//                    out5 <= arr[5];
//                    out6 <= arr[6];
//                    out7 <= arr[7];
//                    done <= 1;
//                    state <= IDLE;
//                end

//            endcase
//        end
//    end

//endmodule
