package master

import datos.PremiosTorneos
import java.util.Collections
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import com.fasterxml.jackson.annotation.JsonIgnore

@Observable
@Accessors
class Torneo {
	String nombreTorneo = ""
	@JsonIgnore
	List<DT> listaParticipantes = newArrayList
	List<Partido> listaPartidos = newArrayList
	PremiosTorneos premios = new PremiosTorneos
	int limiteAmarillas = 3
	boolean terminado = false

	def void sortearFechas() {
		listaPartidos.clear
		Collections.shuffle(listaParticipantes)

		val libre = new DT => [nombreDT = "Libre"]
		if(listaParticipantes.size % 2 != 0) listaParticipantes.add(libre)

		for (var fecha = 0; fecha < numeroFechas; fecha++) {

			for (var partido = 0; partido < (listaParticipantes.size) / 2; partido++) {

				var local = (fecha + partido) % numeroFechas
				var visitante = if(partido == 0) numeroFechas else (numeroFechas - partido + fecha) % numeroFechas

				val partidoNuevo = new Partido
				partidoNuevo.numeroFecha = fecha + 1
				partidoNuevo.dtLocal = listaParticipantes.get(local)
				partidoNuevo.dtVisitante = listaParticipantes.get(visitante)

				if(!partidoNuevo.getJugoPartido(libre)) addPartido(partidoNuevo)
			}
		}

		listaParticipantes.remove(libre)
	}

	def void addPartido(Partido partido) {
		partido.torneo = this
		listaPartidos.add(partido)
	}

	def int getNumeroFechas() {
		val nroDts = listaParticipantes.size
		if(nroDts % 2 == 0) nroDts - 1 else nroDts
	}

	def List<Integer> getListaFechas() {
		(1 .. numeroFechas).toList
	}

	def List<Partido> getFecha(int entero) {
		listaPartidos.filter[numeroFecha == entero].toList
	}
	
	@JsonIgnore
	def List<Jugador> getListaJugadores() {
		listaParticipantes.map[listaJugadores].flatten.toList
	}

	// Estadísticas
	@JsonIgnore
	def List<DT> getListaPosiciones() {
		listaParticipantes.sortBy[getPuntos(it)].reverse
	}

	@JsonIgnore
	def List<Jugador> getListaGoleadores() {
		listaJugadores.filter[getGoles(it) != 0].sortBy[getGoles(it)].reverse
	}

	@JsonIgnore
	def List<DT> getListaFairPlay() {
		listaParticipantes.sortBy[getPuntosFairPlay(it)]
	}

	def List<EstadisticaTorneo> getTablaPosiciones() {
		listaPosiciones.map[new EstadisticaTorneo(it, this)]
	}

	def List<EstadisticaFairPlay> getTablaFairPlay() {
		listaFairPlay.map[new EstadisticaFairPlay(it, this)]
	}

	def List<EstadisticaJugador> getTablaGoleadores() {
		listaGoleadores.map[new EstadisticaJugador(it, this)]
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

	def List<Partido> getPartidosJugados(DT dt) {
		listaPartidos.filter[it.terminado].filter[getJugoPartido(dt)].toList
	}

	def int getGolesFavor(DT dt) {
		getPartidosJugados(dt).fold(0)[acum, partido|acum + partido.getGolesFavor(dt)]
	}

	def int getGolesContra(DT dt) {
		getPartidosJugados(dt).fold(0)[acum, partido|acum + partido.getGolesContra(dt)]
	}

	def int getPuntos(DT dt) {
		getPartidosJugados(dt).fold(0)[acum, partido|acum + partido.getPuntos(dt)]
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

	def boolean estaSuspendido(Jugador jugador, int fecha) {
		val fechaAnterior = getFecha(fecha - 1)

		fechaAnterior.exists[fueExpulsado(jugador)] ||
			( fechaAnterior.exists[fueAmonestado(jugador)] && (getAmarillas(jugador) % limiteAmarillas == 0))
	}

	def DT getPropietario(Jugador jugador) {
		listaParticipantes.findFirst[listaJugadores.contains(jugador)]
	}

	def void terminarTorneo() {
		if (terminado)
			throw new Exception("El torneo ya terminó")

		if (listaPartidos.exists[p|!p.terminado])
			throw new Exception("Hay partidos sin terminar")

		if (premios.cantPremios > listaParticipantes.size)
			throw new Exception("Faltan " + (premios.cantPremios - listaParticipantes.size) + " DT más")

		terminado = true

		for (var int i = 0; i < premios.cantPremios; i++)
			listaPosiciones.get(i).incPlata(premios.getPremio(i + 1))
	}
}

@Observable
@Accessors
class EstadisticaTorneo {
	String nombre
	String equipo
	int pj
	int g
	int e
	int p
	String goles
	int pts

	new(DT dt, Torneo torneo) {
		nombre = dt.nombreDT
		equipo = dt.nombreEquipo
		pj = torneo.getPartidosJugados(dt).size
		g = torneo.getPartidosJugados(dt).filter[getPuntos(dt) == 3].size
		e = torneo.getPartidosJugados(dt).filter[getPuntos(dt) == 1].size
		p = torneo.getPartidosJugados(dt).filter[getPuntos(dt) == 0].size
		goles = torneo.getGolesFavor(dt) + ":" + torneo.getGolesContra(dt)
		pts = torneo.getPuntos(dt)
	}
}

@Observable
@Accessors
class EstadisticaJugador {
	int id
	String nombre
	int goles

	new(Jugador jugador, Torneo torneo) {
		id = jugador.id
		nombre = jugador.nombre
		goles = torneo.getGoles(jugador)
	}
}

@Observable
@Accessors
class EstadisticaFairPlay {
	String nombre
	String equipo
	int amarillas
	int rojas
	int puntos

	new(DT dt, Torneo torneo) {
		nombre = dt.nombreDT
		equipo = dt.nombreEquipo
		amarillas = torneo.getAmarillas(dt)
		rojas = torneo.getRojas(dt)
		puntos = torneo.getPuntosFairPlay(dt)
	}
}
