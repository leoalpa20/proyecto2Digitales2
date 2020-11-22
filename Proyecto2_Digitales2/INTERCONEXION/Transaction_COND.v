// Modulo de la interconexion

`include "../FIFO/fifo_cond.v"
`include "../FSM/FSM_cond.v"
module Transaction_COND #(	parameter DATA_W = 6, // ancho de la data
							parameter MF_SIZE = 2, // Main FIFO size	
							parameter VC_SIZE = 3, // Virtual channel size
							parameter D_SIZE = 2)( // D0, D1
			     		
//Outputs
// Todas son variables de salida
output  [DATA_W-1: 0] data_out_0_c, // principales salidas
output  [DATA_W-1: 0] data_out_1_c,
output error_out_c, 		// error de salida
output active_out_c,
output idle_out_c, 		// Pausa, estar quieto sin hacer nada
output almost_full_MF_c,
output almost_D0_empty_sig_in, // FIFO D0 casi vacio
output almost_D1_empty_sig_in, // FIFO D1 casi vacio

//Inputs 
input clk,                 
input reset,
input init,
// Almost Full threshold in umbrales de casi lleno
input [MF_SIZE-1:0] MF_full_umbral_in,
input [VC_SIZE-1:0] VC_full_umbral_in,
input [D_SIZE-1:0] D_full_umbral_in,
// Almost Empty threshold in, umbrales de casi vacio, de main fifo, virtual chanell y D
input [MF_SIZE-1:0] MF_empty_umbral_in,
input [VC_SIZE-1:0] VC_empty_umbral_in,
input [D_SIZE-1:0] D_empty_umbral_in,
input enable,                     

input push_MF, 		// push main fifo
input pop_D0, 
input pop_D1,
input [DATA_W-1: 0] data_in   // datos de entrada
);

// Reset from FSM
wire reset_out;
// codificacion one hot
parameter RESET = 'b00001;  //1
parameter INIT = 'b00010;   //2
parameter IDLE = 'b00100;   //4
parameter ACTIVE = 'b01000; //8
parameter ERROR = 'b10000;  //10
//Inputs of FSM Maquinas de estado input, jonathan los cambio
// senales de entradas de error, la maquina de estados monitorea los errores de los FIFOS
wire VC0_err_sig_in; 
wire VC1_err_sig_in;
wire MF_err_sig_in;
wire D0_err_sig_in;
wire D1_err_sig_in;
// Senales de vacio, igual la maquina de estados las monitorea
wire VC0_empty_sig_in;
wire VC1_empty_sig_in;
wire MF_empty_sig_in;
wire D0_empty_sig_in;
wire D1_empty_sig_in;

//Outputs of fsm, salidas
// Umbrales llenos de los fifos
wire [MF_SIZE-1:0] MF_full_umbral_out_c; 
wire [VC_SIZE-1:0] VC_full_umbral_out_c;
wire [D_SIZE-1:0] D_full_umbral_out_c;
// Umbrales vacios de los fifos
wire [MF_SIZE-1:0] MF_empty_umbral_out_c;
wire [VC_SIZE-1:0] VC_empty_umbral_out_c;
wire [D_SIZE-1:0] D_empty_umbral_out_c;

//Datas
// Salida de datos del Main FIFO y de los VC0 y VC1 ademas de entradas de estos
wire [DATA_W-1:0] data_out_MF_c;
wire [DATA_W-1:0] data_out_VC0_c;
reg [DATA_W-1:0] data_in_VC0_c;
wire [DATA_W-1:0] data_out_VC1_c;
reg [DATA_W-1:0] data_in_VC1_c;

// data in para los D0 y D1
reg [DATA_W-1:0] data_in_D0_c;
reg [DATA_W-1:0] data_in_D1_c;

//Push & pop
reg [DATA_W-1:0] data_d;
//reg push_MF;
reg pop_MF;
///////////////////////////////////////////////////////
reg pop_MF_t;
reg pop_VC0_t;
reg pop_VC1_t;

reg push_VC0,push_VC1;
reg push_VC, pop_VC0, pop_VC1; //pop_VC0_f, pop_VC1_f;

reg push_D0,push_D1;
reg push_D;


wire almost_MF_empty_sig_in;// almost_full_MF_c;

wire almost_VC0_empty_sig_in, almost_full_VC0_c, almost_VC1_empty_sig_in, almost_full_VC1_c;

wire almost_full_D0_c,  almost_full_D1_c;

always @(posedge clk) begin
	if(reset_out) begin
		pop_MF<=pop_MF_t;    		//Se debe de sostener la señal en el ciclo de reloj 
		pop_VC0<=pop_VC0_t;		//porque el fifo guarda los datos de forma secuencial
		pop_VC1<=pop_VC1_t;		//por eso se usa una variable temporal

	end else begin
		pop_MF<=0;
		pop_VC0<=0;
		pop_VC1<=0;

	end
end
// Logica combinacional
always @(*) begin

	//Logica para hacer Pop en los fifos
	if (!(almost_full_VC0_c | almost_full_VC1_c) & !almost_MF_empty_sig_in & reset_out)
		pop_MF_t = 1;
	else	pop_MF_t = 0;
	if (!(almost_full_D0_c | almost_full_D1_c) & !almost_VC0_empty_sig_in & reset_out)
		pop_VC0_t = 1;
	else	pop_VC0_t = 0;
	if (!(almost_full_D0_c | almost_full_D1_c) & !almost_VC1_empty_sig_in & !pop_VC0_t & reset_out)
		pop_VC1_t = 1;
	else	pop_VC1_t = 0;
	//Le damos prioridad absoluta a VC0. 
	//Los pop_VC_t son pops temporales para sostener un ciclo y pasar los datos en los mux en el momento correcto 
	//y hacer los pushen de fifos de adelante.
	
	if(reset_out) begin        		//Cuando se saca una palabra de algun fifo, debe de cargarse en el siguiente.
		push_VC=pop_MF;    		
		push_D=pop_VC0 | pop_VC1;
		// Primer DEMUX
		//Se evalua el bit VC_id (bit 5) para clasificar las palabras y enviarlas al al fifo de mayor prioridad.
		////////////////// DEMUX1  /////////////////////////
		if (data_out_MF_c[DATA_W-1]==0 & push_VC==1) begin    //Se evalua el bit 5 (VC_id) para enviar el dato a VC0 0 VC1.
			data_in_VC0_c=data_out_MF_c;                  
			data_in_VC1_c=0;
			push_VC0=1;
			push_VC1=0;

		end else if (data_out_MF_c[DATA_W-1]==1 & push_VC==1) begin
			data_in_VC1_c=data_out_MF_c;
			data_in_VC0_c=0;
			push_VC1=1;
			push_VC0=0;
		end else begin
			push_VC0=0;
			push_VC1=0;
			data_in_VC0_c=0;
			data_in_VC1_c=0;
		end

		////////////////// MUX ////////////////////////////
		// Se carga al mux la palabra del fifo que le corresponde el pop
		if (pop_VC0==1 & pop_VC1==0) begin              //Dependiendo del de los pop se redirige la salidad de los 
			data_d=data_out_VC0_c;                 //fifo VC al
		end else if (pop_VC0==0 & pop_VC1==1) begin
			data_d=data_out_VC1_c;
		end else begin
			data_d=0;
		end 
		///////////////// DEMUX2 /////////////////////////
		// DEMUX de abajo, 2
		// Verificamos el bit de destino (bit 4) y enrutamos
		if (data_d[DATA_W-2]==0 & push_D==1) begin
			data_in_D0_c=data_d;
			data_in_D1_c=0;
			push_D0=1;           //Cargamos, el push es equivalente al pop de de los VC
			push_D1=0;

		end else if (data_d[DATA_W-2]==1 & push_D==1) begin
			data_in_D1_c=data_d;
			data_in_D0_c=0;
			push_D1=1;          //Cargamos
			push_D0=0;
		end else begin
			push_D0=0;
			push_D1=0;
			data_in_D0_c=0;
			data_in_D1_c=0;
		end
	// Valores para evitar ruido en el sistema
	end else begin 
		push_D0=0;
		push_D1=0;
		data_in_D0_c=0;
		data_in_D1_c=0;
		data_d=0;
		push_VC0=0;
		push_VC1=0;
		data_in_VC0_c=0;
		data_in_VC1_c=0;
		push_D=0;
		push_VC=0;
	end	
end


FSM_cond #(
	       .MF_SIZE		(MF_SIZE),
	       .VC_SIZE		(VC_SIZE),
	       .D_SIZE		(D_SIZE),
	       .RESET			(RESET),
	       .INIT			(INIT),
	       .IDLE			(IDLE),
	       .ACTIVE			(ACTIVE),
	       .ERROR			(ERROR)) fsm_COND(
							  .MF_full_umbral_out_c(MF_full_umbral_out_c[MF_SIZE-1:0]),
							  .VC_full_umbral_out_c(VC_full_umbral_out_c[VC_SIZE-1:0]),
							  .D_full_umbral_out_c	(D_full_umbral_out_c[D_SIZE-1:0]),
							  .MF_empty_umbral_out_c(MF_empty_umbral_out_c[MF_SIZE-1:0]),
							  .VC_empty_umbral_out_c(VC_empty_umbral_out_c[VC_SIZE-1:0]),
							  .D_empty_umbral_out_c	(D_empty_umbral_out_c[D_SIZE-1:0]),
							  .error_out_c		(error_out_c),
							  .active_out_c		(active_out_c),
							  .idle_out_c		(idle_out_c),
							  .reset_out			(reset_out),
							  // Inputs
							  .clk			(clk),
							  .init			(init),
							  .reset		(reset),
							  .VC0_err_sig_in		(VC0_err_sig_in),
							  .VC1_err_sig_in		(VC1_err_sig_in),
							  .MF_err_sig_in		(MF_err_sig_in),
							  .D0_err_sig_in		(D0_err_sig_in),
							  .D1_err_sig_in		(D1_err_sig_in),
							  .VC0_empty_sig_in		(VC0_empty_sig_in),
							  .VC1_empty_sig_in		(VC1_empty_sig_in),
							  .MF_empty_sig_in		(MF_empty_sig_in),
							  .D0_empty_sig_in		(D0_empty_sig_in),
							  .D1_empty_sig_in		(D1_empty_sig_in),
							  .MF_full_umbral_in	(MF_full_umbral_in[MF_SIZE-1:0]),
							  .VC_full_umbral_in	(VC_full_umbral_in[VC_SIZE-1:0]),
							  .D_full_umbral_in	(D_full_umbral_in[D_SIZE-1:0]),
							  .MF_empty_umbral_in	(MF_empty_umbral_in[MF_SIZE-1:0]),
							  .VC_empty_umbral_in	(VC_empty_umbral_in[VC_SIZE-1:0]),
							  .D_empty_umbral_in	(D_empty_umbral_in[D_SIZE-1:0]));
// MAIN FIFO
fifo_cond #(
	     .DATA_W			(DATA_W),
	     .ADDR_W			(MF_SIZE)) FIFO_COND_MF(
     // Outputs
     .data_out_c			(data_out_MF_c[DATA_W-1:0]),
     .error_c				(MF_err_sig_in),
     .almost_empty_c			(almost_MF_empty_sig_in), 		//Para el pop MF
     .almost_full_c			(almost_full_MF_c),       		//Pausa para detener el push en el probador
     .empty_c				(MF_empty_sig_in),        		//Para la maquina de estados

     // Inputs
     .buffer_full			(MF_full_umbral_out_c[MF_SIZE-1:0]), 	//Proporcionado por la FSM
     .buffer_empty			(MF_empty_umbral_out_c[MF_SIZE-1:0]),
     .clk				(clk),
     .reset_L				(reset_out),
     .enable2				(enable),
     .push				(push_MF),
     .pop				(pop_MF),
     .data_in				(data_in[DATA_W-1:0]));
// VIRTUAL CHANNEL 0
fifo_cond #(
	     .DATA_W			(DATA_W),
	     .ADDR_W			(VC_SIZE)) FIFO_COND_VC0(
     // Outputs
     .data_out_c			(data_out_VC0_c[DATA_W-1:0]),
     .error_c				(VC0_err_sig_in),
     .almost_empty_c			(almost_VC0_empty_sig_in),     	//para el primer demux
     .almost_full_c			(almost_full_VC0_c),           	//para el detener el pop del MF
     .empty_c				(VC0_empty_sig_in),            	//Para la FSM
     // Inputs
     .buffer_full			(VC_full_umbral_out_c[VC_SIZE-1:0]), 	//Proporcionados por la FSM
     .buffer_empty			(VC_empty_umbral_out_c[VC_SIZE-1:0]), 
     .clk				(clk),
     .reset_L				(reset_out),
     .enable2				(enable),
     .push				(push_VC0), 				//Definido por el primer demux
     .pop				(pop_VC0),  				//Definido por el delay
     .data_in				(data_in_VC0_c[DATA_W-1:0]));
// VIRTUAL CHANNEL 1
fifo_cond #(
	     .DATA_W			(DATA_W),
	     .ADDR_W			(VC_SIZE)) FIFO_COND_VC1(
     // Outputs
     .data_out_c			(data_out_VC1_c[DATA_W-1:0]),
     .error_c				(VC1_err_sig_in),
     .almost_empty_c			(almost_VC1_empty_sig_in),
     .almost_full_c			(almost_full_VC1_c),
     .empty_c				(VC1_empty_sig_in),
     // Inputs
     .buffer_full			(VC_full_umbral_out_c[VC_SIZE-1:0]),
     .buffer_empty			(VC_empty_umbral_out_c[VC_SIZE-1:0]),
     .clk				(clk),
     .reset_L				(reset_out),
     .enable2				(enable),
     .push				(push_VC1),
     .pop				(pop_VC1),
     .data_in				(data_in_VC1_c[DATA_W-1:0])); 
// FIFO D0
fifo_cond #(
	     .DATA_W			(DATA_W),
	     .ADDR_W			(D_SIZE)) FIFO_COND_D0(
     // Outputs
     .data_out_c			(data_out_0_c[DATA_W-1:0]),
     .error_c				(D0_err_sig_in),			//Para la FSM
     .almost_empty_c			(almost_D0_empty_sig_in),		//Para la salida
     .almost_full_c			(almost_full_D0_c),			//Para los pops de los VC
     .empty_c				(D0_empty_sig_in),   			//Para la FSM         
     // Inputs
     .buffer_full			(D_full_umbral_out_c[D_SIZE-1:0]),	//FSM
     .buffer_empty			(D_empty_umbral_out_c[D_SIZE-1:0]),	//FSM
     .clk				(clk),
     .reset_L				(reset_out),
     .enable2				(enable),
     .push				(push_D0),				//Del segundo demux
     .pop				(pop_D0),				//Del probador
     .data_in				(data_in_D0_c[DATA_W-1:0]));
// FIFO D1
fifo_cond #(
	     .DATA_W			(DATA_W),
	     .ADDR_W			(D_SIZE)) FIFO_COND_D1(
     // Outputs
     .data_out_c			(data_out_1_c[DATA_W-1:0]),
     .error_c				(D1_err_sig_in),
     .almost_empty_c			(almost_D1_empty_sig_in),
     .almost_full_c			(almost_full_D1_c),
     .empty_c				(D1_empty_sig_in),
     // Inputs
     .buffer_full			(D_full_umbral_out_c[D_SIZE-1:0]),
     .buffer_empty			(D_empty_umbral_out_c[D_SIZE-1:0]),
     .clk				(clk),
     .reset_L				(reset_out),
     .enable2				(enable),
     .push				(push_D1),
     .pop				(pop_D1),
     .data_in				(data_in_D1_c[DATA_W-1:0]));

endmodule 

