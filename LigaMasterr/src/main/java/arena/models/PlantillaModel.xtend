package arena.models

import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class PlantillaModel {
	Jugador jugadorElegido = new Jugador
	DT dtElegido = new DT
	LigaMaster grondomaster = new LigaMaster

	new() {
		grondomaster.leerBase
	}
}
