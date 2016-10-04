package datos

import master.Jugador
import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.uqbar.commons.utils.Observable
import java.util.List

@Observable
@Accessors
final class SoFifa {
	static SoFifa instance = new SoFifa

	private new() {
	}

	def List<Jugador> getJugadores(String string) {
		val Document document = Jsoup.connect("http://sofifa.com/players?keyword=" + string).userAgent("Mozilla").post
		val docNombres = document.select("td.nowrap")
		val docAtributes = document.select("span.label")

		var listaJugadores = newArrayList
		var atributeIndex = 0
		for (var n = 0; n < docNombres.size; n++) {
			var jugador = new Jugador

			jugador.id = Integer.parseInt(docNombres.select("a[href]").get(n).attr("abs:href").replace("http://sofifa.com/player/", ""))
			jugador.nombre = docNombres.get(n).select("a").text
			jugador.nivel = Integer.parseInt(docAtributes.get(atributeIndex++).text)
			jugador.potencial = Integer.parseInt(docAtributes.get(atributeIndex++).text)

			listaJugadores.add(jugador)
		}
		
		listaJugadores

	}

	def static SoFifa getInstance() {
		instance
	}
}
