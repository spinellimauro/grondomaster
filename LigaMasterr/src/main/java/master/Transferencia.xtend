package master

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Transferencia {
	String dtCompra
	String dtVende
	double monto
	String jugadorComprado
}