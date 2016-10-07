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
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

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
		createMaquinaPanel(new Panel(panel))
	}

	def createTransferPanel(Panel panel) {
		new Label(panel).text = "\n\n\n\n\n\n\n\n\n\n"
		new Button(panel) => [
			caption = "<="
			onClick[
				modelObject.validar
				modelObject.transferIn
			]
			bindEnabledToProperty("esMaster")
		]

		new Button(panel) => [
			caption = "=>"
			onClick[
				modelObject.validar
				modelObject.transferOut
			]
			bindEnabledToProperty("esMaster")
		]
	}

	def void createDTPanel(Panel panel) {
		new LabeledTextBox(panel) => [
			text = "Nombre: "
			bindValueToProperty("dtON.nombreDT")
			width = 85
		]

		new LabeledTextBox(panel) => [
			text = "Equipo: "
			bindValueToProperty("dtON.nombreEquipo")
			width = 95
		]

		new LabeledTextBox(panel) => [
			text = "Plata: "
			bindValueToProperty("dtON.plata")
			width = 110
			enabled = "esMaster"
		]

		new LabeledTextBox(panel) => [
			text = "Cantidad Jugadores: "
			bindValueToProperty("dtON.cantJugadores")
		]

		new LabeledTextBox(panel) => [
			text = "Torneos Restantes: "
			bindValueToProperty("dtON.torneosDisponibles")
			enabled = "esMaster"
		]


		new LabeledTextBox(panel) => [
			text = "Slots: "
			bindValueToProperty("dtON.slots")
			enabled = "esMaster"
		]

		new Button(panel) => [
			caption = "Comprar Slot"
			onClick[modelObject.comprarSlot]
			fontSize = 10
		]

		new Button(panel) => [
			caption = "Ofertas"
			onClick[new OfertasWindow(this, modelObject.dtActivo).open]
			fontSize = 10
		]
		
		new Button(panel) => [
			caption = "Mercado"
			onClick[new TransferiblesWindow(this, modelObject.dtActivo).open]
			fontSize = 10
		]

	}

	def void createEquipoPanel(Panel panel) {
		new Selector(panel) => [
			bindItemsToProperty("listaDT").adapter = new PropertyAdapter(DT, "nombreDT")
			bindValueToProperty("dtON")
			width = 300
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("dtON.listaJugadores")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 18

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
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout

		new LabeledNumericField(buttonPanel) => [
			text = "Precio: "
			bindValueToProperty("jugadorON.precioVenta")
			bindEnabledToProperty("jugadorPropio")
			width = 80
		]

		new Button(buttonPanel) => [
			caption = "Ofertar"
			fontSize = 10
			onClick[
				modelObject.validarOfertar
				new CrearOfertaWindow(this, modelObject).open
			]
		]

		new Button(buttonPanel) => [
			caption = "Vender A Máquina"
			fontSize = 10
			onClick[modelObject.venderAMaquina]
		]
	}

	def createMaquinaPanel(Panel panel) {
		new Label(panel) => [
			text = "Lista Máquina"
			fontSize = 12
		]

		new Table(panel, Jugador) => [
			bindItemsToProperty("listaMaquina")
			bindValueToProperty("jugadorON")
			numberVisibleRows = 18

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
				bindContentsToProperty("precioMaquina")
				fixedSize = 65
			]
			new Column(it) => [
				title = "Propietario"
				bindContentsToProperty("propietario.nombreDT")
				fixedSize = 80
			]
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout

		new TextBox(buttonPanel) => [
			bindValueToProperty("textoBusqueda")
			width = 180
			fontSize = 12
		]

		new Button(buttonPanel) => [
			caption = "Buscar"
			onClick[modelObject.buscar]
			fontSize = 10
			setAsDefault
		]

		new Button(buttonPanel) => [
			caption = "Comprar A Máquina"
			onClick[
				modelObject.validar
				modelObject.comprarAMaquina
			]
			fontSize = 10
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
