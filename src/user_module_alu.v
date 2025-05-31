`default_nettype none

module user_module_alu (
    input  [7:0] ui_in,    // Operando A y selector de operación
    input  [7:0] uio_in,   // Operando B
    output [7:0] uo_out,   // Resultado
    output [7:0] uio_out,  // No usado
    output [7:0] uio_oe,   // Configuración I/O
    input        ena,      // Habilitación
    input        clk,      // Reloj
    input        rst_n     // Reset
);
    // Conexión a la ALU
    wire [7:0] alu_result;
    wire zero, cout;
    
    ALU_8bit alu_inst (
        .A(ui_in),
        .B(uio_in),
        .ALU_Sel(ui_in[2:0]), // Usamos los 3 bits bajos de ui_in como selector
        .ALU_Out(alu_result),
        .Zero(zero),
        .Cout(cout)
    );
    
    // Asignación de salidas
    assign uo_out = alu_result;
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;  // Todos los IOs como entradas
    
    // Señales no usadas
    wire _unused = &{ena, clk, rst_n, zero, cout};
endmodule

module ALU_8bit (
    input [7:0] A, B,
    input [2:0] ALU_Sel,
    output reg [7:0] ALU_Out,
    output Zero,
    output Cout
);
    wire [7:0] sum, diff;
    wire cout_sum, cout_diff;
    
    PrefixAdder8 adder_sum (
        .A(A),
        .B(B),
        .Sum(sum),
        .Cout(cout_sum)
    );
    
    PrefixAdder8 adder_diff (
        .A(A),
        .B(~B),
        .Sum(diff),
        .Cout(cout_diff)
    );
    
    assign Zero = (ALU_Out == 8'b0);
    
    always @(*) begin
        case(ALU_Sel)
            3'b000: begin ALU_Out = sum; Cout = cout_sum; end
            3'b001: begin ALU_Out = diff; Cout = cout_diff; end
            3'b010: begin ALU_Out = A & B; Cout = 0; end
            3'b011: begin ALU_Out = A | B; Cout = 0; end
            3'b100: begin ALU_Out = A ^ B; Cout = 0; end
            3'b101: begin ALU_Out = A << 1; Cout = 0; end
            3'b110: begin ALU_Out = A >> 1; Cout = 0; end
            3'b111: begin ALU_Out = (A < B) ? 8'd1 : 8'd0; Cout = 0; end
            default: begin ALU_Out = 8'b0; Cout = 0; end
        endcase
    end
endmodule

`default_nettype wire
