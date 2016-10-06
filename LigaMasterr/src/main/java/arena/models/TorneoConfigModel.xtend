package arena.models

import java.util.List
import master.DT
import master.LigaMaster
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class TorneoConfigModel {
	Torneo torneoON
	DT dtON
	String textoTorneo = ""

	new(Torneo model) {
		torneoON = model
		textoTorneo = model.nombreTorneo
	}
	
	def void setTextoTorneo( String string ){
		torneoON.nombreTorneo = string
		textoTorneo = string
		
		guardar
	}
	
	def List<DT> getListaDT() {
		newArrayList => [
			addAll(LigaMaster.instance.listaDT.sortBy[nombreDT])
			removeAll(torneoON.listaParticipantes)
		]
	}

	def void addDT() {
		if (dtON == null)
			throw new UserException("Debe seleccionar un DT de la Lista")

		if (torneoON.listaParticipantes.contains(dtON))
			throw new UserException("El DT ya está en el Torneo")

		dtON.decTorneos
		torneoON.listaParticipantes.add(dtON)
		ObservableUtils.firePropertyChanged(this, "listaDT")

		guardar
	}

	def void removeDT() {
		if (dtON == null)
			throw new UserException("Debe seleccionar un DT de la Lista")

		dtON.incTorneos
		torneoON.listaParticipantes.remove(dtON)
		ObservableUtils.firePropertyChanged(this, "listaDT")
		
		guardar
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}

}
