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

	new(LoginModel loginModel) {
		dtON = loginModel.dtON
		setTorneoON(listaTorneos.get(0) ?: new Torneo)
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
		LigaMaster.instance.addTorneo(new Torneo => [nombreTorneo = "Torneo"])
		setTorneoON(listaTorneos.last)

		ObservableUtils.firePropertyChanged(this, "listaTorneos")

		guardar
	}

	def void removeTorneo() {
		if ( listaTorneos.size < 2 ) 
			throw new UserException("Debe haber al menos un torneo creado")
		
		LigaMaster.instance.removeTorneo(torneoON)
		setTorneoON(listaTorneos.get(0) ?: new Torneo)

		ObservableUtils.firePropertyChanged(this, "listaTorneos")

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

	def boolean esMaster() {
		dtON.equals(LigaMaster.instance.master)
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}
}
