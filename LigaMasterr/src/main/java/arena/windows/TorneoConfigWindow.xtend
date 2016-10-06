package arena.windows

import arena.components.LabeledTextBox
import arena.models.TorneoConfigModel
import arena.models.TorneoModel
import master.DT
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class TorneoConfigWindow extends Dialog<TorneoConfigModel> {

	new(WindowOwner owner, TorneoModel model) {
		super(owner, new TorneoConfigModel(model))
	}

	override createMainTemplate(Panel panel) {
		new LabeledTextBox(panel) => [
			text = "Nombre: "
			bindValueToProperty("textoTorneo")
			width = 100
		]

		val panelHorizontal = new Panel(panel).layout = new HorizontalLayout
		createParticipantesPanel(new Panel(panelHorizontal))
		createTransferPanel(new Panel(panelHorizontal))
		createDTPanel(new Panel(panelHorizontal))
	}

	def void createDTPanel(Panel panel) {
		new Label(panel).text = "Disponibles"

		new List(panel) => [
			bindItemsToProperty("listaDT").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtON")
			height = 100
		]
	}

	def void createTransferPanel(Panel panel) {
		new Label(panel).text = "\n\n\n"
		new Button(panel) => [
			caption = "<="
			onClick[
				if (modelObject.dtON.pagaImpuesto)
					new ImpuestosWindow(this, modelObject).open
				else
					modelObject.addDT
			]
		]

		new Button(panel) => [
			caption = "=>"
			onClick[modelObject.removeDT]
		]
	}

	def void createParticipantesPanel(Panel panel) {
		new Label(panel).text = "Participantes"

		new List(panel) => [
			bindItemsToProperty("torneoON.listaParticipantes").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtON")
			height = 100
		]
	}

	override protected createFormPanel(Panel mainPanel) {}
}
