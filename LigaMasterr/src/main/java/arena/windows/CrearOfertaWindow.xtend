package arena.windows

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import arena.models.EquipoModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import arena.components.LabeledNumericField
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.List
import org.uqbar.arena.bindings.PropertyAdapter
import master.Jugador
import org.uqbar.arena.widgets.Button
import arena.models.CrearOfertaModel

class CrearOfertaWindow extends SimpleWindow<CrearOfertaModel> {

	new(WindowOwner parent, EquipoModel model) {
		super(parent, new CrearOfertaModel(model))
	}

	override createMainTemplate(Panel panel) {
		new Label(panel) => [
			bindValueToProperty("oferta.jugadorOfertado.nombre")
			fontSize = 15
		]

		new LabeledNumericField(panel) => [
			text = "Monto: "
			bindValueToProperty("montoOfertado")
			width = 100
		]

		new Label(panel) => [
			text = "Jugadores a Intercambiar"
			fontSize = 12
		]
		val truequePanel = new Panel(panel).layout = new HorizontalLayout

		new List(truequePanel) => [
			bindItemsToProperty("oferta.dtOfertante.listaJugadores").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			width = 85
			height = 60
		]

		new List(truequePanel) => [
			bindItemsToProperty("listaJugadores").adapter = new PropertyAdapter(Jugador, "nombre")
			bindValueToProperty("jugadorON")
			width = 85
			height = 60
		]

		val buttonPanel = new Panel(panel).layout = new HorizontalLayout
		new Label(buttonPanel).text = "\t       "
		new Button(buttonPanel) => [
			caption = "+"
			onClick[modelObject.addJugador]
			height = 30
			width = 30
		]
		new Button(buttonPanel) => [
			caption = "-"
			onClick[|modelObject.removeJugador]
			height = 30
			width = 30
		]
		
		new Button(panel) => [
			caption = "Enviar Oferta"
			onClick[
				close
				modelObject.enviarOferta
			]
			fontSize = 10
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}
