package arena.models

import java.util.List
import master.DT
import master.Jugador
import master.LigaMaster
import master.Partido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class PartidoModel {
	DT dtON
	Partido partidoON
	Jugador jugadorON

	new(TorneoModel model) {
		partidoON = model.partidoON
		dtON = model.dtON
	}

	// Listas
	def List<Jugador> getEquipoLocal() {
		newArrayList => [
			addAll(partidoON.dtLocal.listaJugadores.sortBy[nombre])
			removeAll(suspendidos)
			removeAll(lesionados)
		]
	}

	def List<Jugador> getEquipoVisitante() {
		newArrayList => [
			addAll(partidoON.dtVisitante.listaJugadores.sortBy[nombre])
			removeAll(suspendidos)
			removeAll(lesionados)
		]
	}

	def List<Jugador> getSuspendidos() {
		partidoON.suspendidos
	}

	def List<Jugador> getLesionados() {
		partidoON.lesionados
	}

	// Goles
	def void addGol() {
		partidoON.addGol(jugadorON)
		guardar
	}

	def void removeGol() {
		partidoON.removeGol(jugadorON)
		guardar
	}

	// Amonestaciones
	def void addAmarilla() {
		partidoON.addAmarilla(jugadorON)
		guardar
	}

	def void removeAmarilla() {
		partidoON.removeAmarilla(jugadorON)
		guardar
	}

	def void addRoja() {
		partidoON.addRoja(jugadorON)
		guardar
	}

	def void removeRoja() {
		partidoON.removeRoja(jugadorON)
		guardar
	}

	// Lesion
	def void incLesion() {
		jugadorON.incLesion
		ObservableUtils.firePropertyChanged(this, "lesionados")
	}

	def void decLesion() {
		jugadorON.decLesion
		ObservableUtils.firePropertyChanged(this, "lesionados")
	}
	
	// Enabled
	
	def boolean getLesionesON(){
		dtON.equals(LigaMaster.instance.master) && partidoON.terminado
	}
	
	def boolean getEsMaster() {
		dtON.equals(LigaMaster.instance.master) && !partidoON.terminado
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}
}
