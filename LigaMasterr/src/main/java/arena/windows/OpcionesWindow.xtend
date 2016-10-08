package arena.windows

import arena.models.Opciones
import master.DT
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class OpcionesWindow extends Dialog<Opciones> {

	new(WindowOwner parent, DT model) {
		super(parent, new Opciones(model))
		title = "Historial"
	}

	override createMainTemplate(Panel panel) {
		new Label(panel)=>[
			text = "Contraseña Actual: "
			width = 95
		]
		
		new PasswordField(panel)=>[
			bindValueToProperty("passwordON")
			width = 95
		]
		
		new Label(panel)=>[
			text = "Nueva Contraseña: "
			width = 95
		]
		
		new PasswordField(panel)=>[
			bindValueToProperty("nuevaPassword")
			width = 95
		]
		
		new Button(panel)=>[
			caption = "Cambiar Contraseña"
			onClick[
				modelObject.cambiarContraseña
				close
			]
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}