var app = angular.module('busquedaMasterListApp', ['ui.router']);

app.controller('BusquedaMasterController', function(BusquedaMasterService) {
    var self = this;

    this.getResultados = function() {
        BusquedaMasterService.findAll(function(response) {
            self.resultados = _.map(response.data, Jugador.asJugador);
        });
    }

    self.getResultados();
});
