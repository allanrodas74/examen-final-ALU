module top_alu_fpga (
    input [7:0] sw,          // Switches 0-7 para A
    input [15:8] swb,        // Switches 8-15 para B
    input btnC, btnU, btnD,  // Botones para ALU_Sel
    output [7:0] led,        // LEDs para resultado
    output led_zero,         // LED para Zero
    output led_carry         // LED para Cout
);
    // Selección de operación
    wire [2:0] ALU_Sel = {btnC, btnU, btnD};
    
    // Conexión a la ALU
    wire [7:0] ALU_Result;
    wire Zero, Cout;
    
    ALU_8bit alu (
        .A(sw),
        .B(swb),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Result),
        .Zero(Zero),
        .Cout(Cout)
    );
    
    // Asignación de salidas
    assign led = ALU_Result;
    assign led_zero = Zero;
    assign led_carry = Cout;
endmodule
