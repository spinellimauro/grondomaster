import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Jugador {
	int id
	int nivel
	int potencial
	String nombre

	double precioVenta = 0
	int vecesNoPagadas = 0

	new(int integer) {
		id = integer
		update
	}

	def double getImpuesto() {
		PreciosNivel.instance.getPrecio(this) * 0.10
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

	def void update() {
		val instance = Jsoup.connect("http://2016.sofifa.com/player/" + id).userAgent("Mozilla").post
		nombre = instance.select("div.header").text.replaceAll("[(\\d+.*)]", "").replace("ID:", "").toString
		nivel = Integer.parseInt(instance.select("span.p").get(0).text.toString)
		potencial = Integer.parseInt(instance.select("span.p").get(1).text.toString)
	}

	override toString() {
		id + ";" + nombre + ";" + nivel + ";" + potencial + "\n"
	}
}
