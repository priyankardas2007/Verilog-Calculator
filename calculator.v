module calculator (
    input  [3:0] A,
    input  [3:0] B,
    input  [3:0] opcode,

    output reg [7:0] result,
    output reg       carry,
    output reg       error
);

    reg [4:0] temp;

    always @(*) begin

        // Default values
        result = 8'd0;
        carry  = 1'b0;
        error  = 1'b0;
        temp   = 5'd0;

        case (opcode)
            4'b0000: begin // ADDITION
                temp = {1'b0, A} + {1'b0, B};
                result[3:0] = temp[3:0];
                carry = temp[4];
            end

            4'b0001: begin // SUBTRACTION
                result[3:0] = A - B;
                carry = (A < B);
            end

            4'b0010:
                result = A * B; // MULTIPLICATION


            4'b0011: begin // DIVISION
                if (B != 0)
                    result = A / B;
                else
                    error = 1'b1;
            end

            4'b0100: begin // MODULUS
                if (B != 0)
                    result = A % B;
                else
                    error = 1'b1;
            end
            4'b0101:
                result[3:0] = A & B; // AND

            4'b0110:
                result[3:0] = A | B; // OR

            4'b0111:
                result[3:0] = A ^ B; // XOR


            4'b1000:
                result[3:0] = ~A; // not gate 


            4'b1001:
                result[3:0] = ~(A & B); // NAND


            4'b1010:
                result[3:0] = ~(A | B);// NOR


            4'b1011:
                result[3:0] = ~(A ^ B); //XNOR


            4'b1100:
                result = A << B;// LEFT shift 


            4'b1101:
                result[3:0] = A >> B; // Right shift 


            4'b1110: begin // compare 

                if (A > B)
                    result = 8'd1;
                else if (A < B)
                    result = 8'd2;
                else
                    result = 8'd0;

            end

            4'b1111: /// invalid 
                error = 1'b1;

            default:
                error = 1'b1;

        endcase
    end

endmodule