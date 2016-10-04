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

class TablaWindow extends Dialog<TablaModel> {

	new(WindowOwner owner, Torneo model) {
		super(owner, new TablaModel(model))
		title = "Estadisticas"
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
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]
			
			new Column(it) => [
				title = "GF"
				bindContentsToProperty("golesFavor")
				fixedSize = 55
			]
			
			new Column(it) => [
				title = "GC"
				bindContentsToProperty("golesContra")
				fixedSize = 55
			]
			
			new Column(it) => [
				title = "Dif Gol"
				bindContentsToProperty("difGol")
				fixedSize = 55
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
			numberVisibleRows = 8
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
			numberVisibleRows = 8
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombreDT")
				fixedSize = 85
			]

			new Column(it) => [
				title = "Rojas"
				bindContentsToProperty("rojas")
				fixedSize = 40
			]

			new Column(it) => [
				title = "Amarillas"
				bindContentsToProperty("amarillas")
				fixedSize = 65
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
class TablaModel {
	List<EstadisticaDT> listaPosiciones = newArrayList
	List<EstadisticaDT> listaFairPlay = newArrayList
	List<EstadisticaJugador> listaGoleadores = newArrayList

	new(Torneo torneo) {
		torneo.listaPosiciones.forEach [ listaPosiciones.add(new EstadisticaDT(it, torneo)) ]
		torneo.listaGoleadores.forEach [ listaGoleadores.add(new EstadisticaJugador(it, torneo)) ]
		listaFairPlay = listaPosiciones.sortBy[puntosFairPlay]
	}
}

@Observable
@Accessors
class EstadisticaDT {
	String nombreDT
	int puntos
	int amarillas
	int rojas
	int puntosFairPlay
	int golesFavor
	int golesContra
	int difGol
	
	new(DT dt, Torneo torneo) {
		nombreDT = dt.nombreDT
		puntos = torneo.getPuntos(dt)
		amarillas = torneo.getAmarillas(dt)
		rojas = torneo.getRojas(dt)
		puntosFairPlay = torneo.getPuntosFairPlay(dt)
		golesFavor = torneo.getGolesFavor(dt)
		golesContra = torneo.getGolesContra(dt)
		difGol = torneo.getDiferenciaGol(dt)
	}
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
