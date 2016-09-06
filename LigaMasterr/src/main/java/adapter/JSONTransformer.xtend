package adapter

import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import master.DT
import master.Jugador
import master.Partido
import master.Torneo

final class JSONTransformer {
	def static String toJSON(Jugador jugador) {
		val json = new JsonObject => [
			add("id", jugador.id)
			add("nombre", jugador.nombre)
			add("nivel", jugador.nivel)
			add("potencial", jugador.potencial)
			add("precio", jugador.precioVenta)
			add("noPagadas", jugador.vecesNoPagadas)
		]

		json.toString
	}

	def static String toJSON(DT dt) {
		val json = new JsonObject => [
			add("nombre", dt.nombreDT)
			add("equipo", dt.nombreEquipo)
			add("plata", dt.plata)
			add("slots", dt.slots)
			add("jugadores", new JsonArray => [dt.getListaJugadores.forEach[jugador|add(jugador.id)]])
			add("fechas", dt.fechasDisponibles)
		]

		json.toString
	}

	def static String toJSON(Torneo torneo) {
		val json = new JsonObject => [
			add("torneo", torneo.nombreTorneo)
			add("dts", new JsonArray => [torneo.listaParticipantes.forEach[dt|add(dt.nombreDT)]])
			add("partidos", new JsonArray => [torneo.listaPartidos.forEach[partido|add(partido.toJSON)]])
		]

		json.toString
	}

	def static String toJSON(Partido partido) {
		val json = new JsonObject => [
			add("fecha", partido.numeroFecha)
			add("local", partido.dtLocal.nombreDT)
			add("visitante", partido.dtVisitante.nombreDT)
			add("golesLocal", new JsonArray => [partido.golesLocal.forEach[jugador|add(jugador.id)]])
			add("golesVisitante", new JsonArray => [partido.golesVisitante.forEach[jugador|add(jugador.id)]])
			add("amarillas",new JsonArray => [partido.listaAmarillas.forEach[jugador|add(jugador.id)]] )
			add("rojas",new JsonArray => [partido.listaRojas.forEach[jugador|add(jugador.id)]] )
			add("terminado", partido.terminado)
		]

		json.toString
	}
}

