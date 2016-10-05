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
	boolean habilitado = true
	double precioVenta = 0
	int vecesNoPagadas = 0
	
	def double getImpuesto() {
		Precios.instance.getPrecio(this) * (Precios.instance.getPrecio("Impuesto") / 100)
	}

	def getPrecioMaquina() {
		Precios.instance.getPrecio(this)
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

	def DT getPropietario() {
		LigaMaster.instance.getPropietario(this)	
	}

	def void update() {
		val instance = Jsoup.connect("http://sofifa.com/player/" + id).userAgent("Mozilla").post.select("td.text-center > span.label")
		nivel = Integer.parseInt(instance.get(0).text)
		potencial = Integer.parseInt(instance.get(1).text)
	}

	override equals(Object obj) {
		if (obj == null)
			return false
		if (!Jugador.isAssignableFrom(obj.class))
			return false

		val otroJugador = obj as Jugador
		
		id == otroJugador.id
	}

	override hashCode() {
		id
	}
	
	
}
