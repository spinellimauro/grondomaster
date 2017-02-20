app.service("JugadorService", function($http) {

    this.getTransferibles = function(callback) {
        $http.get('/mercado').then(callback);
    };

    this.getSome = function(nombre, callback) {
        $http.get('/busqueda/' + nombre).then(callback);
    };
    
});

app.service("DTService", function($http) {

    this.getON = function(callback) {
        $http.get('/dt').then(callback);
    };

    this.getAll = function(callback) {
        $http.get('/dts').then(callback);
    };

    this.getEquipos = function(nombre, callback) {
        $http.get('/equipos/' + nombre).then(callback);
    };

    this.venderJugadorALaMaquina = function(nombreDT, jugadorID){
       return $http.put('/plantel/' + nombreDT + '/'+ jugadorID);
    };

});

app.service("TorneoService", function($http) {

    this.getAll = function(callback) {
        $http.get('/torneos').then(callback);
    };

});
