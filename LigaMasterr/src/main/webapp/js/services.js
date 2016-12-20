app.service("BusquedaMasterService", function($http) {
    this.findAll = function(callback) {
        $http.get('/busqueda').then(callback);
    };
});
