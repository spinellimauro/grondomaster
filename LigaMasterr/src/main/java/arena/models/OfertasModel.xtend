package arena.models

import java.util.List
import master.DT
import master.LigaMaster
import master.Oferta
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class OfertasModel {
	DT dtON
	Oferta ofertaON

	new(DT dt) {
		dtON = dt
	}

	def List<Oferta> getOfertasRecibidas() {
		LigaMaster.instance.mercado.getOfertasRecibidas(dtON)
	}

	def List<Oferta> getOfertasEnviadas() {
		LigaMaster.instance.mercado.getOfertasEnviadas(dtON)
	}

	def void aceptarOferta() {
		if (!ofertasRecibidas.contains(ofertaON))
			throw new UserException("No podás aceptar esa oferta")

		// Ofertante
		if (ofertaON.dtOfertante.slots < ofertaON.dtOfertante.cantJugadores + 1)
			throw new UserException("El DT ofertante no tiene suficiente slots")

		if (ofertaON.dtOfertante.plata < ofertaON.monto)
			throw new UserException("El DT ofertante no tiene esa plata")

		// Receptor
		if (dtON.slots < dtON.cantJugadores + ofertaON.jugadoresOfrecidos.size)
			throw new UserException("No tenés suficientes slots")

		ofertaON.aceptar

		ObservableUtils.firePropertyChanged(this, "ofertasRecibidas")

		guardar
	}

	def void rechazarOferta() {
		ofertaON.rechazar

		ObservableUtils.firePropertyChanged(this, "ofertasRecibidas")
		ObservableUtils.firePropertyChanged(this, "ofertasEnviadas")

		guardar
	}

	def void guardar() {
		LigaMaster.instance.guardarBase
	}
}
