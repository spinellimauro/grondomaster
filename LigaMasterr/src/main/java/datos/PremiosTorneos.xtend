package datos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class PremiosTorneos {
	List<PremioEvento> listaEventos = newArrayList(
		new PremioEvento("Victoria", 2000.0),
		new PremioEvento("Gol", 1000.0),
		new PremioEvento("Empate", 1000.0)
	)
	
	List<PremioPosicion> listaPosiciones = newArrayList(
		new PremioPosicion(1, 40000.0),
		new PremioPosicion(2, 30000.0),
		new PremioPosicion(3, 20000.0),	
		new PremioPosicion(4, 10000.0)	
	)
	
	def double getPremioEvento(String string) {
		listaEventos.findFirst[evento.equals(string)].premio
	}
	
	def double getPremio(Integer _posicion) {
		listaPosiciones.findFirst[posicion.equals(_posicion)].premio
	}
	
	def crearPremio(double premio){
		listaPosiciones.add(new PremioPosicion(listaPosiciones.size + 1, premio))
	}
	
	def getCantPremios(){
		listaPosiciones.size
	}
	
	
}

@Observable
@Accessors
class PremioEvento{
	String evento
	double premio

	new(String string, double valor) {
		evento = string
		premio = valor
	}
}

@Observable
@Accessors
class PremioPosicion{
	int posicion
	double premio

	new(int integer, double valor) {
		posicion = integer
		premio = valor
	}
}