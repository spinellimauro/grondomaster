package arena.windows

import arena.models.PartidoModel
import arena.models.TorneoModel
import java.awt.Color
import master.Jugador
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column

class PartidoWindow extends SimpleWindow<PartidoModel> {
	new(WindowOwner parent, TorneoModel model) {
		super(parent, new PartidoModel(model))
		title = modelObject.partidoON.dtLocal.nombreDT + " vs. " + modelObject.partidoON.dtVisitante.nombreDT
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createNoDisponiblePanel(new Panel(panel))
		createEquipoPanel(new Panel(panel), "Local")
		createPartidoPanel(new Panel(panel))
		createEquipoPanel(new Panel(panel), "Visitante")
		createAmonestadosPanel(new Panel(panel))
	}

	def void createNoDisponiblePanel(Panel panel) {
		new Label(panel) => [
			text = "Suspendidos"
			fontSize = 10
		]

		new List(panel) => [
			bindItemsToProperty("suspendidos").adapter = new PropertyAdapter(Jugador, "nombre")
			height = 65
			width = 85
		]

		new Label(panel) => [
			text = "Lesionados"
			fontSize = 10
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("lesionados")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 4

			new Column(it) => [
				bindContentsToProperty("nombre")
				fixedSize = 85
			]

			new Column(it) => [
				title = "Fechas"
				bindContentsToProperty("lesion")
				fixedSize = 50
			]
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(buttonPanel).text = "                  "
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.incLesion]
			bindEnabledToProperty("lesionesON")
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.decLesion]
			bindEnabledToProperty("lesionesON")
		]
	}

	def void createEquipoPanel(Panel panel, String dt) {
		new Label(panel) => [
			bindValueToProperty("partidoON.dt" + dt + ".nombreDT")
			fontSize = 12
		]
		new List(panel) => [
			bindItemsToProperty("equipo" + dt).adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			height = 215
			width = 85

		]
	}

	def void createPartidoPanel(Panel panel) {
		new Label(panel).text = "\n"
		new Label(panel) => [
			bindValueToProperty("partidoON.score")
			fontSize = 30
		]

		new Label(panel) => [
			text = "Goles"
			fontSize = 10
		]
		val golesPanel = new Panel(panel).layout = new HorizontalLayout
		new List(golesPanel) => [
			bindItemsToProperty("partidoON.golesLocal").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			height = 100
			width = 85
		]
		new List(golesPanel) => [
			bindItemsToProperty("partidoON.golesVisitante").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			height = 100
			width = 85
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(buttonPanel).text = "\t          "
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.addGol]
			bindEnabledToProperty("esMaster")
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.removeGol]
			bindEnabledToProperty("esMaster")
		]
	}

	def void createAmonestadosPanel(Panel panel) {
		new Label(panel) => [
			text = "Amarillas"
			fontSize = 10
		]
		new List(panel) => [
			bindItemsToProperty("partidoON.listaAmarillas").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			height = 50
			width = 85
		]

		val amarillaPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(amarillaPanel).text = "         "
		new Button(amarillaPanel) => [
			caption = "+"
			onClick[|modelObject.addAmarilla]
			background = Color.YELLOW
			bindEnabledToProperty("esMaster")
		]
		new Button(amarillaPanel) => [
			caption = "-"
			onClick[|modelObject.removeAmarilla]
			background = Color.YELLOW
			bindEnabledToProperty("esMaster")
		]

		new Label(panel) => [
			text = "Rojas"
			fontSize = 10
		]
		new List(panel) => [
			bindItemsToProperty("partidoON.listaRojas").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			height = 50
			width = 85
		]

		val rojaPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(rojaPanel).text = "         "
		new Button(rojaPanel) => [
			caption = "+"
			onClick[|modelObject.addRoja]
			background = Color.RED
			bindEnabledToProperty("esMaster")
		]

		new Button(rojaPanel) => [
			caption = "-"
			onClick[|modelObject.removeRoja]
			background = Color.RED
			bindEnabledToProperty("esMaster")
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}

}
