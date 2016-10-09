package arena.models

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import master.DT
import master.Jugador
import java.util.List
import master.LigaMaster
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class TransferiblesModel {
	DT dtON
	Jugador jugadorON

	new(DT dt) {
		dtON = dt
	}

	def List<Jugador> getTransferibles() {
		LigaMaster.instance.listaTransferibles.sortBy[nombre]
	}

	def void validar() {
		if (dtON.listaJugadores.contains(jugadorON))
			throw new Exception("Ese jugador ya es tuyo")

		if (jugadorON == null)
			throw new Exception("Debe seleccionar un Jugador")

		if (dtON.plata < jugadorON.precioVenta)
			throw new Exception("No tenés suficiente plata")
	}

	def void comprarJugador() {
		val jugador = jugadorON

		try {
			validar
			jugador.propietario.venderJugador(jugador, jugador.precioVenta)
			dtON.comprarJugador(jugador, jugador.precioVenta)
		} catch (Exception e)
			throw new UserException(e.message)

		ObservableUtils.firePropertyChanged(this, "transferibles")
		
		LigaMaster.instance.guardarBase
	}
}
