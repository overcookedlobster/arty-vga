module top (
    input wire clk,
    input wire btn_reset,
    output wire vga_hsync,
    output wire vga_vsync,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
);

    wire clk_25mhz;
    wire locked;
    wire reset;
    wire video_on;
    
    assign reset = btn_reset;

    clk_wiz_0 clk_gen (
        .clk_in1(clk),
        .clk_out1(clk_25mhz),
        .locked(locked)
    );

    vga_controller vga_ctrl (
        .clk(clk_25mhz),
        .reset(reset),
        .hsync(vga_hsync),
        .vsync(vga_vsync),
        .red(vga_r),
        .green(vga_g),
        .blue(vga_b),
        .video_on(video_on)
    );

endmodule
