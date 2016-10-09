package arena.models

import java.util.Set
import master.Jugador
import master.LigaMaster
import master.Oferta
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class CrearOfertaModel {
	Oferta oferta = new Oferta
	Jugador jugadorON

	double montoOfertado = 0.0

	Set<Jugador> listaJugadores = newHashSet

	new(EquipoModel equipoModel) {
		oferta.dtOfertante = equipoModel.dtActivo
		oferta.jugadorOfertado = equipoModel.jugadorON
		oferta.dtReceptor = equipoModel.jugadorON.propietario
	}

	def void addJugador() {
		listaJugadores.add(jugadorON)
	}

	def void removeJugador() {
		listaJugadores.remove(jugadorON)
	}

	def void enviarOferta() {
		oferta.monto = montoOfertado
		oferta.jugadoresOfrecidos.addAll(listaJugadores)

		LigaMaster.instance.mercado.listaOfertas.add(oferta)

		guardar
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}
}
