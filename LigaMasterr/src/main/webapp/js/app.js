var app = angular.module('grondomasterApp', ['ui.router']);

app.controller('busquedaController', function(JugadorService) {
    var self = this;

    this.getResultados = function() {
        JugadorService.getSome(self.query, function(response) {
            self.resultados = _.map(response.data, Jugador.asJugador);
        });
    }

});

app.controller('mainController', function(DTService) {
    var self = this;

    this.getDT = function() {
        DTService.getON(function(response) {
            self.DT = DT.asDT(response.data);
        });
    }

    this.getAll = function() {
        DTService.getAll(function(response) {
            self.DTs = _.map(response.data, DT.asDT);
        });
    }

    self.getDT();
    self.getAll();
});
