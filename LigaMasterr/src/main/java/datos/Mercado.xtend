package datos

import master.Oferta
import java.util.List
import master.DT
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import master.Jugador

@Observable
@Accessors
class Mercado {
	List<Oferta> listaOfertas = newArrayList
	List<Transferencia> listaTraspasos = newArrayList
	def List<Oferta> getOfertasRecibidas(Jugador jugador) {
		listaOfertas.filter[jugadorOfertado.equals(jugador)].toList
	}
	
	def List<Oferta> getOfertasRecibidas(DT dt) {
		listaOfertas.filter[dtReceptor.equals(dt)].toList
	}

	def List<Oferta> getOfertasEnviadas(DT dt) {
		listaOfertas.filter[dtOfertante.equals(dt)].toList
	}
	
	def void agregarTransferencia(String comprador, String vendedor , double _monto , String _jugadorComprado){
		listaTraspasos.add(
			new Transferencia =>[
				dtCompra = comprador
				dtVende = vendedor
				monto = _monto
				jugadorComprado = _jugadorComprado
			]
		)
	}
}

@Observable
@Accessors
class Transferencia {
	String dtCompra
	String dtVende
	double monto
	String jugadorComprado
}