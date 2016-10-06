package arena.models

import java.util.List
import master.DT
import master.LigaMaster
import master.Partido
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class TorneoModel {
	DT dtON
	int fechaON
	Torneo torneoON
	Partido partidoON
	
	String textoTorneo


	new(LoginModel loginModel) {
		dtON = loginModel.dtON
		setTorneoON(listaTorneos.get(0))
	}

	def List<Torneo> getListaTorneos() {
		LigaMaster.instance.listaTorneos
	}

	def void setTorneoON(Torneo torneo) {
		torneoON = torneo
		fechaON = 1
		
		ObservableUtils.firePropertyChanged(this, "fecha")
		ObservableUtils.firePropertyChanged(this, "listaFechas")
	}

	@Dependencies("fechaON")
	def List<Partido> getFecha() {
		torneoON.getFecha(fechaON) ?: newArrayList
	}

	def List<Integer> getListaFechas() {
		(1 .. torneoON.numeroFechas).toList
	}

	def void sortearFechas() {
		torneoON.sortearFechas

		ObservableUtils.firePropertyChanged(this, "fecha")
		ObservableUtils.firePropertyChanged(this, "listaFechas")

		guardar
	}

	def void addTorneo() {
		LigaMaster.instance.addTorneo(new Torneo => [nombreTorneo = textoTorneo])
	}

	def void removeTorneo() {
		LigaMaster.instance.removeTorneo(torneoON)

		guardar
	}

	def void update() {
		LigaMaster.instance.update
		guardar
	}

	def void terminarPartido() {
		try
			partidoON.terminarPartido
		catch (Exception e)
			throw new UserException(e.message)

		guardar
	}

	def void terminarTorneo() {
		try
			torneoON.terminarTorneo
		catch (Exception e)
			throw new UserException(e.message)

		guardar
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}
}
