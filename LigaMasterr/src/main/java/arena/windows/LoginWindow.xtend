package arena.windows

import arena.components.LabeledTextBox
import arena.models.LoginModel
import master.DT
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class LoginWindow extends Dialog<LoginModel> {

	new(WindowOwner parent) {
		super(parent, new LoginModel)
		title = "Login"
	}

	override createMainTemplate(Panel panel) {
		new Label(panel) => [
			text = "LOGIN"
		]
		new Selector(panel) => [
			bindItemsToProperty("listaDT").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtON")
			width = 100
		]

		new Button(panel) => [
			caption = "Entrar"
			onClick[
				close
				new TorneoWindow(this, modelObject).open
			]
		]

		new LabeledTextBox(panel) => [
			text = "Nombre: "
			bindValueToProperty("dtNuevo")
		]

		new LabeledTextBox(panel) => [
			text = "Equipo: "
			bindValueToProperty("dtEquipo")
		]

		new Button(panel) => [
			caption = "CrearDT"
			onClick[modelObject.addDT]
		]
	}

	override protected createFormPanel(Panel mainPanel) {}

}
