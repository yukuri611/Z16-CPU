module Z16RegisterFile(
    input wire i_clk,
    
    input wire[3:0] i_rs1_addr,
    output wire[15:0] o_rs1_data,
    
    input wire[3:0] i_rs2_addr,
    output wire[15:0] o_rs2_data,

    input wire[3:0] i_rd_addr,
    input wire i_rd_we,
    input wire[15:0] i_rd_data
);

    reg[15:0] mem[15:0];

    assign o_rs1_data = (i_rs1_addr == 4'h0) ? 16'h0000: mem[i_rs1_addr];
    assign o_rs2_data = (i_rs2_addr == 4'h0) ? 16'h0000: mem[i_rs2_addr];

    always @(posedge i_clk) begin
        if (i_rd_we) begin
            mem[i_rd_addr] <= i_rd_data;
        end
    end

endmodule
