package master

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import adapter.JSONAdapter
import adapter.JSONTransformer
import java.util.List

@Observable
@Accessors
class LigaMaster {
	static LigaMaster instance
	List<Torneo> listaTorneos
	List<DT> listaDT
	List<Jugador> listaJugador

	private new() {
		initialize
	}

	def void initialize() {
		listaTorneos = newArrayList
		listaDT = newArrayList
		listaJugador = newArrayList
	}

	def DT getMaster() {
		new DT => [nombreDT = "Master"]
	}

	def Set<DT> getDTsQuePagan() {
		listaDT.filter[torneosDisponibles == 0].toSet
	}

	def Set<Jugador> getListaTransferibles() {
		listaJugador.filter[precioVenta > 0].toSet
	}

	def void leerBase() {
		initialize
		JSONAdapter.leerBase
	}

	def void guardarBase() {
		JSONTransformer.guardarBase
	}

	def void addTorneo(Torneo torneo) {
		listaTorneos.add(torneo)
	}

	def void removeTorneo(Torneo torneo) {
		listaTorneos.remove(torneo)
	}

	def static getInstance() {
		if(instance == null) instance = new LigaMaster
		instance
	}

	def getPropietario(Jugador jugador) {
		val libre = new DT => [nombreDT = "Libre"]
		listaDT.findFirst[listaJugadores.contains(jugador)] ?: libre
	}

	def crearDT(String dtNuevo, String dtEquipo) {
		listaDT.add(new DT => [
			nombreDT = dtNuevo
			nombreEquipo = dtEquipo
		])
		guardarBase
	}

	def void update() {
		listaDT.forEach[listaJugadores.forEach[update]]
	}

	// Cálculo del Historial
	def List<Partido> getPartidosJugados(DT dt, DT otroDT) {
		listaTorneos.map[listaPartidos].flatten.filter[getJugoPartido(dt) && getJugoPartido(otroDT) && terminado].toList
	}

	def int getPartidosGanados(DT dt, DT otroDT) {
		getPartidosJugados(dt, otroDT).filter[getPuntos(dt) == 3].size
	}

	def int getPartidosEmpatados(DT dt, DT otroDT) {
		getPartidosJugados(dt, otroDT).filter[getPuntos(dt) == 1].size
	}

	def int getPartidosPerdidos(DT dt, DT otroDT) {
		getPartidosJugados(dt, otroDT).filter[getPuntos(dt) == 0].size
	}
}
