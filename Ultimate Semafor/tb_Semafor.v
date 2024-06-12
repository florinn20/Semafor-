module tb_Semafor;
reg buton_pietoni;
wire masini_rosu, masini_galben, masini_verde, pietoni_verde, pietoni_rosu;
wire clk;
wire rst_n;

ck_rst_tb #(10) clk_rst_inst (
    .clk(clk),
    .rst_n(rst_n)
	);

initial begin
	buton_pietoni = 1;
	buton_pietoni = 0;
	////repeat (100) @(posedge clk);
	buton_pietoni = 1;
end
Semafor semafor_inst (
	.clk(clk),
    .rst_n(rst_n),
    .buton_pietoni(buton_pietoni),
    .masini_rosu(masini_rosu),
    .masini_galben(masini_galben),
    .masini_verde(masini_verde),
    .pietoni_verde(pietoni_verde),
    .pietoni_rosu(pietoni_rosu)
  );

endmodule