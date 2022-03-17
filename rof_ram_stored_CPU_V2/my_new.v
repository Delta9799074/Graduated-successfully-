`timescale 1ns / 1ps
module RO #(parameter CW = 100)
(
    (* KEEP="TRUE" *) input enable,
    output CLK_O
    );

	(* KEEP="TRUE" *) wire [CW:0] chain;
	//reg tff = 0;
	
	genvar i;
   generate
      for (i=1; i <= CW; i=i+1) 
      begin: not_seq
         assign chain[i] = !chain[i-1];
      end
   endgenerate
	assign chain[0] = !(chain[CW]&enable);
	
	/*always @(posedge chain[0]) begin
		if(RESET) tff = 0;
		else tff = !tff;
	end
	
	assign CLK_O = tff;*/
	assign CLK_O = chain[CW];
endmodule