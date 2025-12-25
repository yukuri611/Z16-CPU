module Z16RegisterFile(
    input wire i_clk,
    
    input wire[3:0] i_rs1_addr,
    output wire[15:0] o_rs1_data,
    
    input wire[3:0] i_rs2_addr,
    output wire[15:0] o_rs2_data,

    input wire[3:0] i_rd_addr,
    input wire i_rd_we,
    input wire[15:0] o_rd_data,
);


endmodule
