module fifo_tb;
    reg clk;
    reg reset;
    reg wr_en, rd_en;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire full, empty;

    fifo uut (
        .clk(clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
          $dumpfile("dumpfile.vcd");
    $dumpvars(1);

        // Initialize
        clk = 0;
        reset = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 8'b0;
        #10 reset = 0;

        // Write data to FIFO
        wr_en = 1;
        data_in = 8'hA5; // Write 0xA5
        #10;

        wr_en = 1;
        data_in = 8'h3C; // Write 0x3C
        #10;
        wr_en = 0;

        // Read data from FIFO
        rd_en = 1;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;

        // Write more data to FIFO
        wr_en = 1;
        data_in = 8'hFF; // Write 0xFF
        #10;
        wr_en = 0;

        // Read again
        rd_en = 1;
        #10;

        $finish;
    end
endmodule
