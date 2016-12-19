function LigaMaster(){	
	this.nombreLiga;
	this.listaTorneos = [];
	this.dirDTs;
	this.dirJugadores;
	this.dirTorneos;
}/*
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
}