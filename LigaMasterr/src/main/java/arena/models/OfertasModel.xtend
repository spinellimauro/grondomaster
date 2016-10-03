package arena.models

import datos.Mercado
import java.util.List
import master.DT
import master.Oferta
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import master.LigaMaster

@Observable
@Accessors
class OfertasModel {
	DT dtON
	Oferta ofertaON
	
	new(DT dt) {
		dtON = dt
	}
	
	def List<Oferta> getOfertasRecibidas(){
		Mercado.instance.getOfertasRecibidas(dtON)
	}
	
	def List<Oferta> getOfertasEnviadas(){
		Mercado.instance.getOfertasEnviadas(dtON)
	}
	
	def void aceptarOferta(){
		if (ofertaON.dtOfertante.slots < dtON.listaJugadores.size + 1){
			throw new UserException("No posee suficiente Slots")
		}
		
		if(ofertaON.monto <= ofertaON.dtOfertante.plata){
			ofertaON.aceptar
			ObservableUtils.firePropertyChanged(this ,"ofertasRecibidas")
		}else{
			throw new UserException("El DT ofertante no posee ese dinero")
		}
			
		guardar	
	}
	
	def void rechazarOferta(){
		ofertaON.rechazar
		ObservableUtils.firePropertyChanged(this ,"ofertasRecibidas")
		ObservableUtils.firePropertyChanged(this ,"ofertasEnviadas")
		guardar
	}
	
	def void guardar(){
		LigaMaster.instance.guardarBase	
	}
}
