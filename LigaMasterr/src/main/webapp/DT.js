function DT(){
	this.nombreDT;
	this.nombreEquipo;
	this.plata;
	this.slots = 30;
	this.listaJugadores = [];
	this.ofertasRecibidas = [];
	this.torneo;
	this.fechasDisponibles = 3;
}


DT.prototype = new DT();
/*DT.prototype = {
	getJugadores : function() {
		this.listaJugadores.filter[!torneo.estaSuspendido(it)].toSet;
	}

	venderJugador : function(jugador) {
		this.incPlata(jugador.precioVenta);
		this.removeJugador(jugador);
	}

	comprarJugador : function(jugador,precio) {
		this.decPlata(precio);
		this.addJugador(jugador);
		jugador.precioVenta = 0;
	}
	*/
	DT.prototype.getCantidadJugadores = function(){
		return this.listaJugadores.length;
	}
	
	
	DT.prototype.addJugador = function(jugador){
		this.listaJugadores.push(jugador);
	}
	/*
	pagarImpuesto : function(jugadoresAPagar) {
		jugadoresAPagar.forEach[pagarImpuesto]

		var jugadoresNoPagados = newArrayList
		jugadoresNoPagados.addAll(listaJugadores)
		jugadoresNoPagados.removeAll(jugadoresAPagar)
		jugadoresNoPagados.forEach[noSePago]

		if(jugadoresNoPagados.size != 0) fechasDisponibles--
	}

	pagarImpuesto : function(jugador) {
		decPlata(jugador.impuesto)
		jugador.pagar
	}

	getJugadoresConImpuesto : function() {
		listaJugadores.filter[pagaImpuesto].toList
	}

	getTieneSlots : function() {
		slots > listaJugadores.size
	}

	comprarSlot : function() {
		slots++
		decPlata(torneo.precios.getPrecio("Slot"))
	}

	incPlata : function(monto) {
		plata += monto
	}

	decPlata : function(Double monto) {
		plata -= monto
	}

	addJugador : function(Jugador jugador) {
		jugador.torneo = torneo
		listaJugadores.add(jugador)
	}

	removeJugador : function(Jugador jugador) {
		ofertasRecibidas.removeAll(getOfertas(jugador))
		listaJugadores.remove(jugador)
	}

	getPuntos : function() {
		torneo.getPuntos(this)
	}

	getAmarillas : function() {
		listaJugadores.fold(0)[acum, jugador|acum + jugador.amarillas]
	}

	getRojas : function() {
		listaJugadores.fold(0)[acum, jugador|acum + jugador.rojas]
	}

	getPuntosFairPlay : function() {
		amarillas * 4 + rojas * 12
	}

	addOferta : function(oferta) {
		ofertasRecibidas.add(oferta)
	}

	getOfertas : function(Jugador jugador) {
		ofertasRecibidas.filter[jugadorOfertado.equals(jugador)].toList
	}

	hayOfertas : function() {
		ofertasRecibidas.nullOrEmpty
	}
	
	restarTorneoDisponible : function(){
		fechasDisponibles--
	}
	
	tieneQuePagar : function(){
		fechasDisponibles == 0
	}
}*/