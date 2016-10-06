package master

import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class DT {
	String nombreDT
	String nombreEquipo
	double plata = 0.0
	Set<Jugador> listaJugadores = newHashSet
	int torneosDisponibles = 3
	int slots = 30

	def void venderJugador(Jugador jugador, double precio) {
		if (!listaJugadores.contains(jugador))
			throw new Exception("Ese jugador no es tuyo")

		incPlata(precio)
		removeJugador(jugador)
	}

	def void comprarJugador(Jugador jugador, double precio) {
		if (plata < precio)
			throw new Exception("No tenés suficiente plata")

		if (cantJugadores == slots)
			throw new Exception("No hay slots disponibles")

		decPlata(precio)
		addJugador(jugador)
		jugador.precioVenta = 0
	}

	def int getCantJugadores() {
		listaJugadores.size
	}

	def void addJugador(Jugador jugador) {
		listaJugadores.add(jugador)
	}

	def void removeJugador(Jugador jugador) {
		listaJugadores.remove(jugador)
	}

	def void comprarSlot() {
		val precioSlot = Precios.instance.getPrecio("Slot")

		if (plata < precioSlot)
			throw new Exception("No tenés suficiente plata")

		slots++
		decPlata(precioSlot)
	}

	def void incPlata(double monto) {
		plata += monto
	}

	def void decPlata(double monto) {
		plata -= monto
	}

	// Impuestos
	def void incTorneos() {
		torneosDisponibles++
	}

	def void decTorneos() {
		torneosDisponibles--
	}

	def boolean getPagaImpuesto() {
		torneosDisponibles == 0
	}

	def List<Jugador> getJugadoresConImpuesto() {
		listaJugadores.filter[pagaImpuesto].toList
	}

	def void pagarImpuesto(List<Jugador> jugadoresAPagar) {
		jugadoresAPagar.forEach[pagarImpuesto]

		var jugadoresNoPagados = newArrayList
		jugadoresNoPagados.addAll(jugadoresConImpuesto)
		jugadoresNoPagados.removeAll(jugadoresAPagar)
		jugadoresNoPagados.forEach[noSePago]

		if(torneosDisponibles != 0) decTorneos else torneosDisponibles = 3
	}

	def void pagarImpuesto(Jugador jugador) {
		decPlata(jugador.impuesto)
		jugador.pagar
	}

	// Comparación
	override equals(Object obj) {
		if (obj == null)
			return false
		if (!DT.isAssignableFrom(obj.class))
			return false

		val otroDT = obj as DT

		nombreDT == otroDT.nombreDT
	}
}
