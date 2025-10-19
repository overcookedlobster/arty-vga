module vga_controller (
    input wire clk,
    input wire reset,
    output wire hsync,
    output wire vsync,
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue,
    output wire video_on
);

    parameter H_DISPLAY = 640;
    parameter H_FRONT   = 16;
    parameter H_SYNC    = 96;
    parameter H_BACK    = 48;
    parameter H_TOTAL   = 800;

    parameter V_DISPLAY = 480;
    parameter V_FRONT   = 10;
    parameter V_SYNC    = 2;
    parameter V_BACK    = 33;
    parameter V_TOTAL   = 525;

    reg [9:0] h_count;
    reg [9:0] v_count;
    
    wire h_end = (h_count == H_TOTAL - 1);
    wire v_end = (v_count == V_TOTAL - 1);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            h_count <= 0;
        end else begin
            if (h_end)
                h_count <= 0;
            else
                h_count <= h_count + 1;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            v_count <= 0;
        end else begin
            if (h_end) begin
                if (v_end)
                    v_count <= 0;
                else
                    v_count <= v_count + 1;
            end
        end
    end
    
    assign hsync = ~((h_count >= (H_DISPLAY + H_FRONT)) && 
                     (h_count < (H_DISPLAY + H_FRONT + H_SYNC)));
    
    assign vsync = ~((v_count >= (V_DISPLAY + V_FRONT)) && 
                     (v_count < (V_DISPLAY + V_FRONT + V_SYNC)));
    
    assign video_on = (h_count < H_DISPLAY) && (v_count < V_DISPLAY);

    wire [9:0] x_pos = h_count;
    wire [9:0] y_pos = v_count;
    
    reg [25:0] color_counter;
    reg color_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            color_counter <= 0;
            color_state <= 0;
        end else begin
            if (color_counter == 26'd50_000_000) begin
                color_counter <= 0;
                color_state <= ~color_state;
            end else begin
                color_counter <= color_counter + 1;
            end
        end
    end
    
    assign red   = video_on ? (color_state ? 4'hF : 4'h0) : 4'h0;
    assign green = video_on ? (color_state ? 4'h0 : 4'hF) : 4'h0;
    assign blue  = video_on ? 4'h0 : 4'h0;

endmodule
