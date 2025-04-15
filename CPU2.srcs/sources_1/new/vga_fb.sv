module vga_fb(
        input         clock_cpu,
        input         clock_vga,
        input         rst_cpu,
        input [3:0]   wea,
        input [31:0]  addra,
        input [31:0]  dina,
        input [16:0]  addrb,

        output [31:0] douta,
        output [31:0] doutb
    );
//----------------------------参数定义------------------------------------------
    localparam FB_BASE = 32'ha1000000;
    localparam FB_SIZE = 400 * 300 * 4;//weight:400, hight:300, 以Byte为单位所以*4
    localparam FB_END  = FB_BASE + FB_SIZE - 1;
    
    wire    [16:0] addra_word = (addra - FB_BASE)>>2;    //这里读的地址都是做了地址对齐的（可能会有问题，lh，lb这种可能会出错）
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

    vga_gen_0 u_vga_gen_mmio(
        .clka  	(clock_cpu   ),
        .ena   	(1           ),
        .wea   	(wea         ),
        .addra 	(addra_word  ),
        .dina  	(dina        ),
        .douta 	(douta_t     ),
        .clkb  	(clock_vga   ),
        .enb   	(1           ),
        .web   	(0           ),     //vga不写fb模块
        .addrb 	(addrb       ),
        .dinb  	(0           ),
        .doutb 	(doutb       )
    );
endmodule
