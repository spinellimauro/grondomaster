package arena.models

import datos.PremioPosicion
import master.DT
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.PremioEvento

@Observable
@Accessors
class PremiosTorneosModel {
	Torneo torneoON
	DT dtON
	PremioPosicion posicionON
	PremioEvento eventoON
	
	new(TorneoModel model) {
		torneoON = model.torneoON
		dtON = model.dtON
		posicionON = listaPosiciones.get(0)
		eventoON = listaEventos.get(0)
	}
	
	def getListaPosiciones(){
		torneoON.premios.listaPosiciones
	}
	
	def getListaEventos(){
		torneoON.premios.listaEventos
	}
}