package controller
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import master.LigaMaster
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.api.Result

@Controller
class MasterController {

	extension JSONUtils = new JSONUtils
	
	@Get("/busqueda/jugadores")
	def Result jugadores() {
		val jugadores = LigaMaster.instance.getListaJugador
		response.contentType = ContentType.APPLICATION_JSON
		ok(jugadores.toJson)
	}
	
	
	def static void main(String[] args) {
		XTRest.start(MasterController, 9000)
	}

}