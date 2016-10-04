package adapter

import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import com.eclipsesource.json.WriterConfig
import java.io.PrintWriter
import master.DT
import master.Jugador
import master.LigaMaster
import master.Oferta
import master.Partido
import master.Torneo
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import datos.Mercado

@Observable
@Accessors
final class JSONTransformer {
	def static void guardarBase() {
		val jsonTorneos = LigaMaster.instance.listaTorneos.fold(new JsonArray)[array, torneo|array.add(torneo.toJSON)]
		guardarArchivo(jsonTorneos, "torneos")

		var jugadores = LigaMaster.instance.listaDT.map[listaJugadores].flatten

		val jsonJugadores = jugadores.fold(new JsonArray)[array, jugador|array.add(jugador.toJSON)]
		guardarArchivo(jsonJugadores, "jugadores")

		val jsonDts = LigaMaster.instance.listaDT.fold(new JsonArray) [ array, dt |
			if(!dt.equals(LigaMaster.instance.master)) array.add(dt.toJSON)
		]
		guardarArchivo(jsonDts, "dts")

		val jsonMercado = Mercado.instance.listaOfertas.fold(new JsonArray)[array, oferta|array.add(oferta.toJSON)]
		guardarArchivo(jsonMercado, "mercado")
	}

	def static guardarArchivo(JsonArray json, String nombreArchivo) {
		var printer = new PrintWriter("data/" + nombreArchivo + ".json")
		json.writeTo(printer, WriterConfig.PRETTY_PRINT)
		printer.close
	}

	def static toJSON(Jugador jugador) {
		new JsonObject => [
			add("id", jugador.id)
			add("nombre", jugador.nombre)
			add("nivel", jugador.nivel)
			add("potencial", jugador.potencial)
			add("precio", jugador.precioVenta)
			add("noPagadas", jugador.vecesNoPagadas)
			add("habilitado", jugador.habilitado)
		]
	}

	def static toJSON(DT dt) {
		new JsonObject => [
			add("nombre", dt.nombreDT)
			add("equipo", dt.nombreEquipo)
			add("plata", dt.plata)
			add("slots", dt.slots)
			add("jugadores", new JsonArray => [dt.getListaJugadores.forEach[jugador|add(jugador.id)]])
			add("torneos", dt.torneosDisponibles)
		]
	}

	def static toJSON(Oferta oferta) {
		new JsonObject => [
			add("ofertante", oferta.dtOfertante.nombreDT)
			add("receptor", oferta.dtReceptor.nombreDT)
			add("monto", oferta.monto)
			add("jugador", oferta.jugadorOfertado.id)
			add("jugadoresOfertados", new JsonArray => [oferta.jugadoresOfrecidos.map[id].forEach[id|add(id)]])
		]
	}

	def static toJSON(Torneo torneo) {
		new JsonObject => [
			add("torneo", torneo.nombreTorneo)
			add("dts", new JsonArray => [torneo.listaParticipantes.forEach[dt|add(dt.nombreDT)]])
			add("partidos", new JsonArray => [torneo.listaPartidos.forEach[partido|add(partido.toJSON)]])
			add("limiteAmarillas", torneo.limiteAmarillas)
		]
	}

	def static toJSON(Partido partido) {
		new JsonObject => [
			add("fecha", partido.numeroFecha)
			add("local", partido.dtLocal.nombreDT)
			add("visitante", partido.dtVisitante.nombreDT)
			add("golesLocal", new JsonArray => [partido.golesLocal.forEach[jugador|add(jugador.id)]])
			add("golesVisitante", new JsonArray => [partido.golesVisitante.forEach[jugador|add(jugador.id)]])
			add("amarillas", new JsonArray => [partido.listaAmarillas.forEach[jugador|add(jugador.id)]])
			add("rojas", new JsonArray => [partido.listaRojas.forEach[jugador|add(jugador.id)]])
			add("terminado", partido.terminado)
		]
	}
}
