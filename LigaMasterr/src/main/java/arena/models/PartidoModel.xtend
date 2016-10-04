package arena.models

import master.Jugador
import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import master.LigaMaster

@Observable
@Accessors
class PartidoModel {
	String nombreLocal
	String nombreVisitante
	List<Jugador> equipoLocal
	List<Jugador> equipoVisitante

	Partido partido
	Jugador jugadorSeleccionado

	new(TorneoModel model) {
		partido = model.partido
		nombreLocal = partido.dtLocal.nombreDT
		nombreVisitante = partido.dtVisitante.nombreDT
		equipoLocal = partido.dtLocal.listaJugadores.filter[!model.torneoON.estaSuspendido(it)].toList
		equipoVisitante = partido.dtVisitante.listaJugadores.filter[!model.torneoON.estaSuspendido(it)].toList
	}

	def void addGol() {
		partido.addGol(jugadorSeleccionado)
		guardar
	}

	def void removeGol() {
		partido.removeGol(jugadorSeleccionado)
		guardar
	}

	def void addAmarilla() {
		partido.addAmarilla(jugadorSeleccionado)
		guardar
	}

	def void removeAmarilla() {
		partido.removeAmarilla(jugadorSeleccionado)
		guardar
	}

	def void addRoja() {
		partido.addRoja(jugadorSeleccionado)
		guardar
	}

	def void removeRoja() {
		partido.removeRoja(jugadorSeleccionado)
		guardar
	}
	
	def boolean getPartidoActivo(){
		!partido.terminado
	}
	
	def void guardar(){
		LigaMaster.instance.guardarBase
	}
}
