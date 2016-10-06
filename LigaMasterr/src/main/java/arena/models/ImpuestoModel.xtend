package arena.models

import java.util.List
import master.DT
import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import master.LigaMaster
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class ImpuestoModel {
	DT dtON
	Jugador jugadorON
	
	List<Jugador> jugadoresAPagar = newArrayList
	List<Jugador> jugadoresSinPagar = newArrayList
	
	boolean habilitado = true
	
	new(TorneoConfigModel model) {
		dtON = model.dtON
		jugadoresSinPagar.addAll(dtON.jugadoresConImpuesto)
		
	}
	
	def void addAPagar(){
		if(jugadoresAPagar.contains(jugadorON))
			throw new UserException("Ya esta en A Pagar")
		
		jugadoresAPagar.add(jugadorON)
		jugadoresSinPagar.remove(jugadorON)
		
		actualizar
	}
	
	def void addSinPagar(){
		if(jugadoresSinPagar.contains(jugadorON))
			throw new UserException("Ya esta en Sin Pagar")
		
		jugadoresSinPagar.add(jugadorON)
		jugadoresAPagar.remove(jugadorON)
		
		actualizar
	}
	
	def void pagarImpuestos(){
		dtON.pagarImpuesto(jugadoresAPagar)
		
		LigaMaster.instance.guardarBase
	}
	
	def void actualizar(){
		ObservableUtils.firePropertyChanged(this,"impuestos")
		ObservableUtils.firePropertyChanged(this,"jugadoresAPagar")
		ObservableUtils.firePropertyChanged(this,"jugadoresSinPagar")
	}
	
	def double getImpuestos(){
		jugadoresAPagar.fold(0d)[acum , jugador| acum + jugador.impuesto]
	}
	
	def void deshabilitar(){
		habilitado = false
	}
	
}