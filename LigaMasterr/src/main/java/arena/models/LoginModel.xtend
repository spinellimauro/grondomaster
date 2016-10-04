package arena.models

import master.LigaMaster
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import java.util.List
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class LoginModel {
	DT dtON
	String dtNuevo = ""
	String dtEquipo = ""
	
	new() {
		LigaMaster.instance.leerBase
		dtON = listaDT.get(0)
	}
	
	def List<DT> getListaDT(){
		val lista = newArrayList
		lista.addAll(LigaMaster.instance.listaDT)
		lista.add(LigaMaster.instance.master)
		lista.sortBy[nombreDT]
	}
	
	def void crearDT() {
		if (listaDT.exists[nombreDT == dtNuevo]){
			throw new UserException("El DT ya Existe")
		}
		
		if (listaDT.exists[nombreEquipo == dtEquipo]){
			throw new UserException("El Equipo ya Existe")
		}
		
		LigaMaster.instance.crearDT(dtNuevo,dtEquipo)
		ObservableUtils.firePropertyChanged(this, "listaDT")
	}
}
