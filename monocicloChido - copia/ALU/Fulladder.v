module Fulladder(
	input	a_i,
	input b_i,
	input c_i,
	output c_o,
	output s_o
);

//XOR GATE
 wire axorb_w;
 assign axorb_w = a_i ^ b_i;
 
 //AND GATES
 wire canda_w;
 wire candb_w;
 wire banda_w;
 assign canda_w = c_i & a_i;
 assign candb_w = c_i & b_i;
 assign banda_w = b_i & a_i;
 
 //RESULTADO SE LA SUMA
 assign s_o = c_i ^ axorb_w;
 
 //ACARREO DE SALIDA
 assign c_o = canda_w | candb_w | banda_w;

endmodule