package arena.models

import java.util.Set
import master.DT
import master.Jugador
import master.LigaMaster
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class EquipoModel {
	Torneo torneoON
	DT dtON
	double precioVenta
	DT dtElegido
	Jugador jugadorON
	String valorIngresado

	new(TorneoModel model) {
		torneoON = model.torneoON
		dtON = model.dtON
		dtElegido = otrosDT.get(0)
	}

	def validar() {
		if (dtElegido == null)
			throw new UserException("Debe seleccionar un usuario")

		if (jugadorON == null)
			throw new UserException("Debe seleccionar un jugador")
	}
	
	def void venderJugadorALaMaquina(){
		dtON.venderJugadorALaMaquina(jugadorON)
	}
	
	def Set<DT> getOtrosDT(){
		val lista = newHashSet
		lista.addAll(LigaMaster.instance.listaDT)
		lista.remove(dtON)
		lista.sortBy[nombreDT].toSet
	}
	
	def ponerEnMercado() {
		jugadorON.precioVenta = precioVenta
		LigaMaster.instance.guardarBase
	}
	
	
}
