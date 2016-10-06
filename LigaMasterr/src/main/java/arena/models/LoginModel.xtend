package arena.models

import java.util.List
import master.DT
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
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

	def List<DT> getListaDT() {
		newArrayList => [
			add(LigaMaster.instance.master)
			addAll(LigaMaster.instance.listaDT.sortBy[nombreDT])
		]
	}

	def void crearDT() {
		var dt = new DT => [
			nombreDT = dtNuevo
			nombreEquipo = dtEquipo
		]

		try
			LigaMaster.instance.addDT(dt)
		catch (Exception e)
			throw new UserException(e.message)

		ObservableUtils.firePropertyChanged(this, "listaDT")
	}
}
