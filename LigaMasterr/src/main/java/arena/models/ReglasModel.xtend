package arena.models

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.PrecioNivel
import datos.PrecioEvento
import datos.Precios
import java.util.List
import master.DT
import master.LigaMaster

@Observable
@Accessors
class ReglasModel {
	DT dtON
	PrecioNivel nivelON = listaNiveles.get(0)
	PrecioEvento eventoON = listaEventos.get(0)
	
	new(DT model){
		dtON = model
	}
	
	def List<PrecioNivel> getListaNiveles() {
		Precios.instance.listaNiveles
	}

	def List<PrecioEvento> getListaEventos() {
		Precios.instance.listaEventos
	}
	
	def boolean esMaster(){
		dtON.equals(LigaMaster.instance.master)
	}
}
