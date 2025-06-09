module mult16x16 (
    input wire clk,
    input wire rstn,         // Active-low reset
    input wire scan_en,      // Scan Enable
    input wire scan_in,      // Scan Input
    output wire scan_out,    // Scan Output
    input wire [15:0] a,
    input wire [15:0] b,
    output reg [31:0] y
);

always @(posedge clk or negedge rstn) begin
    if (!rstn)
        y <= 32'd0;
    else
        y <= a * b;
end

// Optional placeholder scan logic (not required but avoids synthesis warnings)
assign scan_out = scan_in ^ scan_en; // Dummy logic

endmodule

