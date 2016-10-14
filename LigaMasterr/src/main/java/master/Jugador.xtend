package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.uqbar.commons.utils.Observable
import datos.Precios

@Observable
@Accessors
class Jugador {
	int id
	String nombre
	int nivel
	int potencial
	int lesion
	boolean habilitado = true
	double precioVenta = 0
	int vecesNoPagadas = 0

	// Impuestos
	def double getImpuesto() {
		Precios.instance.getPrecio(this) * (Precios.instance.getPrecio("Impuesto") / 100)
	}

	def void noSePago() {
		vecesNoPagadas++
		habilitado = false
	}

	def void pagar() {
		vecesNoPagadas = 0
		habilitado = true
	}

	def boolean getPagaImpuesto() {
		nivel > 82
	}


	// Mercado
	def double getPrecioMaquina() {
		Precios.instance.getPrecio(this)
	}

	def DT getPropietario() {
		LigaMaster.instance.getPropietario(this)
	}

	// Actualizar Stats
	def void update() {
		val instance = Jsoup.connect("http://sofifa.com/player/" + id).userAgent("Mozilla").post.select(
			"td.text-center > span.label")
		nivel = Integer.parseInt(instance.get(0).text)
		potencial = Integer.parseInt(instance.get(1).text)
	}

	// Lesion
	def boolean estaLesionado() {
		lesion > 0
	}

	def void incLesion() {
		lesion++
	}

	def void decLesion() {
		lesion--
	}

	// Comparación
	override equals(Object obj) {
		if(obj == null) return false
		if(!Jugador.isAssignableFrom(obj.class)) return false

		val otroJugador = obj as Jugador
		id == otroJugador.id
	}

	override hashCode() {
		id
	}
}
