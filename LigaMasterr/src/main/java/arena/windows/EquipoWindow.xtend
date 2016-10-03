package arena.windows

import arena.components.LabeledNumericField
import arena.components.LabeledTextBox
import arena.models.EquipoModel
import arena.models.TorneoModel
import master.DT
import master.Jugador
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import master.LigaMaster
import java.awt.Color

class EquipoWindow extends SimpleWindow<EquipoModel> {
	new(WindowOwner owner, TorneoModel model) {
		super(owner, new EquipoModel(model))
		title = "Equipos"
	}

	override createMainTemplate(Panel panel) {
		panel.layout = new HorizontalLayout
		createDTPanel(new Panel(panel))
		createEquipoPanel(new Panel(panel))
		createTransferPanel(new Panel(panel))
	}

	def void createDTPanel(Panel panel) {
		new LabeledTextBox(panel) => [
			text = "Nombre: "
			bindValueToProperty("dtON.nombreDT")
			width = 70
		]

		new LabeledTextBox(panel) => [
			text = "Equipo: "
			bindValueToProperty("dtON.nombreEquipo")
			width = 80
		]

		new LabeledTextBox(panel) => [
			text = "Plata: "
			bindValueToProperty("dtON.plata")
			width = 95
			
		]
		
		new LabeledTextBox(panel) => [
			text = "Torneos Restantes: "
			bindValueToProperty("dtON.torneosDisponibles")
			width = 95
		]
		
		new LabeledTextBox(panel) => [
			text = "Cantidad Jugadores: "
			bindValueToProperty("dtON.cantJugadores")
			width = 95
		]
		
		
		new LabeledTextBox(panel) => [
			text = "Slots: "
			bindValueToProperty("dtON.slots")
			width = 95
		]
		
		new Button(panel)=>[
			caption = "Comprar Slot"
			onClick[
				modelObject.dtON.comprarSlot
				LigaMaster.instance.guardarBase
			]
		]
	
	}

	def void createEquipoPanel(Panel panel) {
		new Label(panel).text = ""
		new Table(panel, Jugador) => [
			bindItemsToProperty("dtON.listaJugadores")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 25

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
				fixedSize = 70
			]
		]

		new LabeledNumericField(panel) => [
			text = "Precio: "
			bindValueToProperty("jugadorON.precioVenta")
			width = 100
		]
		
		new Button(panel) =>[
			caption = "Vender A La Maquina"
			onClick[modelObject.venderJugadorALaMaquina]
		]

	}

	def void createTransferPanel(Panel panel) {
		
		new Label(panel).text = "Jugadores Deshabilitados"
		new Table(panel, Jugador) => [
			bindItemsToProperty("dtON.listaJugadoresDeshabilitados")
			numberVisibleRows = 8
			
			
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 150
				foreground = Color.red
			]
		]
		
		new Selector(panel) => [
			bindItemsToProperty("otrosDT").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtElegido")
			height = 80
		]
		
		
		new Button(panel) => [
			caption = "Ofertar"
			fontSize = 10
			onClick[ new OfertaWindow(this, modelObject).open ]
		]
		new Table(panel, Jugador) => [
			bindItemsToProperty("dtElegido.listaJugadores")
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
		]
		
		
		
		
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
