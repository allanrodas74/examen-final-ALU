module ALU_8bit (
    input [7:0] A, B,         // Operandos de 8 bits
    input [2:0] ALU_Sel,      // Selector de operación
    output reg [7:0] ALU_Out, // Resultado
    output Zero,              // Bandera Zero
    output Cout               // Acarreo para suma/resta
);
    // Conexiones para operaciones aritméticas
    wire [7:0] sum, diff;
    wire cout_sum, cout_diff;
    
    // Sumador
    PrefixAdder8 adder_sum (
        .A(A),
        .B(B),
        .Sum(sum),
        .Cout(cout_sum)
    );
    
    // Restador (A - B = A + ~B + 1)
    PrefixAdder8 adder_diff (
        .A(A),
        .B(~B),
        .Sum(diff),
        .Cout(cout_diff)
    );
    
    // Bandera Zero
    assign Zero = (ALU_Out == 8'b0);
    
    // Selección de operación
    always @(*) begin
        case(ALU_Sel)
            3'b000: begin ALU_Out = sum; Cout = cout_sum; end       // Suma
            3'b001: begin ALU_Out = diff; Cout = cout_diff; end     // Resta
            3'b010: begin ALU_Out = A & B; Cout = 0; end           // AND
            3'b011: begin ALU_Out = A | B; Cout = 0; end           // OR
            3'b100: begin ALU_Out = A ^ B; Cout = 0; end           // XOR
            3'b101: begin ALU_Out = A << 1; Cout = 0; end          // Shift left
            3'b110: begin ALU_Out = A >> 1; Cout = 0; end           // Shift right
            3'b111: begin ALU_Out = (A < B) ? 8'd1 : 8'd0; Cout = 0; end // Comparación
            default: begin ALU_Out = 8'b0; Cout = 0; end
        endcase
    end
endmodule

endmodule
