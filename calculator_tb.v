
`timescale 1ns/1ps

module calculator_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] opcode;

    // Outputs
    wire [7:0] result;
    wire       carry;
    wire       error;

    // Instantiate calculator
    calculator uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .carry(carry),
        .error(error)
    );

    // Test
    initial begin
        $dumpfile("calculator.vcd");
        $dumpvars(0, calculator_tb);
        $display("==============================================");
        $display("        4-BIT CALCULATOR TESTBENCH");
        $display("==============================================");

        // -------------------------
        // Addition
        // 7 + 5 = 12
        // -------------------------
        A = 4'd7;
        B = 4'd5;
        opcode = 3'b000;
        #10;

        $display("ADD: %d + %d = %d | Carry = %b",
                 A, B, result, carry);

        // -------------------------
        // Subtraction
        // 9 - 4 = 5
        // -------------------------
        A = 4'd9;
        B = 4'd4;
        opcode = 3'b001;
        #10;

        $display("SUB: %d - %d = %d | Borrow = %b",
                 A, B, result, carry);

        // -------------------------
        // Subtraction with borrow
        // 4 - 9
        // -------------------------
        A = 4'd4;
        B = 4'd9;
        opcode = 3'b001;
        #10;

        $display("SUB: %d - %d = %d | Borrow = %b",
                 A, B, result, carry);

        // -------------------------
        // Multiplication
        // 7 * 5 = 35
        // -------------------------
        A = 4'd7;
        B = 4'd5;
        opcode = 3'b010;
        #10;

        $display("MUL: %d * %d = %d",
                 A, B, result);

        // -------------------------
        // AND
        // -------------------------
        A = 4'b1100;
        B = 4'b1010;
        opcode = 3'b011;
        #10;

        $display("AND: %b & %b = %b",
                 A, B, result[3:0]);

        // -------------------------
        // OR
        // -------------------------
        opcode = 3'b100;
        #10;

        $display("OR : %b | %b = %b",
                 A, B, result[3:0]);

        // -------------------------
        // XOR
        // -------------------------
        opcode = 3'b101;
        #10;

        $display("XOR: %b ^ %b = %b",
                 A, B, result[3:0]);

        // -------------------------
        // NOT
        // -------------------------
        A = 4'b1010;
        B = 4'b0000;
        opcode = 3'b110;
        #10;

        $display("NOT: ~%b = %b",
                 A, result[3:0]);

        // -------------------------
        // Invalid operation
        // -------------------------
        opcode = 3'b111;
        #10;

        $display("INVALID: opcode = %b | Error = %b",
                 opcode, error);

        $display("==============================================");

        $finish;
    end

endmodule