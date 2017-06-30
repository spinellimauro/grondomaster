package controller

import datos.SoFifa
import datos.Transferencia
import master.LigaMaster
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import java.util.List
import master.Jugador
import datos.Precios

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

	@Get("/dt/:nombreDT")
	def Result getDT() {
		val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
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
	
	@Put('/transferibles/:nombreDT/:jugadorID')
	def Result actualizarTransferible(@Body String body) {
	
		 
		val dtComprador = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
		val dtVendedor = LigaMaster.instance.listaDT.findFirst[dt|dt.listaJugadores.findFirst[j|j.id == Integer.parseInt(jugadorID)] != null]
		val jugadorAComprar = dtVendedor.listaJugadores.findFirst[j|j.id == Integer.parseInt(jugadorID)]
		
		
				
		val transferencia = new Transferencia =>[
				dtCompra = dtComprador.nombreDT
				dtVende = dtVendedor.nombreDT
				monto = jugadorAComprar.precioVenta
				jugadorComprado = jugadorAComprar.nombre
		]
//		
////		NO ANDA NOSE PORQUE
		LigaMaster.instance.mercado.agregarTransferencia(transferencia)
		
		
		
		// SOY UN BOLUDO YA HABIA METODOS COMPRAR Y VENDER (DESPUES LO ARREGLO)
		dtComprador.decPlata(jugadorAComprar.precioVenta)
		dtVendedor.incPlata(jugadorAComprar.precioVenta)
		dtComprador.addJugador(jugadorAComprar)
		dtVendedor.removeJugador(jugadorAComprar)
		

		
		LigaMaster.instance.guardarBase
		ok(dtComprador.toJson);
	}

	@Put('/dts/:nombreDT')
	def Result comprarSlot(@Body String body) {
		
		
		val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
		dt.comprarSlot
		LigaMaster.instance.guardarBase
		ok(dt.toJson);
	}
	
	@Put('/sofifa/:nombreDT/:nombreJugador/:jugadorID')
	def Result comprarALaMaquina(@Body String body) {	
		
		
		val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
		val listaJugadores = SoFifa.instance.getJugadores(nombreJugador).toList
		val jugadorAComprar = listaJugadores.findFirst[j|j.id == Integer.parseInt(jugadorID)]
		
		dt.comprarJugador(jugadorAComprar , Precios.instance.getPrecio(jugadorAComprar))
		
		LigaMaster.instance.guardarBase
		ok(dt.toJson);
	}
	
	@Put('/plantel/escudo/:nombreDT/:equipoID/:equipoNombre')
	def Result ajustes(@Body String body) {

		val dt = LigaMaster.instance.listaDT.findFirst[dt|dt.getNombreDT == nombreDT]
		dt.nombreEquipo = equipoNombre
		dt.id = Integer.parseInt(equipoID)
		LigaMaster.instance.guardarBase
		ok(dt.toJson);
	}
	
	@Get("/usuarios/:nombreDT/:password")
	def Result usuarios(){
		val usuarios = LigaMaster.instance.listaDT
		val usuario = usuarios.findFirst[u | u.getNombreDT.toLowerCase.equals(nombreDT.toLowerCase) && u.getPassword.equals(password)]
		//TODO: Tirar excepción si no lo encuentra.
		ok(usuario.toJson)
	}
	def static void main(String[] args) {
		LigaMaster.instance.leerBase
		XTRest.start(MasterController, 9000)
	}
}
