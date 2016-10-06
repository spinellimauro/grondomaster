package arena.windows

import arena.components.LabeledTextBox
import arena.models.PremiosTorneosModel
import arena.models.TorneoModel
import datos.PremioPosicion
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import datos.PremioEvento

class PremiosTorneoWindow extends Dialog<PremiosTorneosModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new PremiosTorneosModel(model))
		title = "Premios"
	}
	
	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createPremiosPanel(new Panel(panel))
		createEventosPanel(new Panel(panel))
	}
	
	def void createPremiosPanel(Panel panel) {

		new Table(panel, PremioPosicion) => [
			bindItemsToProperty("listaPosiciones")
			bindValueToProperty("posicionON")
			numberVisibleRows = 20

			new Column(it) => [
				title = "Posicion"
				bindContentsToProperty("posicion").transformer = [ int posicion | posicion +"º" ]
				fixedSize = 60
			]

			new Column(it) => [
				title = "Premio"
				bindContentsToProperty("premio")
				fixedSize = 60
			]
		]

		new LabeledTextBox(panel) => [
			bindTextToProperty("posicionON.posicion")
			bindValueToProperty("posicionON.premio")
			enabled = "esMaster"
			width = 50
		]
	}
	
	def void createEventosPanel(Panel panel) {

		new Table(panel, PremioEvento) => [
			bindItemsToProperty("listaEventos")
			bindValueToProperty("eventoON")
			numberVisibleRows = 4

			new Column(it) => [
				title = "Evento"
				bindContentsToProperty("evento")
				fixedSize = 80
			]

			new Column(it) => [
				title = "Premio"
				bindContentsToProperty("premio")
				fixedSize = 60
			]
		]

		new LabeledTextBox(panel) => [
			bindTextToProperty("eventoON.evento")
			bindValueToProperty("eventoON.premio")
			enabled = "esMaster"
			width = 50
		]
	}
	override protected createFormPanel(Panel mainPanel) {}
}