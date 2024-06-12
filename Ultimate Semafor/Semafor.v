module Semafor(
  input clk,
  input rst_n,
  input buton_pietoni,
  output reg masini_rosu,
  output reg masini_galben,
  output reg masini_verde,
  output reg pietoni_verde,
  output reg pietoni_rosu
);

reg [2:0] stare;
reg [5:0] contor_masini;

localparam ROSU_MASINI = 3'b000;
localparam VERDE_MASINI = 3'b001;
localparam GALBEN_MASINI = 3'b010;
localparam ROSU_PIETONI = 3'b011;
localparam VERDE_PIETONI = 3'b100;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      stare <= ROSU_MASINI;
      contor_masini <= 0;
      masini_rosu <= 1;
      masini_galben <= 0;
      masini_verde <= 0;
      pietoni_rosu <= 1;
      pietoni_verde <= 0;
    end else begin
      // Mașini
		case(stare)
			ROSU_MASINI: begin
				masini_rosu <= 1;
				masini_galben <= 0;
				masini_verde <= 0;
				contor_masini <= contor_masini + 1;
				if (contor_masini == 30) begin
					contor_masini <= 0;
					stare <= VERDE_MASINI;
				end
			end
			VERDE_MASINI: begin
				masini_rosu <= 0;
				masini_galben <= 0;
				masini_verde <= 1;
				contor_masini <= contor_masini + 1;		  
				if (contor_masini >= 60 && buton_pietoni) begin
					contor_masini <= 0;
					stare <= GALBEN_MASINI;
				end
			end
			GALBEN_MASINI: begin
				masini_rosu <= 0;
				masini_galben <= 1;
				masini_verde <= 0;
				contor_masini <= contor_masini + 1;
				if (contor_masini == 5 ) begin
					contor_masini <= 0;
					stare <= ROSU_MASINI;
				end
			end
		endcase
		// Pietoni
		if (stare == ROSU_MASINI) begin
			pietoni_rosu <= 0;
			pietoni_verde <= 1;
		end
		else if (stare == VERDE_MASINI || stare == GALBEN_MASINI) begin
				pietoni_rosu <= 1;
				pietoni_verde <= 0;	
			end
		end
	end
	
endmodule
