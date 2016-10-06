package arena.windows

import master.DT
import master.Jugador
import master.Torneo
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import java.util.List
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

class EstadisticasWindow extends Dialog<EstadisticasModel> {

	new(WindowOwner owner, Torneo model) {
		super(owner, new EstadisticasModel(model))
		title = "Estadísticas"
	}

	override protected createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout

		val panelPosiciones = new Panel(panel)
		new Label(panelPosiciones) => [
			text = "Posiciones"
			fontSize = 12

		]
		new Table(panelPosiciones, EstadisticaDT) => [
			bindItemsToProperty("listaPosiciones")
			numberVisibleRows = 20

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]

			new Column(it) => [
				title = "PJ"
				bindContentsToProperty("partJugados")
				fixedSize = 35
			]

			new Column(it) => [
				title = "PG"
				bindContentsToProperty("partGanados")
				fixedSize = 35
			]

			new Column(it) => [
				title = "PE"
				bindContentsToProperty("partEmpatados")
				fixedSize = 35
			]

			new Column(it) => [
				title = "PP"
				bindContentsToProperty("partPerdidos")
				fixedSize = 35
			]

			new Column(it) => [
				title = "GF"
				bindContentsToProperty("golesFavor")
				fixedSize = 35
			]

			new Column(it) => [
				title = "GC"
				bindContentsToProperty("golesContra")
				fixedSize = 35
			]

			new Column(it) => [
				title = "DIF"
				bindContentsToProperty("difGol").transformer = [int dif|if(dif > 0) "+" + dif else dif.toString]
				fixedSize = 35
			]

			new Column(it) => [
				title = "Puntos"
				bindContentsToProperty("puntos")
				fixedSize = 55
			]
		]

		val panelGoleadores = new Panel(panel)
		new Label(panelGoleadores) => [
			text = "Goleadores"
			fontSize = 12
		]
		
		new Table(panelGoleadores, EstadisticaJugador) => [
			bindItemsToProperty("listaGoleadores")
			numberVisibleRows = 20
			
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 140
			]

			new Column(it) => [
				title = "Goles"
				bindContentsToProperty("goles")
				fixedSize = 45
			]
		]

		val panelFairPlay = new Panel(panel)
		new Label(panelFairPlay) => [
			text = "Fair Play"
			fontSize = 12
		]
		new Table(panelFairPlay, EstadisticaDT) => [
			bindItemsToProperty("listaFairPlay")
			numberVisibleRows = 20
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]

			new Column(it) => [
				title = "R"
				bindContentsToProperty("rojas")
				fixedSize = 35
			]

			new Column(it) => [
				title = "A"
				bindContentsToProperty("amarillas")
				fixedSize = 35
			]

			new Column(it) => [
				title = "Puntos"
				bindContentsToProperty("puntosFairPlay")
				fixedSize = 55
			]
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
}

@Observable
@Accessors
class EstadisticasModel {
	List<EstadisticaDT> listaPosiciones = newArrayList
	List<EstadisticaDT> listaFairPlay = newArrayList
	List<EstadisticaJugador> listaGoleadores = newArrayList

	new(Torneo torneo) {
		torneo.listaPosiciones.forEach[listaPosiciones.add(new EstadisticaDT(it, torneo))]
		torneo.listaGoleadores.forEach[listaGoleadores.add(new EstadisticaJugador(it, torneo))]
		listaFairPlay = listaPosiciones.sortBy[puntosFairPlay]
	}
}

@Observable
@Accessors
class EstadisticaDT {
	Torneo torneo
	DT dt

	new(DT dtON, Torneo torneoON) {
		dt = dtON
		torneo = torneoON
	}

	def String getNombreDT() { dt.nombreDT }

	def int getPuntos() { torneo.getPuntos(dt) }

	def int getAmarillas() { torneo.getAmarillas(dt) }

	def int getRojas() { torneo.getRojas(dt) }

	def int getPuntosFairPlay() { torneo.getPuntosFairPlay(dt) }

	def int getGolesFavor() { torneo.getGolesFavor(dt) }

	def int getGolesContra() { torneo.getGolesContra(dt) }

	def int getDifGol() { getGolesFavor - getGolesContra }

	def int getPartJugados() { torneo.getPartidosJugados(dt).size }

	def int getPartGanados() { torneo.getPartidosJugados(dt).filter[getPuntos(dt) == 3].size }

	def int getPartEmpatados() { torneo.getPartidosJugados(dt).filter[getPuntos(dt) == 1].size }

	def int getPartPerdidos() { torneo.getPartidosJugados(dt).filter[getPuntos(dt) == 0].size }
}

@Observable
@Accessors
class EstadisticaJugador {
	String nombre
	int goles

	new(Jugador jugador, Torneo torneo) {
		nombre = jugador.nombre
		goles = torneo.getGoles(jugador)
	}
}
