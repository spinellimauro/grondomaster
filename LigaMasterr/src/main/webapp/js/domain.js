function LigaMaster() {
    this.nombreLiga;
    this.listaTorneos = [];
    this.dirDTs;
    this.dirJugadores;
    this.dirTorneos;
}
/*
	def List<DT> getDTsQuePagan() {
		listaDTs.filter[fechasDisponibles == 0].toList
	}

	def List<DT> getListaDTs() {
		listaTorneos.map[listaParticipantes].flatten.toList
	}

	def Set<Jugador> getListaJugadores() {
		listaTorneos.map[listaJugadores].flatten.toSet
	}
	
	def Set<Jugador> getListaTransferibles() {
		listaJugadores.filter[precioVenta > 0].toSet
	}

	def void crearBase() {
		new File(dirDTs).createNewFile
		new File(dirJugadores).createNewFile
		new File(dirTorneos).createNewFile
	}

	def void leerBase() {
		setListaJugador(new FileReader(dirJugadores).readLines)
		setListaDT(new FileReader(dirDTs).readLines)
		listaTorneos.addAll( new FileReader(dirTorneos).readLines.map[toTorneo])
	}

	def void guardarBase() {
		val PrintWriter writerDTs = new PrintWriter(dirDTs)
		listaDTs.forEach[writerDTs.println(toJSON)]
		writerDTs.close

		val PrintWriter writerJugadores = new PrintWriter(dirJugadores)
		listaJugadores.forEach[writerJugadores.println(toJSON)]
		writerJugadores.close

		val PrintWriter writerTorneo = new PrintWriter(dirTorneos)
		listaTorneos.forEach[writerTorneo.println(toJSON)]
		writerTorneo.close
	}

	def void addTorneo(Torneo torneo) {
		listaTorneos.add(torneo)
	}
	
	def void removeTorneo(Torneo torneo) {
		listaTorneos.remove(torneo)
	}
}*/


function Jugador() {
    this.id;
    this.nombre;
    this.nivel;
    this.potencial;
    this.habilitado = true;
    this.torneo;
    this.precioVenta = 0;
    this.vecesNoPagadas = 0;
}

Jugador.asJugador = function(jsonJugador) {
    return angular.extend(new Jugador(), jsonJugador);
}

/*
	def double getImpuesto() {
		Precios.instance.getPrecio(this) * (Precios.instance.getPrecio("Impuesto") / 100)
	}

	def getPrecioMaquina() {
		Precios.instance.getPrecio(this)
	}

	def void noSePago() {
		vecesNoPagadas++
		habilitado = false
	}

	def void pagar() {
		vecesNoPagadas = 0
		habilitado = true
	}

	def boolean getPagaImpuesto() {
		nivel > 82
	}

	def int getAmarillas() {
		torneo.getAmarillas(this)
	}

	def int getRojas() {
		torneo.getRojas(this)
	}

	def int getGoles() {
		torneo.getGoles(this)
	}

	def DT getPropietario() {
		torneo.getPropietario(this)
	}

	def void update() {
		val instance = Jsoup.connect("http://sofifa.com/player/199715").userAgent("Mozilla").post.select("td.text-center > span.label")
		nivel = Integer.parseInt(instance.get(0).text)
		potencial = Integer.parseInt(instance.get(1).text)
	}

	override equals(Object obj) {
		if (obj == null)
			return false
		if (!Jugador.isAssignableFrom(obj.class))
			return false

		val otroJugador = obj as Jugador
		if (id != otroJugador.id)
			return false
		else
			true
	}

	override hashCode() {
		id
	}
*/

function DT() {
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
DT.prototype.getCantidadJugadores = function() {
    return this.listaJugadores.length;
}


DT.prototype.addJugador = function(jugador) {
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
