package arena.windows

import arena.components.LabeledSelector
import arena.models.LoginModel
import arena.models.TorneoModel
import master.Partido
import master.Torneo
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
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

	def void createMenuPanel(Panel panel) {
		new Button(panel) => [
			caption = "Crear"
			fontSize = 10
			onClick[
				modelObject.addTorneo()
				new TorneoConfigWindow(this, modelObject.torneoON).open
			]
			bindEnabledToProperty("esMaster")
			width = 150
		]
		new Button(panel) => [
			caption = "Eliminar"
			onClick[modelObject.removeTorneo]
			fontSize = 10
			bindEnabledToProperty("esMaster")
		]

		new Button(panel) => [
			caption = "Editar"
			onClick[new TorneoConfigWindow(this, modelObject.torneoON).open]
			fontSize = 10
			bindEnabledToProperty("esMaster")
		]
		
		new Button(panel) => [
			caption = "Sortear Fixture"
			onClick[modelObject.sortearFechas]
			fontSize = 10
			bindEnabledToProperty("esMaster")
		]
		
		new Button(panel) => [
			caption = "Terminar Torneo"
			onClick[|modelObject.terminarTorneo]
			fontSize = 10
			bindEnabledToProperty("esMaster")
		]

	}

	def void createFechaPanel(Panel panel) {
		val selectorPanel = new Panel(panel).layout = new HorizontalLayout
		
		new LabeledSelector(selectorPanel) => [
			text = "Torneo: "
			label.fontSize = 12
			bindItemsToProperty("listaTorneos").adapter = new PropertyAdapter(Torneo, "nombreTorneo")
			bindValueToProperty("torneoON")
			width = 80
		]

		new LabeledSelector(selectorPanel) => [
			text = "Fecha: "
			label.fontSize = 12
			bindItemsToProperty("listaFechas")
			bindValueToProperty("fechaON")
		]

		new Table(panel, Partido) => [
			bindItemsToProperty("fecha")
			bindValueToProperty("partidoON")
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

			new Column(it) => [
				title = "Terminado"
				bindContentsToProperty("terminado").transformer = [terminado|if(terminado) "Si" else "No"]
				fixedSize = 80
			]
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Button(buttonPanel) => [
			caption = "Ver Partido"
			onClick[new PartidoWindow(this, modelObject).open]
			fontSize = 10
		]
		
		new Button(buttonPanel) => [
			caption = "Terminar Partido"
			onClick[|modelObject.terminarPartido]
			bindEnabledToProperty("esMaster")
			fontSize = 10
		]
	}

	def void createTorneoPanel(Panel panel) {

		new Button(panel) => [
			caption = "Equipos"
			onClick[new EquipoWindow(this, modelObject).open]
			fontSize = 10
			width = 150
		]

		new Button(panel) => [
			caption = "Reglas"
			onClick[new ReglasWindow(this,modelObject.dtON).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Premios"
			onClick[new PremiosTorneoWindow(this, modelObject).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Estadísticas"
			onClick[new EstadisticasWindow(this, modelObject.torneoON).open]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Historial"
			onClick[new HistorialWindow(this, modelObject.dtON).open]
			fontSize = 10
		]
		
		new Button(panel) => [
			caption = "Opciones"
			onClick[new OpcionesWindow(this, modelObject.dtON).open]
			fontSize = 10
		]
		
		new Button(panel) => [
			caption = "Update"
			onClick[modelObject.update]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Salir"
			onClick[
				modelObject.guardar
				close
				new LoginWindow(this).open
			]
			fontSize = 10
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
