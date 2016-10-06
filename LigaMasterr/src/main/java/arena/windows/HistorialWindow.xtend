package arena.windows

import java.util.List
import master.DT
import master.LigaMaster
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.utils.Observable

class HistorialWindow extends Dialog<HistorialModel> {

	new(WindowOwner parent, DT model) {
		super(parent, new HistorialModel(model))
		title = "Historial"
	}

	override createMainTemplate(Panel panel) {
		new Table(panel, Historial) => [
			bindItemsToProperty("listaHistoriales")
			numberVisibleRows = 10

			new Column(it) => [
				title = "vs."
				bindContentsToProperty("dt")
				fixedSize = 120
			]

			new Column(it) => [
				title = "PJ"
				bindContentsToProperty("jugados")
				fixedSize = 35
			]

			new Column(it) => [
				title = "PG"
				bindContentsToProperty("ganados")
				fixedSize = 35
			]

			new Column(it) => [
				title = "PE"
				bindContentsToProperty("empatados")
				fixedSize = 35
			]
			new Column(it) => [
				title = "PP"
				bindContentsToProperty("perdidos")
				fixedSize = 35
			]

			new Column(it) => [
				title = "DIF"
				bindContentsToProperty("diferencia").transformer = [int dif|if(dif > 0) "+" + dif else dif.toString]
				fixedSize = 35
			]
		]
	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {}
}

@Observable
@Accessors
class HistorialModel {
	List<Historial> listaHistoriales = newArrayList

	new(DT dt) {
		for (otroDT : LigaMaster.instance.listaDT) {
			if (otroDT != dt)
				listaHistoriales.add(new Historial(dt, otroDT))
		}

		listaHistoriales = listaHistoriales.sortBy[diferencia].reverse
	}

}

@Observable
@Accessors
class Historial {
	String dt
	int jugados
	int ganados
	int empatados
	int perdidos
	int diferencia

	new(DT dt, DT otroDT) {
		dt = otroDT.nombreDT
		jugados = LigaMaster.instance.getPartidosJugados(dt, otroDT).size
		ganados = LigaMaster.instance.getPartidosGanados(dt, otroDT)
		empatados = LigaMaster.instance.getPartidosEmpatados(dt, otroDT)
		perdidos = LigaMaster.instance.getPartidosPerdidos(dt, otroDT)
		diferencia = ganados - perdidos
	}
}
