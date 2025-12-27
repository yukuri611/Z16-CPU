module Z16DataMemory(
    input wire i_clk,
    input wire[15:0] i_addr,
    input wire i_we,
    input wire[15:0] i_data,
    output wire[15:0] o_data
);

    reg[15:0] mem[1023:0];
    
    //load
    assign o_data = mem[i_addr[10:1]]; // begin with 1 not 0(i_addr = byte address)


    //store
    always @(posedge i_clk) begin
        if (i_we) begin
            mem[i_addr[10:1]] <= i_data;
        end
    end

endmodule
