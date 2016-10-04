package arena.windows

import arena.components.LabeledSelector
import arena.models.LoginModel
import arena.models.TorneoModel
import master.Partido
import master.Torneo
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class TorneoWindow extends SimpleWindow<TorneoModel> {

	new(WindowOwner parent, LoginModel model) {
		super(parent, new TorneoModel(model))
		title = "Liga Master"

	}

	override createMainTemplate(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		createTorneoPanel(new Panel(mainPanel))
		createFechaPanel(new Panel(mainPanel))
		createMenuPanel(new Panel(mainPanel))
	}

	def createMenuPanel(Panel panel) {
		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		new Label(panelHorizontal).text = "        "
		new TextBox(panelHorizontal) => [
			bindValueToProperty("nombreNuevoTorneo")
		]
		new Button(panelHorizontal) => [
			caption = "Crear"
			width = 50
			height = 30
			onClick[modelObject.crearTorneo()]
		]
		new Button(panelHorizontal) => [
			caption = "Eliminar"
			width = 50
			height = 30
		]

		new Button(panel) => [
			caption = "Editar Torneo"
			onClick[new TorneoConfigWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Premios Torneo Actual"
			onClick[new PremiosTorneoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Estadisticas"
			onClick[new TablaWindow(this, modelObject.torneoON).open]
			fontSize = 10
		]
	}

	def createFechaPanel(Panel panel) {

		new Selector(panel) => [
			bindItemsToProperty("listaTorneos").adapter = new PropertyAdapter(Torneo, "nombreTorneo")
			bindValueToProperty("torneoON")
			height = 50
			width = 100
		]

		new LabeledSelector(panel) => [
			text = "\tFecha"
			label.fontSize = 12
			bindItemsToProperty("listaFechas")
			bindValueToProperty("fechaON")
		]

		new Table(panel, Partido) => [
			bindItemsToProperty("fecha")
			bindValueToProperty("partido")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Local"
				bindContentsToProperty("dtLocal.nombreDT")
				fixedSize = 80
			]
			new Column(it) => [
				bindContentsToProperty("score")
				fixedSize = 40
			]
			new Column(it) => [
				title = "Visitante"
				bindContentsToProperty("dtVisitante.nombreDT")
				fixedSize = 80
			]
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Button(buttonPanel) => [
			caption = "Terminar Partido"
			bindEnabledToProperty("partidoActivo")
			onClick[|modelObject.terminarPartido]
		]

		new Button(buttonPanel) => [
			caption = "Ver Partido"
			onClick[new PartidoWindow(this, modelObject).open]
			fontSize = 10
		]

	}

	def void createTorneoPanel(Panel panel) {

		new Button(panel) => [
			caption = "Equipos"
			onClick[new EquipoWindow(this, modelObject).open]
			fontSize = 10
			width = 250
		]

		new Button(panel) => [
			caption = "Reglas"
			onClick[new ReglasWindow(this).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Mercado"
			onClick[new MercadoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Mercado SOFIFA"
			onClick[new MercadoSofifa(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Ofertas"
			onClick[new OfertasWindow(this, modelObject.dtON).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Historial"
			onClick[new HistorialWindow(this, modelObject.dtON).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Update"
			onClick[
				modelObject.update
			]
			fontSize = 10
		]
		
		new Button(panel) => [
			caption = "Guardar"
			onClick[
				modelObject.guardar
			]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Salir"
			onClick[
				close
				new LoginWindow(this).open
			]
			fontSize = 10
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
