`timescale 1ns/1ps

module monociclo_tb;
    reg clk_i;
    reg rst_ni;
    wire [31:0] salida_o;

    // Instantiate the monociclo module
    monociclo uut (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .salida_o(salida_o)
    );

    // Generate clock signal
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;  // Clock period = 10 ns
    end

    // Apply reset and stimulus
    initial begin
        // Monitor signals
        $monitor("At time %t, clk_i = %b, rst_ni = %b, salida_o = %h", $time, clk_i, rst_ni, salida_o);

        // Initialize inputs
        rst_ni = 0;
        #10 rst_ni = 1;  // Apply reset
        #100 rst_ni = 0; // Deassert reset after 100 ns
        #500 $stop;      // Stop the simulation after 500 ns
    end
endmodule