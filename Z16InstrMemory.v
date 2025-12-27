module Z16InstrMemory(
    input wire[15:0] i_addr,
    output wire[15:0] o_instr
);

    wire[15:0] mem[4:0];

    assign o_instr = mem[i_addr[15:1]];

    assign mem[0] = 16'h206A; // LOAD 4 ZR G2 
    assign mem[1] = 16'h407A;
    assign mem[2] = 16'h6780;
    assign mem[3] = 16'h0000;
    assign mem[4] = 16'h0000;

endmodule
