module ebreak(
    input        jmp_valid,
    input [31:0] inst,
    input [31:0] Debug_a0
);
    always @(*) begin
        if (!jmp_valid&&(inst==32'h00100073)) begin
            if (Debug_a0 == 32'h0) begin
                $display("\033[1;32mGOOD Hit! Program exited normally.\033[0m");
                $finish;
            end else begin
                $display("\033[1;31mBAD Hit! inst = 0x%08x\033[0m", inst);
                $finish;
            end
        end
    end
endmodule
