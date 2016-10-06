package arena.windows

import arena.models.TransferiblesModel
import master.DT
import master.Jugador
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class TransferiblesWindow extends Dialog<TransferiblesModel>{
	
	new(WindowOwner owner, DT model) {
		super(owner, new TransferiblesModel(model))
	}
	
	override createMainTemplate(Panel panel){
		createListaPanel(panel)
		createActionsPanel(panel)
	}	
	
	def void createListaPanel(Panel panel){
		new Table(panel,Jugador) => [
			bindItemsToProperty("transferibles")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 8
			
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
			]
			new Column(it) => [
				title = "Nivel"
				bindContentsToProperty("nivel")
				fixedSize = 45
			]
			new Column(it) => [
				title = "Potencial"
				bindContentsToProperty("potencial")
				fixedSize = 65
			]
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precioVenta")
				fixedSize = 65
			]
			new Column(it) => [
				title = "Propietario"
				bindContentsToProperty("propietario.nombreDT")
				fixedSize = 80
			]
		]
	}
	
	override addActions(Panel panel){
		new Button(panel) => [
			caption = "Comprar"
			onClick[modelObject.comprarJugador]
		]
	}
	
	override protected createFormPanel(Panel mainPanel) { }
}