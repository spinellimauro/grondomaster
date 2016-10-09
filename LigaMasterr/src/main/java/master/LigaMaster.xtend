package master

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.List
import com.thoughtworks.xstream.XStream
import java.io.FileReader
import java.io.PrintWriter
import datos.Mercado

@Observable
@Accessors
class LigaMaster {
	static LigaMaster instance = new LigaMaster
	List<Torneo> listaTorneos = newArrayList(new Torneo => [nombreTorneo = "Nuevo Torneo"])
	List<DT> listaDT = newArrayList
	Mercado mercado = new Mercado

	private new() { }

	def DT getMaster() {
		new DT => [
			nombreDT = "Master"
			password = "ARG123"
		]
	}

	def Set<Jugador> getListaJugador() {
		listaDT.map[listaJugadores].flatten.toSet
	}

	def Set<DT> getDTsQuePagan() {
		listaDT.filter[torneosDisponibles == 0].toSet
	}

	def Set<Jugador> getListaTransferibles() {
		listaDT.map[listaJugador].flatten.filter[precioVenta > 0].toSet
	}

	def void leerBase() {
		try
			instance = new XStream().fromXML(new FileReader("data.xml")) as LigaMaster
		catch (Exception e) { }
	}

	def void guardarBase() {
		val printer = new PrintWriter("data.xml")
		new XStream().toXML(instance, printer)
		printer.close
	}

	def void addDT(DT dt) {
		if (listaDT.exists[nombreDT.equals(dt.nombreDT)])
			throw new Exception("Ese nombre de DT ya está en uso")

		if (listaDT.exists[nombreDT.equals(dt.nombreDT)])
			throw new Exception("Ese nombre de Equipo ya está en uso")

		listaDT.add(dt)
	}

	def void addTorneo(Torneo torneo) {
		listaTorneos.add(torneo)
	}

	def void removeTorneo(Torneo torneo) {
		listaTorneos.remove(torneo)
	}

	def static getInstance() {
		instance
	}

	def DT getPropietario(Jugador jugador) {
		val libre = new DT => [nombreDT = "Libre"]

		listaDT.findFirst[listaJugadores.contains(jugador)] ?: libre
	}

	def void update() {
		listaDT.map[listaJugadores].flatten.forEach[update]
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
