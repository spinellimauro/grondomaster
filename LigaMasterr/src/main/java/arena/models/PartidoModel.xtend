package arena.models

import java.util.List
import master.Jugador
import master.LigaMaster
import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.Torneo

@Observable
@Accessors
class PartidoModel {
	Torneo torneoON
	Partido partidoON
	Jugador jugadorSeleccionado

	new(TorneoModel model) {
		partidoON = model.partidoON
		torneoON = model.torneoON
	}

	def List<Jugador> getEquipoLocal() {
		newArrayList => [
			addAll(partidoON.dtLocal.listaJugadores.sortBy[nombre])
			removeAll(suspendidos)
		]
	}

	def List<Jugador> getEquipoVisitante() {
		newArrayList => [
			addAll(partidoON.dtVisitante.listaJugadores.sortBy[nombre])
			removeAll(suspendidos)
		]
	}

	def List<Jugador> getSuspendidos() {
		(partidoON.dtLocal.listaJugadores + partidoON.dtVisitante.listaJugadores).filter [
			torneoON.estaSuspendido(it, partidoON.numeroFecha)
		].toList
	}

	def void addGol() {
		partidoON.addGol(jugadorSeleccionado)
		guardar
	}

	def void removeGol() {
		partidoON.removeGol(jugadorSeleccionado)
		guardar
	}

	def void addAmarilla() {
		partidoON.addAmarilla(jugadorSeleccionado)
		guardar
	}

	def void removeAmarilla() {
		partidoON.removeAmarilla(jugadorSeleccionado)
		guardar
	}

	def void addRoja() {
		partidoON.addRoja(jugadorSeleccionado)
		guardar
	}

	def void removeRoja() {
		partidoON.removeRoja(jugadorSeleccionado)
		guardar
	}

	def boolean getPartidoActivo() {
		!partidoON.terminado
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}
}
