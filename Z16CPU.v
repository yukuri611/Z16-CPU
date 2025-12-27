module Z16CPU(
    input wire i_clk,
    input wire i_rst
);
    
    Z16InstrMem InstrMem(
        .i_addr(),
        .o_instr()
    );
    
    Z16DataMem DataMem(
        .i_clk(),
        .i_addr(),
        .i_we(),
        .i_data(),
        .o_data()
    );
endmodule
