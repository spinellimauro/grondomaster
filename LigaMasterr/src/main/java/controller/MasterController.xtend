package controller

import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import master.LigaMaster
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.api.Result
import datos.SoFifa
import org.uqbar.xtrest.api.annotation.Body
import master.Jugador
import org.uqbar.xtrest.api.annotation.Put

@Controller
class MasterController {
	extension JSONUtils = new JSONUtils

	@Get("/busqueda/:nombre")
	def Result getBusqueda() {
		val jugadores = SoFifa.instance.getJugadores(nombre)
		response.contentType = ContentType.APPLICATION_JSON
		response.characterEncoding = "utf-8"
		ok(jugadores.toJson)
	}
	
	@Get("/equipos/:nombre")
	def Result getEquipo() {
		val equipos = SoFifa.instance.getEquipos(nombre)
		response.contentType = ContentType.APPLICATION_JSON
		response.characterEncoding = "utf-8"
		ok(equipos.toJson)
	}

	@Get("/mercado")
	def Result getMercado() {
		val jugadores = LigaMaster.instance.listaTransferibles
		response.contentType = ContentType.APPLICATION_JSON
		response.characterEncoding = "utf-8"
		ok(jugadores.toJson)
	}

	@Get("/dt")
	def Result getDT() {
		val dt = LigaMaster.instance.listaDT.get(1)
		response.contentType = ContentType.APPLICATION_JSON
		response.characterEncoding = "utf-8"
		ok(dt.toJson)
	}

	@Get("/dts")
	def Result getDTs() {
		val dts = LigaMaster.instance.listaDT.sortBy[nombreDT]
		response.contentType = ContentType.APPLICATION_JSON
		response.characterEncoding = "utf-8"
		ok(dts.toJson)
	}

	@Get("/torneos")
	def Result getTorneos() {
		val torneos = LigaMaster.instance.listaTorneos
		response.contentType = ContentType.APPLICATION_JSON
		response.characterEncoding = "utf-8"
		ok(torneos.toJson)
	}
	
	@Put('/plantel/:nombreDT/:jugadorID')
	def Result actualizar(@Body String body) {
		
		
		val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
		val jugadorAVender = dt.listaJugadores.findFirst[j|j.id == Integer.parseInt(jugadorID)]
		dt.venderJugador(jugadorAVender,10000)
		LigaMaster.instance.guardarBase
		ok(dt.toJson);
	}
	

	def static void main(String[] args) {
		LigaMaster.instance.leerBase
		XTRest.start(MasterController, 9000)
	}
}
