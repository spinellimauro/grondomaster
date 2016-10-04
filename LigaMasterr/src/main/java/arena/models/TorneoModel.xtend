package arena.models

import java.util.List
import master.LigaMaster
import master.Partido
import master.Torneo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import master.DT
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class TorneoModel {

	DT dtON
	Integer fechaON = 1
	Torneo torneoON 
	String nombreNuevoTorneo
	
	Partido partido
	String nombreIngresado

	new(LoginModel loginModel) {
		dtON = loginModel.dtON
		torneoON = listaTorneos.get(0)
//		partido = fecha.get(0)
	}
	
	def List<Torneo> getListaTorneos(){
		LigaMaster.instance.listaTorneos
	}

	def void setTorneoON(Torneo torneo) {
		fechaON = 1
		torneoON = torneo
		ObservableUtils.firePropertyChanged(this, "fecha")
		ObservableUtils.firePropertyChanged(this, "listaFechas")
	}
	
	@Dependencies("fechaON")
	def List<Partido> getFecha() {
		torneoON.getFecha(fechaON)
		
	}
	
	def List<Integer> getListaFechas() {
		(1 .. torneoON.numeroFechas).toList
	}
	
	def void sortearFechas(){
		torneoON.sortearFechas
		ObservableUtils.firePropertyChanged(this,"fecha")
		ObservableUtils.firePropertyChanged(this,"listaFechas")
		guardar
	}

	def void borrarTorneo() {
		LigaMaster.instance.removeTorneo(torneoON)
		guardar
	}
	
	def crearTorneo(){
		if(LigaMaster.instance.listaTorneos.exists[t|t.nombreTorneo == nombreNuevoTorneo]){
			throw new UserException("El Torneo con ese nombre ya existe")
		}
		
		LigaMaster.instance.addTorneo(new Torneo=>[nombreTorneo = nombreNuevoTorneo])
		ObservableUtils.firePropertyChanged(this,"listaTorneos")
		guardar
	}
	
	def update() {
		LigaMaster.instance.update
		guardar
	}
	
	def void terminarPartido() {
		partido.terminarPartido
		ObservableUtils.firePropertyChanged(this,"partidoActivo")
		guardar
	}
	
	@Dependencies("partido")
	def boolean getPartidoActivo()  {
		!partido.terminado
	}
	
	def guardar(){
		LigaMaster.instance.guardarBase
	}
	
	def terminarTorneo() {
		torneoON.terminarTorneo
	}
	
}
