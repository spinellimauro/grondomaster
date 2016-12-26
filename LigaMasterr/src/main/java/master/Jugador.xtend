package master

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import datos.Precios
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.jsoup.Jsoup
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Jugador {
	
	// Info SoFIFA
	int id = 0
	String nombre = ""
	String nacionalidad = ""
	List<String> posiciones = newArrayList
	int nivel = 0
	int potencial = 0
	
	// Info GrondoMaster
	int lesion = 0
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
	
	@JsonIgnore
	def DT getPropietario() {
		LigaMaster.instance.getPropietario(this)
	}
	
	@JsonProperty("propietario")
	def String getPropietarioNombre() {
		LigaMaster.instance.getPropietario(this).nombreDT
	}

	// Actualizar Stats
	def void update() {
		val instance = Jsoup.connect("http://sofifa.com/player/" + id+ "?hl=es-ES").userAgent("Mozilla").post
		
		val ratings = instance.select("td.text-center > span.label")
		nivel = Integer::parseInt(ratings.get(0).text)
		potencial = Integer.parseInt(ratings.get(1).text)
		
		val data = instance.select( "div.meta > span" )
		nacionalidad = data.select("a > span").attr("title")
		posiciones = newArrayList( data.select("span > span").map[text])
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
