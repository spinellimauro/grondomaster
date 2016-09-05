package master

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class Partido {
	int numeroFecha = 0
	DT dtLocal = new DT
	DT dtVisitante = new DT
	List<Jugador> golesLocal = newArrayList
	List<Jugador> golesVisitante = newArrayList

	override toString() {
		numeroFecha + "," + dtLocal.nombreDT + "," + dtVisitante.nombreDT + "," + golesLocal.fold(":") [ acum, jugador |
			acum + jugador.id + ":"
		] + "," + golesVisitante.fold(":")[acum, jugador|acum + jugador.id + ":"]
	}

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

	def boolean getJugoPartido(DT dt) {
		dtLocal.equals(dt) || dtVisitante.equals(dt)
	}

	def void addGol(Jugador jugador) {
		if(dtLocal.jugadores.contains(jugador)) golesLocal.add(jugador) else golesVisitante.add(jugador)
		ObservableUtils.firePropertyChanged(this, "score")
	}
	
	def void removeGol(Jugador jugador) {
		if(dtLocal.jugadores.contains(jugador)) golesLocal.remove(jugador) else golesVisitante.remove(jugador)
		ObservableUtils.firePropertyChanged(this, "score")
	}

	def String getScore() {
		golesLocal.size + " - " + golesVisitante.size
	}
}
