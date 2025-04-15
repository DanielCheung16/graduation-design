
module vga_ctrl(
        input  wire         clock_cpu,
        input  wire         rst_cpu,
        input  wire  [3:0]  wea,
        input  wire  [31:0] addra,
        input  wire  [31:0] dina,
        output wire  [31:0] douta,
        input  wire         clock_vga,
        input  wire  [3:0]  web,
        input  wire  [0:0]  addrb,
        input  wire  [31:0] dinb,
        output wire  [31:0] doutb
    );
//----------------------------参数定义------------------------------------------
    localparam VGA_CTRL_BASE = 32'ha000_0100;
    localparam VGA_CTRL_SIZE = 8;
    localparam VGA_CTRL_END  = VGA_CTRL_BASE + VGA_CTRL_SIZE -1;
    
    wire           addra_word = (addra - VGA_CTRL_BASE)>>2;    //这里读的地址都是做了地址对齐的（可能会有问题，lh，lb这种可能会出错）
    reg     [1:0]  addra_offset;
    wire    [31:0] douta_t;
//------------------------------------------------------------------------------
    always @(posedge clock_cpu) begin                   //addra_offset会决定输出的调整
        if(rst_cpu)begin
            addra_offset <= 2'b0;
        end else begin
            addra_offset    <=  addra[1:0];
        end
    end

    assign douta = douta_t >> (8*addra_offset);

    
    vga_ctrl_0 u_vga_ctrl_mmio(
        .clka  	(clock_cpu      ),
        .ena   	(1              ),
        .wea   	(wea            ),
        .addra 	(addra_word     ),
        .dina  	(dina           ),
        .douta 	(douta_t        ),
        .clkb  	(clock_vga      ),
        .enb   	(1              ),
        .web   	(web            ),
        .addrb 	(addrb          ),
        .dinb  	(dinb           ),
        .doutb 	(doutb          )
    );
endmodule
