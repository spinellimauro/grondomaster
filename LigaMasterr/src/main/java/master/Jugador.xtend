package master

import datos.Precios
import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Jugador {
	int id
	String nombre
	int nivel
	int potencial
	Torneo torneo
	double precioVenta = 0
	int vecesNoPagadas = 0

	new(int integer) {
		id = integer
		update
	}

	new() {
	}

	def double getImpuesto() {
		Precios.instance.getPrecio(this) * (Precios.instance.getPrecio("PorcentajeImpuesto") / 100)
	}

	def void noSePago() {
		vecesNoPagadas++
	}

	def void pagar() {
		vecesNoPagadas = 0
	}

	def boolean getPagaImpuesto() {
		nivel > 82
	}

	def int getGoles() {
		torneo.getGoles(this)
	}

	def void update() {
		val instance = Jsoup.connect("http://2016.sofifa.com/player/" + id).userAgent("Mozilla").post
		nombre = instance.select("div.header").text.replaceAll("[(\\d+.*)]", "").replace("ID:", "").replace("  ", "").
			toString
		nivel = Integer.parseInt(instance.select("span.p").get(0).text.toString)
		potencial = Integer.parseInt(instance.select("span.p").get(1).text.toString)
	}

	override toString() {
		id + ";" + nombre + ";" + nivel + ";" + potencial + ";" + precioVenta + ";" + vecesNoPagadas
	}

	override equals(Object obj) {
		if(obj == null) return false
		if(!Jugador.isAssignableFrom(obj.class)) return false

		val otroJugador = obj as Jugador
		if(id != otroJugador.id) return false else true
	}

	override hashCode() { id }
}