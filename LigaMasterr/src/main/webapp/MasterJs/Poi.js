 //usuario
function Usuario(alias, contrasena){
	this.alias = alias;
	this.contrasena = contrasena;
	this.favoritos = [];
}
Usuario.prototype.agregarFavorito = function(poi){
	this.favoritos.push(poi);
}
Usuario.prototype.quitarFavorito = function(poi) {
	this.favoritos.pop(poi);
}

Usuario.prototype.tieneFavorito = function(poi){
	return this.favoritos.includes(poi);
}


//Rubro
function Rubro() {
	this.nombre;
	this.maximaDistanciaEnKms;
}
Rubro.prototype.estaCerca = function(coordenadaOrigen,point){
	var distancia = coordenadaOrigen.distance(point);
	return distancia < this.maximaDistanciaEnKms;
}

//comuna
function Comuna(puntos, numero) {
	this.nombrePoi = numero;
	this.areaDelimitada = new Polygon(puntos);
}
Comuna.prototype.addPuntoDeArea = function(point){
	this.areaDelimitada.add(point);
}

//Poi
function Poi(){
	this.id;
	this.opiniones = [];
	this.coordenadaOrigen;
	this.maximaDistanciaEnMts;
	this.domicilio;
}
Poi.prototype.estaCerca = function(point){
	return this.coordenadaOrigen.distance(point) < this.maximaDistanciaEnMts;
}
Poi.prototype.estaDisponible = function(momento) {
	return true;
}
Poi.prototype.agregarOpinion = function(opinion){
	this.opiniones.push(opinion);
}

Poi.prototype.emitioOpinion = function(alias){
	return this.opiniones.map(o => o.usuario.includes(alias));
}

Poi.prototype.getCalificacion = function(){
	var aux = 0;
	this.opiniones.forEach(function(element) {
		aux += element.calificacion;
	}, this);
	return (aux / this.opiniones.length);
}

//Banco
function Banco(){
	this.servicios = [];
	this.barrio;
	this.nombrePoi;
}
Banco.prototype = new Poi();
Banco.prototype.estaDisponible = function(momento) { 
	return this.servicios.some(elem => elem.estaDisponible(momento));
};

//Colectivo
function Colectivo(){
	this.paradas = [];
	this.nombrePoi;
}
Colectivo.prototype = new Poi();
Colectivo.prototype.addParada = function(parada) {
	this.paradas.push(parada);
}
Colectivo.prototype.estaCerca = function(point) {
	return this.paradas.some(elem => this.paradaEstaCerca(elem,point));
}

Colectivo.prototype.paradaEstaCerca = function (parada,punto) {
	return parada.distance(punto) < this.maximaDistanciaEnKms;
}

//LocalComercial
function LocalComercial() {
	this.palabrasClave = [];
	this.rubroAsociado;
	this.diasHorariosDeAtencion;	
	this.nombrePoi;
}
LocalComercial.prototype = new Poi();
LocalComercial.prototype.estaCerca = function(point) {
	return this.rubroAsociado.estaCerca(this.coordenadaOrigen,point);
}
LocalComercial.prototype.estaDisponible = function(momento){
	return this.diasHorariosDeAtencion.estaDisponible(momento);
}

//CGP
function CGP(){
	this.servicios = [];
	this.comunaAsociada;
	this.nombrePoi;
}

CGP.prototype = new Poi();
CGP.prototype.estaCerca = function(point) {
	return this.comunaAsociada.areaDelimitada.isInside(point);
}
CGP.prototype.estaDisponible = function(momento, nombreServicio) {
	return this.servicios.some(elem => elem.estaDisponible(momento) 
		&& elem.nombreServicio == nombreServicio);
}

//Opinion
function Opinion(){
	this.comentario;
	this.calificacion;
	this.usuario;
}