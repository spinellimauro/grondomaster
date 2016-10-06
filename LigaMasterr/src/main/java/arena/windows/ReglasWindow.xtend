package arena.windows

import arena.components.LabeledTextBox
import arena.models.ReglasModel
import datos.PrecioEvento
import datos.PrecioNivel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import master.DT

class ReglasWindow extends Dialog<ReglasModel> {
	new(WindowOwner owner, DT model) {
		super(owner, new ReglasModel(model))
		title = "Reglas"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createPreciosPanel(new Panel(panel))
		createEventosPanel(new Panel(panel))
	}

	def void createPreciosPanel(Panel panel) {

		new Table(panel, PrecioNivel) => [
			bindItemsToProperty("listaNiveles")
			bindValueToProperty("nivelON")
			numberVisibleRows = 20

			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 40
			]

			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
				fixedSize = 65
			]
		]

		new LabeledTextBox(panel) => [
			bindTextToProperty("nivelON.nivel")
			bindValueToProperty("nivelON.precio")
			enabled = "esMaster"
			width = 50
		]
	}

	def void createEventosPanel(Panel panel) {
		new Table(panel, PrecioEvento) => [
			bindItemsToProperty("listaEventos")
			bindValueToProperty("eventoON")
			numberVisibleRows = 7

			new Column(it) => [
				title = "Evento"
				bindContentsToProperty("evento")
				fixedSize = 100
			]

			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
				fixedSize = 65
			]
		]

		new LabeledTextBox(panel) => [
			bindTextToProperty("eventoON.evento")
			bindValueToProperty("eventoON.precio")
			enabled = "esMaster"
			width = 50
		]
	}
	
	override protected createFormPanel(Panel mainPanel) { }
}
