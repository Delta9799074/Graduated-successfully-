`timescale 1ns/1ps
module RO #(parameter CW = 20)
(
    /*(* DONT_TOUCH ="TRUE" *) input enable,*/
    (* MARK_DEBUG = "TRUE" *)output CLK_O
    );

	/*(* KEEP="TRUE" *) */
	(* DONT_TOUCH ="TRUE" *)logic [CW:0] chain;
	
    genvar i;
    generate
       for (i=1; i <= CW; i=i+1) 
       begin: not_seq
          assign chain[i] = !chain[i-1];
       end
    endgenerate
    
	//assign chain[0] = !(chain[CW]&enable);
	assign chain[0] = !chain[CW];
	assign CLK_O = chain[CW];
endmodule