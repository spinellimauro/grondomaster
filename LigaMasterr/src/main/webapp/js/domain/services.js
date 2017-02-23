app.service("JugadorService", function($http) {

    this.getTransferibles = function(callback) {
        $http.get('/mercado').then(callback);
    };

    this.getSome = function(nombre, callback) {
        $http.get('/busqueda/' + nombre).then(callback);
    };
    
});

app.service("DTService", function($http) {
    this.nombreDT;
    this.password;
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

     this.getUsuario = function (callback){
         $http.get('/usuarios/'+this.nombreDT+'/'+this.password)
        .then(callback);
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

    this.cambioDeEquipo = function(nombreDT,equipoID,equipoNombre){
        return $http.put('/plantel/escudo/' + nombreDT + '/' + equipoID + '/' + equipoNombre ); 
    };
});

app.service("TorneoService", function($http) {

    this.getAll = function(callback) {
        $http.get('/torneos').then(callback);
    };

});
