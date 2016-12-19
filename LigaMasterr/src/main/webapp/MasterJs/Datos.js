function Datos(){
	this.listaDePois = function() {
		var pois = [];
		var bancoX = new Banco();
			bancoX.id = 0;
			bancoX.nombrePoi = "Citi";
			bancoX.barrio = "Avellaneda 1423";
			bancoX.domicilio = bancoX.barrio;
		pois.push(bancoX);

		var localComercialX = new LocalComercial();
			localComercialX.id = 1;
			localComercialX.nombrePoi = "Martita";
			localComercialX.domicilio = "av. marquez 123";
		pois.push(localComercialX);

		var colectivoX = new Colectivo();
			colectivoX.id = 2;
			colectivoX.nombrePoi = "78";
			colectivoX.domicilio = "Esquina Jose 2324";
		pois.push(colectivoX);

		var comunaX = new Comuna();
			comunaX.nombrePoi = "12";
		var cgpX = new CGP();
			cgpX.id = 3;
			cgpX.comunaAsociada = comunaX;
			cgpX.nombrePoi = comunaX.nombrePoi;
			cgpX.domicilio = "av. juan b justo 1123";
		pois.push(cgpX);
		return pois;	  	
	}; 
	this.listaDeUsuarios = function(){
		var usuarios = [];
		usuarios.push(new Usuario("Pole","elMasTurro"));
		usuarios.push(new Usuario("Torres","elMasCapitos"));
		usuarios.push(new Usuario("Mauro","seDejaPorTorres"));
		usuarios.push(new Usuario("FaVio","elKpoDeSuarez"));
		usuarios.push(new Usuario("Gabo","elDesaparecido"));
		return usuarios;
	}

	this.listaDeOpiniones = function(){
		var opiniones = [];
		var opinionX = new Opinion();
			opinionX.comentario = "Buen servicio";
			opinionX.calificacion = 5;
			opinionX.usuario = "Pole";
		opiniones.push(opinionX);

		var opinionY = new Opinion();
			opinionY.comentario = "Mal servicio";
			opinionY.calificacion = 2;
			opinionY.usuario = "FaVio";
		opiniones.push(opinionY);
		return opiniones;
	}
}