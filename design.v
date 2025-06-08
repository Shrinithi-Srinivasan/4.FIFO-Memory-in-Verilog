module fifo (
    input clk,
    input reset,
    input wr_en, rd_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg full, empty
);

    reg [7:0] fifo_mem [0:15];  // 16x8 FIFO
    reg [3:0] wr_ptr, rd_ptr;   // Pointers

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            if (wr_en && !full) begin
                fifo_mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;
                empty <= 0;
                if (wr_ptr + 1 == rd_ptr) full <= 1;
            end
            if (rd_en && !empty) begin
                data_out <= fifo_mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                full <= 0;
                if (rd_ptr + 1 == wr_ptr) empty <= 1;
            end
        end
    end
endmodule
