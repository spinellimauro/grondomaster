package master

import datos.PremiosTorneos
import java.util.Collections
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class Torneo {
	PremiosTorneos premios = new PremiosTorneos
	String nombreTorneo = ""
	List<DT> listaParticipantes = newArrayList
	List<Partido> listaPartidos = newArrayList
	int limiteAmarillas = 3
	

	def void sortearFechas() {
		listaPartidos.clear
		
		var listaMezclada = newArrayList
		listaMezclada.addAll(listaParticipantes)
		Collections.shuffle(listaMezclada)
		val libre = new DT

		if(listaParticipantes.size % 2 != 0) listaParticipantes.add(libre)

		for (var fecha = 0; fecha < numeroFechas; fecha++) {

			for (var partido = 0; partido < (listaParticipantes.size) / 2; partido++) {

				var local = (fecha + partido) % numeroFechas
				var visitante = if(partido == 0) numeroFechas else (numeroFechas - partido + fecha) % numeroFechas

				val partidoNuevo = new Partido
				partidoNuevo.numeroFecha = fecha + 1
				partidoNuevo.dtLocal = listaMezclada.get(local)
				partidoNuevo.dtVisitante = listaMezclada.get(visitante)
				if(!partidoNuevo.getJugoPartido(libre)) listaPartidos.add(partidoNuevo)

			}
		}

		listaParticipantes.remove(libre)
	}
	
	def void addPartido(Partido partido) {
		partido.torneo = this
		listaPartidos.add(partido)
	}

	def int getFechaActual() {
		val partidosNoTerminados = listaPartidos.filter[!terminado]
		if(partidosNoTerminados.size > 0) partidosNoTerminados.minBy[numeroFecha].numeroFecha else numeroFechas
	}

	def Integer getNumeroFechas() {
		val nroDts = listaParticipantes.size
		if(nroDts % 2 == 0) nroDts - 1 else nroDts
	}

	def List<Partido> getFecha(int entero) {
		listaPartidos.filter[numeroFecha == entero].toList
	}

	def List<Jugador> getListaJugadores() {
		listaParticipantes.map[listaJugadores].flatten.toList
	}

	def List<Jugador> getListaTransferibles() {
		listaJugadores.filter[precioVenta != 0].toList
	}
	
	// Tablas

	def List<DT> getListaPosiciones() {
		listaParticipantes.sortBy[getPuntos(it)].reverse
	}

	def List<Jugador> getListaGoleadores() {
		listaJugadores.filter[getGoles(it) != 0].sortBy[getGoles(it)].reverse
	}

	def List<DT> getListaFairPlay() {
		listaParticipantes.sortBy[getPuntosFairPlay(it)]
	}
	
	// Estadisticas - DT
	
	def int getAmarillas(DT dt) {
		dt.listaJugadores.fold(0)[acum, jugador|acum + getAmarillas(jugador)]
	}
	
	def int getRojas(DT dt) {
		dt.listaJugadores.fold(0)[acum, jugador|acum + getRojas(jugador)]
	}

	def int getPuntosFairPlay(DT dt) {
		getAmarillas(dt) * 4 + getRojas(dt) * 12
	}
	
	def getPartidosTerminados(){
		listaPartidos.filter[terminado]
	}
	
	def int getGolesFavor(DT dt){
		partidosTerminados.fold(0)[acum,partido|acum + partido.getGolesFavor(dt)]
	}
	
	def int getGolesContra(DT dt){
		partidosTerminados.fold(0)[acum,partido|acum + partido.getGolesContra(dt)]
	}
	
	def int getDiferenciaGol(DT dt){
		getGolesFavor(dt) - getGolesContra(dt)
	}
	
	// Estadisticas - Jugador

	def int getGoles(Jugador jugador) {
		val listaGoles = listaPartidos.map[golesLocal + golesVisitante].flatten.toList
		Collections.frequency(listaGoles, jugador)
	}

	def int getAmarillas(Jugador jugador) {
		val listaRojas = listaPartidos.map[listaAmarillas].flatten.toList
		Collections.frequency(listaRojas, jugador)
	}

	def int getRojas(Jugador jugador) {
		val listaRojas = listaPartidos.map[listaRojas].flatten.toList
		Collections.frequency(listaRojas, jugador)
	}

	def boolean estaSuspendido(Jugador jugador) {
		val fechaAnterior = getFecha(fechaActual - 1)

		fechaAnterior.exists[fueExpulsado(jugador)] ||
			( fechaAnterior.exists[fueAmonestado(jugador)] && (getAmarillas(jugador) % limiteAmarillas == 0))
	}

	def int getPuntos(DT dt) {
		listaPartidos.filter[terminado].filter[getJugoPartido(dt)].fold(0)[acum, partido|acum + partido.getPuntos(dt)]
	}

	def DT getPropietario(Jugador jugador) {
		listaParticipantes.findFirst[listaJugadores.contains(jugador)]
	}

	def void addDT(DT dt) {
		if (listaParticipantes.contains(dt)){
			throw new UserException("El DT ya esta en el torneo")
		}
		listaParticipantes.add(dt)
	}

	def void removeDT(DT dt) {
		listaParticipantes.remove(dt)
	}


	def terminarTorneo() {
		var i = 0
		if (listaPartidos.forall[terminado]) {
			for (i = 0; i < premios.cantPremios; i++) { // pondriamos i<cantPremios Y que en premios haya un put(posicion,premio) etc
				listaPosiciones.get(i).plata = listaPosiciones.get(i).plata + premios.getPremio(i)
			}
			listaParticipantes.forEach[restarTorneoDisponible]
		}

//		grondomaster.guardarBase()
	}
}
