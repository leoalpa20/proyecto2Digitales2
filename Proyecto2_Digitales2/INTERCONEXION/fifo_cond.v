`include "../RAM/Ram.v"

module fifo_cond #(parameter DATA_W = 6, parameter ADDR_W = 2)(
    // Entradas
    input clk,
    input reset_L,
    input enable2,
    input [ADDR_W-1:0] buffer_empty, // Buffer esta vacio
    input [ADDR_W-1:0] buffer_full, // Buffer esta lleno
    input push,         // Sacar del FIFO
    input pop,          // Meter al FIFO
    input [DATA_W-1:0] data_in, // Datos de entrada
    // Salidas
    output [DATA_W-1:0] data_out_c,
    output reg error_c,
    output reg almost_empty_c, // FIFO casi vacio
    output reg almost_full_c,  // FIFO casi lleno
    output reg empty_c,         // FIFO vacio
    output reg full_out_c       // Duda, salida de lleno del FIFO preguntar al profe
);

localparam cantidad_entradas = 2 ** ADDR_W; // Cantidad de entradas del FIFO o tamaño

// Punteros de escritura
reg [ADDR_W-1:0] wr_ptr; //Puntero de escritura
reg [ADDR_W-1:0] flop_wr; //Puntero de escritura del flop
// Punteros de lectura
reg [ADDR_W-1:0] rd_ptr; //Puntero de lectura
reg [ADDR_W-1:0] flop_rd; //Puntero de lectura del flop

// Señales de control (Para el FIFO)

reg error; // Para indicar errores
reg full_c; // Para indicar que se esta lleno (conductual)

// Señales de control (Para la RAM)

reg [1:0] state;
reg [1:0] flop_state;
reg enable=1;

reg [ADDR_W-1:0] contador_wr; // Contador de escrituras para llevar un control
reg [ADDR_W-1:0] contador_rd; // Contador de lecturas para llevar un control
reg almost_full_f, almost_empty_f, empty_f, full_f; // Señales de control para los flops

Ram #(.RAM_WIDTH(DATA_W), .ADDR_SIZE(ADDR_W)) ram_FIFO(
    /*AUTOINST*/
    //INPUTS
    .clk        (clk),
    .reset_L    (reset_L),
    .enable    (enable2),
    .state        (state[1:0]),
    .addr_in    (flop_wr[ADDR_W-1:0]),
    .addr_out   (flop_rd[ADDR_W-1:0]),
    .data_in    (data_in[DATA_W-1:0]),
    //OUTPUTS
    .data_out_c  (data_out_c[DATA_W-1:0])
);

// Logica para controlar RAM
// Valores para el reset
always @(posedge clk) begin
    if(~reset_L) begin // Resetear las señales
    	full_out_c <= 0; //---
    	//full_c <= 0;
        flop_wr <= 0;
        flop_rd <= 0;
        flop_state <= 0;
        almost_full_f <= 0;
        almost_empty_f <= 0;
        full_f <= 0;
        empty_f <= 0;
        error_c <= error;
    end else begin
        // Variables internas a variables del modulo
        flop_wr <= wr_ptr;
        flop_rd <= rd_ptr;
        error_c <= error;
        flop_state <= state;
        almost_full_f <= almost_full_c;
        almost_empty_f <= almost_empty_c;
        empty_f <= empty_c;
        full_f <= full_c;
    end  
end

// Control de los punteros y flujo
always @(*) begin
    if (reset_L) begin
        full_out_c = full_c; // Pregunta
        almost_full_c = almost_full_f;
	almost_empty_c = almost_empty_f;
	empty_c = empty_f;
	full_c = full_f;
	wr_ptr = flop_wr;
	rd_ptr = flop_rd;
        error = error_c;
        state = flop_state;
        full_c = 0; // Para indicar que no esta llena
        empty_c = 0;
		// ####################### FLOW CONTROL #####################################
        // Si el puntero de lectura es mayor al de escritura, ya se paso por la memoria una vez 
        if (rd_ptr > wr_ptr) begin
            full_c = 0;
            empty_c = 0; // No estamos llenos

            if (((rd_ptr - wr_ptr)) <= cantidad_entradas - buffer_full) begin
                almost_full_c = 1;
            end else begin
                almost_full_c = 0;
            end
            if (((rd_ptr - wr_ptr))  >= cantidad_entradas - buffer_empty) begin
                almost_empty_c = 1;
                almost_full_c = 0;
        end else begin
            almost_empty_c=0;
        end
    end else begin
        		if (((wr_ptr - rd_ptr)) >= buffer_full) begin 
				almost_full_c = 1;
			end	else begin
				almost_full_c = 0;
			end
			if (((wr_ptr - rd_ptr)) <= buffer_empty) begin
				almost_empty_c = 1;
				almost_full_c = 0;
			end else begin
				almost_empty_c = 0;
			end
			
		end
		if (wr_ptr == rd_ptr & !almost_full_f) begin
			empty_c = 1;
			almost_empty_c = 1;
			full_c = 0;
			almost_full_c = 0;
		end else if (wr_ptr == rd_ptr) begin
			empty_c = 0;
			almost_empty_c = 0;
			full_c = 1;
			almost_full_c = 1;
		end
		// ################### Logica para push y pop, FIFO ############################
		if (push & !pop & !error_c) begin
			if (!full_f) begin
				wr_ptr = flop_wr + 1;
				rd_ptr = flop_rd;
			end else begin
				error = 1;
			end
			
			state = 2; //Escritura
			enable = 1;
		end 
		else if (pop & !push & !error_c)begin
			if (!empty_f) begin
				rd_ptr = flop_rd + 1;
				wr_ptr = flop_wr;
			end else begin
				error = 1;
			end

			state = 1; //Lectura
			enable = 1;
		end
		else if (pop & push & !error_c) begin
			if (!empty_f && !full_f) begin
				rd_ptr = flop_rd + 1;
				wr_ptr = flop_wr + 1;
			end else begin
				error = 1;
			end
			
			state = 3; //3 es lectura y escritura
			enable = 1;
		end
		else begin
			rd_ptr = flop_rd;
			wr_ptr = flop_wr;
			state = 0;
			enable = 1;
		end
	end else begin
		wr_ptr = 0;
		rd_ptr = 0;
		error  = 0;
		state    = 0;
		enable = 0;
		almost_full_c = 0;
		almost_empty_c = 0;
		empty_c = 0;
		full_c = 0;
	end
end

endmodule

