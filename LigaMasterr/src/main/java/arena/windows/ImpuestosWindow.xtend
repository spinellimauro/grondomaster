package arena.windows

import arena.models.ImpuestoModel
import arena.models.TorneoConfigModel
import master.Jugador
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.VerticalLayout

class ImpuestosWindow extends Dialog<ImpuestoModel> {
	new(WindowOwner owner, TorneoConfigModel model) {
		super(owner, new ImpuestoModel(model))
		title = "Equipos"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout

		createSinPagarPanel(new Panel(panel))
		createPagarPanel(new Panel(panel))
		createAPagarPanel(new Panel(panel))
		createEstadoPanel(new Panel(panel))
	}

	def void createSinPagarPanel(Panel panel) {
		new Label(panel) => [
			text = "Sin Pagar"
			fontSize = 12
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("jugadoresSinPagar")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 80
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 40
			]
			new Column(it) => [
				title = "Impuesto"
				bindContentsToProperty("impuesto")
				fixedSize = 80
			]
		]
	}

	def void createAPagarPanel(Panel panel) {
		new Label(panel) => [
			text = "A Pagar"
			fontSize = 12
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("jugadoresAPagar")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 8

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 80
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 40
			]
			new Column(it) => [
				title = "Impuesto"
				bindContentsToProperty("impuesto")
				fixedSize = 80
			]
		]
	}

	def void createPagarPanel(Panel panel) {
		new Label(panel).text = "\n\n\n\n"
		new Button(panel) => [
			caption = "<="
			onClick[modelObject.addSinPagar()]
		]

		new Button(panel) => [
			caption = "=>"
			onClick[modelObject.addAPagar()]
		]
	}

	def void createEstadoPanel(Panel panel) {
		val panelPlata = new Panel(panel).layout = new VerticalLayout

		new Label(panelPlata) => [
			text = "Plata Disponible"
			fontSize = 12
		]

		new Label(panelPlata) => [
			bindValueToProperty("dtON.plata")
			fontSize = 12
		]

		val panelImpuestos = new Panel(panel).layout = new VerticalLayout

		new Label(panelImpuestos) => [
			text = "Suma Impuestos"
			fontSize = 12
		]

		new Label(panelImpuestos) => [
			bindValueToProperty("impuestos")
			fontSize = 12
		]

		new Button(panel) => [
			caption = "Pagar Impuestos"
			onClick[
				modelObject.pagarImpuestos()
				modelObject.deshabilitar()
			]
			bindEnabledToProperty("habilitado")
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
}
