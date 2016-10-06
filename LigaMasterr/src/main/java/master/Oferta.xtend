package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import datos.Mercado

@Observable
@Accessors
class Oferta {
	DT dtOfertante
	DT dtReceptor
	double monto
	
	Jugador jugadorOfertado
	List<Jugador> jugadoresOfrecidos = newArrayList

	def void aceptar() {
		dtOfertante.comprarJugador(jugadorOfertado,monto)
		dtReceptor.venderJugador(jugadorOfertado,monto)

		jugadoresOfrecidos.forEach[dtReceptor.comprarJugador(it, 0)]
		jugadoresOfrecidos.forEach[dtOfertante.venderJugador(it, 0)]
	
		Mercado.instance.listaOfertas.removeAll(Mercado.instance.getOfertasRecibidas(jugadorOfertado))
	}

	def void rechazar() {
		Mercado.instance.listaOfertas.remove(this)
	}
}
