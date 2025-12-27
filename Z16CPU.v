module Z16CPU(
    input wire i_clk,
    input wire i_rst
);
    
    reg [15:0] r_pc;
    wire [15:0] w_instr;

    always @(posedge i_clk) begin
        if (i_rst) begin
            r_pc <= 16'h0000;
        end else begin
            r_pc <= r_pc + 16'h0002;
        end
    end

    

    Z16InstrMem InstrMem(
        .i_addr(r_pc),
        .o_instr(w_instr)
    );
    
    Z16DataMem DataMem(
        .i_clk(),
        .i_addr(),
        .i_we(),
        .i_data(),
        .o_data()
    );
endmodule
