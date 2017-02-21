app.service("JugadorService", function($http) {

    this.getTransferibles = function(callback) {
        $http.get('/mercado').then(callback);
    };

    this.getSome = function(nombre, callback) {
        $http.get('/busqueda/' + nombre).then(callback);
    };
    
});

app.service("DTService", function($http) {

//GETS

    this.getON = function(callback) {
        $http.get('/dt').then(callback);
    };

    this.getAll = function(callback) {
        $http.get('/dts').then(callback);
    };

    this.getEquipos = function(nombre, callback) {
        $http.get('/equipos/' + nombre).then(callback);
    };

// PUTS
    this.venderJugadorALaMaquina = function(nombreDT, jugadorID){
       return $http.put('/plantel/' + nombreDT + '/'+ jugadorID);
    };

    this.comprarJugador = function(nombreDT, jugadorID){
       return $http.put('/transferibles/' + nombreDT + '/'+ jugadorID);
    };

    this.comprarUnSlot = function(nombreDT){
        return $http.put('/dts/' + nombreDT); 
    };

    this.comprarALaMaquina = function(nombreDT,jugadorID,jugadorNombre){
        return $http.put('/sofifa/' + nombreDT + '/' + jugadorID + '/' + jugadorNombre ); 
    };
});

app.service("TorneoService", function($http) {

    this.getAll = function(callback) {
        $http.get('/torneos').then(callback);
    };

});
