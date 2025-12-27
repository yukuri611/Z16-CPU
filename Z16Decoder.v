module Z16Decoder(
    input wire[15:0] i_instr,
    output wire[3:0] o_opcode,
    output wire[3:0] o_rd_addr,
    output wire[3:0] o_rs1_addr,
    output wire[3:0] o_rs2_addr,
    output wire[15:0] o_imm,
    output wire o_rd_we,
    output wire o_mem_we,
    output wire [3:0] o_alu_ctrl
);

    assign o_opcode = i_instr[3:0];
    assign o_rd_addr = i_instr[7:4];
    assign o_rs1_addr = i_instr[11:8];
    assign o_rs2_addr = i_instr[15:12];
    assign o_imm = get_imm(i_instr);
    assign o_rd_we = get_rd_we(i_instr);
    assign o_mem_we = get_mem_we(i_instr);
    assign o_alu_ctrl = get_alu_ctrl(i_instr);


    // sign-extention function for immediate values
    function [15:0] get_imm;
        input [15:0] i_instr;
        begin
            case(i_instr[3:0])
                4'hA: get_imm = {{12{i_instr[15]}}, i_instr[15:12]};
                4'hB: get_imm = {{12{i_instr[7]}}, i_instr[7:4]};
                default: get_imm =16'h0000;
            endcase
        end
    endfunction

    function get_rd_we;
        input [15:0] i_instr;
        begin
            if(4'hA == i_instr[3:0]) begin // load instruction
                get_rd_we = 1'b1;
            end else begin
                get_rd_we = 1'b0;
            end 
        end
    endfunction

    function get_mem_we;
        input [15:0] i_instr;
        begin
            if(4'hB == i_instr[3:0]) begin // store instruction
                get_mem_we = 1'b1;
            end else begin
                get_mem_we = 1'b0;
            end 
        end
    endfunction


    function[3:0] get_alu_ctrl;
        input [15:0] i_instr;
        begin
            get_alu_ctrl = 4'h0; // default ADD
        end
    endfunction

endmodule
