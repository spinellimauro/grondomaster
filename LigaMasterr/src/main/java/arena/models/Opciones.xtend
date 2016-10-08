package arena.models

import master.DT
import org.uqbar.commons.model.UserException
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Opciones {
	DT dtON
	String passwordON = ""
	String nuevaPassword = ""
	
	new(DT model){
		dtON = model
	}
	
	def cambiarContraseña() {
		if (passwordON == dtON.password){
			dtON.password = nuevaPassword
			LigaMaster.instance.guardarBase
		}else{
			throw new UserException("La contraseña es incorrecta")
		} 
	}

}