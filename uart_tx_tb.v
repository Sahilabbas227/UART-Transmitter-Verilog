`timescale 1ns / 1ps

module uart_tx_tb;

    reg clk;
    reg rst;
    reg baud_tick;
    reg tx_start;
    reg [7:0] tx_data;

    wire tx;
    wire tx_busy;

    // Instantiate UART TX
    uart_tx uut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // 100 MHz Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Baud Tick Generator (for simulation)
    initial begin
        baud_tick = 0;
        forever begin
            #50;
            baud_tick = 1;
            #10;
            baud_tick = 0;
        end
    end

    // Test Sequence
    initial begin
        rst = 1;
        tx_start = 0;
        tx_data = 8'hA5;

        #20;
        rst = 0;

        #100;
        tx_start = 1;

        #10;
        tx_start = 0;

        #2000;

        $finish;
    end

endmodule