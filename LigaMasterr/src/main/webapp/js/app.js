var app = angular.module('grondomasterApp', ['ui.router']);

app.controller('busquedaController', function(BusquedaMasterService) {
    var self = this;

    this.getResultados = function() {
        BusquedaMasterService.findAll(function(response) {
            self.resultados = _.map(response.data, Jugador.asJugador);
        });
    }
});
