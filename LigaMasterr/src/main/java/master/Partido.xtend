package master

import java.util.Collections
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class Partido {
	int numeroFecha = 0
	DT dtLocal
	DT dtVisitante
	boolean terminado = false
	Torneo torneo
	List<Jugador> golesLocal = newArrayList
	List<Jugador> golesVisitante = newArrayList
	List<Jugador> listaAmarillas = newArrayList
	List<Jugador> listaRojas = newArrayList

	def boolean getJugoPartido(DT dt) {
		dtLocal.equals(dt) || dtVisitante.equals(dt)
	}

	// Goles
	def String getScore() {
		golesLocal.size + " - " + golesVisitante.size
	}

	def int getGoles(Jugador jugador) {
		Collections.frequency((golesLocal + golesVisitante).toList, jugador)
	}

	def void addGol(Jugador jugador) {
		if(dtLocal.getListaJugadores.contains(jugador)) golesLocal.add(jugador) else golesVisitante.add(jugador)
		ObservableUtils.firePropertyChanged(this, "score")
	}

	def void removeGol(Jugador jugador) {
		if(dtLocal.getListaJugadores.contains(jugador)) golesLocal.remove(jugador) else golesVisitante.remove(jugador)
		ObservableUtils.firePropertyChanged(this, "score")
	}

	// Amonestaciones
	def void addAmarilla(Jugador jugador) {
		if(getAmarillas(jugador) < 2 && getRojas(jugador) < 1) listaAmarillas.add(jugador)
	}

	def void removeAmarilla(Jugador jugador) {
		listaAmarillas.remove(jugador)
	}

	def void addRoja(Jugador jugador) {
		if(getRojas(jugador) < 1 && getAmarillas(jugador) < 2) listaRojas.add(jugador)
	}

	def void removeRoja(Jugador jugador) {
		listaRojas.remove(jugador)
	}

	def boolean fueAmonestado(Jugador jugador) {
		getAmarillas(jugador) == 1
	}

	def boolean fueExpulsado(Jugador jugador) {
		getAmarillas(jugador) == 2 || getRojas(jugador) == 1
	}

	// Estadisticas - Jugador
	def int getAmarillas(Jugador jugador) {
		Collections.frequency(listaAmarillas, jugador)
	}

	def int getRojas(Jugador jugador) {
		Collections.frequency(listaRojas, jugador)
	}

	// Estadisticas - DT
	def int getPuntos(DT dt) {
		if (dt.equals(dtLocal)) {
			if (golesLocal.size > golesVisitante.size)
				3
			else if(golesLocal.size < golesVisitante.size) 0 else 1
		} else {
			if (golesLocal.size < golesVisitante.size)
				3
			else if(golesLocal.size > golesVisitante.size) 0 else 1
		}
	}

	def getGolesFavor(DT dt) {
		if(dt.equals(dtLocal)) golesLocal.size else golesVisitante.size
	}

	def getGolesContra(DT dt) {
		if(dt.equals(dtLocal)) golesVisitante.size else golesLocal.size
	}

	// Listas
	def List<Jugador> getSuspendidos() {
		(dtLocal.listaJugadores + dtVisitante.listaJugadores).filter[torneo.estaSuspendido(it, numeroFecha)].toList
	}

	def List<Jugador> getLesionados() {
		(dtLocal.listaJugadores + dtVisitante.listaJugadores).filter[estaLesionado].toList
	}

	// Terminar Partido
	def void terminarPartido() {
		if (terminado)
			throw new Exception("El partido ya terminó")

		terminado = true
		lesionados.forEach[decLesion]
		dtLocal.incPlata(getPremio(dtLocal))
		dtVisitante.incPlata(getPremio(dtVisitante))
	}

	def double getPremio(DT dt) {
		if (dt.puntos == 3)
			torneo.premios.getPremioEvento("Victoria") +
				torneo.premios.getPremioEvento("Gol") * ( getGolesFavor(dt) - getGolesContra(dt) )
		else if (dt.puntos == 1)
			torneo.premios.getPremioEvento("Empate")
		else
			0
	}
}
