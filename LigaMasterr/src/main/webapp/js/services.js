app.service("JugadorService", function($http) {

    this.getTransferibles = function(callback) {
        $http.get('/mercado').then(callback);
    };

    this.getSome = function(nombre,callback) {
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

});

