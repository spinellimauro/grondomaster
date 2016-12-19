function Repositorio(){

this.datos = new Datos().listaDePois();
this.resultados = [];

this.buscar = function(nombre){
	 this.datos.forEach(function(elem){
		this.matchear(nombre,elem);
		
	},this);
	
};

this.matchear = function(nombre,Poi){
	if(Poi.nombrePoi == nombre){
		this.resultados.push(Poi);
	}
}

}