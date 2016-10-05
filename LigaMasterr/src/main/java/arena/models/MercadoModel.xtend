package arena.models

import datos.SoFifa
import java.util.List
import master.DT
import master.Jugador
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class MercadoModel {
	DT dtON
	DT dtElegido
	
	Jugador jugadorON
	String valorIngresado = ""

	List<Jugador> listaMaquina = newArrayList

	new(TorneoModel model) {
		dtON = model.dtON
		dtElegido = listaDT.get(0)
	}

	def List<Jugador> getListaTransferibles() {
		val listaCompleta = newArrayList
		listaCompleta.addAll(LigaMaster.instance.listaTransferibles)
		listaCompleta.removeAll(dtON.getListaJugadores)
		listaCompleta
	}
	
	def List<DT> getListaDT(){
		LigaMaster.instance.listaDT.sortBy[nombreDT]
	}

	
	def void comprarJugador() {
		if (dtON.plata < jugadorON.precioVenta)
			throw new UserException("Dinero Insuficiente")
		if (dtON.slots < dtON.listaJugadores.size + 1){
			throw new UserException("No posee suficiente Slots")
		}
		
		jugadorON.propietario.venderJugador(jugadorON)
		dtON.comprarJugador(jugadorON, jugadorON.precioVenta)
		LigaMaster.instance.guardarBase
		ObservableUtils.firePropertyChanged(this, "listaTransferibles")
		ObservableUtils.firePropertyChanged(this, "dtON")
	}

	def void buscar() {
		listaMaquina.clear
		listaMaquina.addAll(SoFifa.instance.getJugadores(valorIngresado))
	}

	def void comprarJugadorALaMaquina() {
		if (dtON.plata < jugadorON.precioMaquina)
			throw new UserException("Dinero Insuficiente")

		if (!listaMaquina.contains(jugadorON))
			throw new UserException("Ese jugador no es de la Máquina")
	
		if (jugadorON.propietario.nombreDT != "Libre"){
			throw new UserException("Ese jugador es de otro DT")
		}
		
		if (dtON.slots < dtON.listaJugadores.size + 1){
			throw new UserException("No posee suficiente Slots")
		}
		
		dtON.comprarJugador(jugadorON, jugadorON.precioMaquina)
		listaMaquina.remove(jugadorON)
		LigaMaster.instance.guardarBase
		
		ObservableUtils.firePropertyChanged(this, "dtON")
	}
	
	def void agregarJugador() {
		val dtViejo = jugadorON.propietario
		
		if (!listaMaquina.contains(jugadorON))
			throw new UserException("Ese jugador no es de la Máquina")
		if (dtElegido.slots < dtElegido.listaJugadores.size + 1){
			throw new UserException("No posee suficiente Slots")
		}
		if (dtElegido.listaJugadores.contains(jugadorON)){
			throw new UserException("Ya posee ese jugador")
		}
		
		if (dtViejo != null){
			dtViejo.listaJugadores.remove(jugadorON)
			dtElegido.addJugador(jugadorON) 
			listaMaquina.remove(jugadorON)
			LigaMaster.instance.guardarBase
		}else{
			dtElegido.addJugador(jugadorON) 
			listaMaquina.remove(jugadorON)
			LigaMaster.instance.guardarBase
		}
		
		
		
		ObservableUtils.firePropertyChanged(this, "dtON")
	}
	

	
	def boolean getHabilitado(){
		if(dtON.nombreDT == "Master"){ 
		 true
		}
		else{false}
	}
}
