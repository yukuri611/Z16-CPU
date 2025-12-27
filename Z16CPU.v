module Z16CPU(
    input wire i_clk,
    input wire i_rst
);
    
    reg [15:0] r_pc;

    wire [15:0] w_instr;
    wire[3:0] w_rd_addr;
    wire[3:0] w_rs1_addr;
    wire[3:0] w_rs2_addr;
    wire[15:0] w_imm;
    wire[3:0] w_opcode;
    wire w_rd_we;
    wire w_mem_we;
    wire [3:0] w_alu_ctrl;

    wire[15:0] w_rs1_data;
    wire[15:0] w_rs2_data;
    wire[15:0] w_rd_data;
    
    wire [15:0] w_data_b;
    wire[15:0] w_alu_data;
    wire[15:0] w_mem_rdata;

    always @(posedge i_clk) begin
        if (i_rst) begin
            r_pc <= 16'h0000;
        end else if (w_opcode == 4'hC) begin // JAL
            r_pc <= w_alu_data;
        end else if (w_opcode == 4'hD) begin // JRL
            r_pc <= r_pc + w_alu_data;
        end else if((w_opcode == 4'hE) && (w_rs2_data == w_rs1_data)) begin // BEQ
            r_pc <= r_pc + w_imm;
        end else if ((w_opcode == 4'hF) && (w_rs1_data < w_rs2_data)) begin // BLT
            r_pc <= r_pc + w_imm;
        end else begin
            r_pc <= r_pc + 16'h0002;
        end
    end



    Z16InstrMemory InstrMemory(
        .i_addr(r_pc),
        .o_instr(w_instr)
    );

    Z16Decoder Decoder(
        .i_instr(w_instr),
        .o_opcode(w_opcode),
        .o_rd_addr(w_rd_addr),
        .o_rs1_addr( w_rs1_addr),
        .o_rs2_addr( w_rs2_addr),
        .o_imm(w_imm),
        .o_rd_we(w_rd_we),
        .o_mem_we(w_mem_we),
        .o_alu_ctrl(w_alu_ctrl)
    );

    assign w_rd_data = select_rd_data(w_opcode, w_mem_rdata, r_pc, w_alu_data);

    function [15:0] select_rd_data;
        input [3:0] i_opcode;
        input [15:0] i_mem_rdata;
        input [15:0] i_pc;
        input [15:0] i_alu_data;

        begin
            case(i_opcode)
                4'hA: select_rd_data = i_mem_rdata; // load
                4'hC: select_rd_data = i_pc + 16'h0002; // JAL
                4'hD: select_rd_data = i_pc + 16'h0002; // JALR
                default: select_rd_data = i_alu_data;
            endcase 
        end
    endfunction


    Z16RegisterFile RegFile(
        .i_clk(i_clk),
        .i_rs1_addr(w_rs1_addr),
        .o_rs1_data(w_rs1_data),
        .i_rs2_addr(w_rs2_addr),
        .o_rs2_data(w_rs2_data),
        .i_rd_addr(w_rd_addr),
        .i_rd_we(w_rd_we),
        .i_rd_data(w_rd_data)
    );

    assign w_data_b = (w_opcode <=4'h8) ? w_rs2_data: w_imm;
    Z16ALU ALU(
        .i_data_a(w_rs1_data),
        .i_data_b(w_data_b),
        .i_ctrl(w_alu_ctrl),
        .o_data(w_alu_data)
    );
    
    Z16DataMemory DataMemory(
        .i_clk(i_clk),
        .i_addr(w_alu_data),
        .i_we(w_mem_we),
        .i_data(w_rs2_data),
        .o_data(w_mem_rdata)
    );
endmodule
