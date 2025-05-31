module user_module_alu (
    input  [7:0] io_in,
    output [7:0] io_out
);
    // Entradas
    wire [2:0] sel = io_in[7:5]; // Operación
    wire [2:0] a   = io_in[4:2]; // Operando A (3 bits)
    wire [1:0] b   = io_in[1:0]; // Operando B (2 bits)

    reg [7:0] result;

    always @(*) begin
        case (sel)
            3'b000: result = a + b;           // Suma
            3'b001: result = a - b;           // Resta
            3'b010: result = a & b;           // AND
            3'b011: result = a | b;           // OR
            3'b100: result = a ^ b;           // XOR
            3'b101: result = a << b;          // Shift left
            3'b110: result = a >> b;          // Shift right
            3'b111: result = (a < b) ? 8'b1 : 8'b0; // Comparación
            default: result = 8'b0;
        endcase
    end

    assign io_out = result;

endmodule
