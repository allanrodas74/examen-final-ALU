`default_nettype none

module tt_top_alu (
    input  [7:0] ui_in,
    output [7:0] uo_out,
    input  [7:0] uio_in,
    output [7:0] uio_out,
    output [7:0] uio_oe,
    input        ena,
    input        clk,
    input        rst_n
);
    user_module_alu alu_inst (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule

`default_nettype wire
