var app = angular.module('grondomasterApp', ['ui.router']);

app.controller('buscarController', function(JugadorService) {
    var self = this;
    this.resultados = [];
    this.transferibles = []
    this.pageLimit = 5;

    this.getResultados = function() {
        self.resultados = [];
        self.page = 0;

        JugadorService.getSome(self.query, function(response) {
            self.resultados = _.map(response.data, Jugador.asJugador);
        });
    }

    this.getTransferibles = function() {
        JugadorService.getTransferibles(function(response) {
            self.transferibles = _.map(response.data, Jugador.asJugador);
        });
    }

    this.nPages = function() {
        return Math.round(this.resultados.length / this.pageLimit);
    }

    self.getTransferibles();
});

app.controller('loginController', function(DTService, $state) {
    var self = this;

    this.logIn = function() {
        $state.go("main.inicio");
    }
});

app.controller('mainController', function(DTService, TorneoService) {
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

    this.getTorneos = function() {
        TorneoService.getAll(function(response) {
            self.torneos = _.map(response.data, Torneo.asTorneo);
        });
    }

    self.getTorneos();

    self.getDT();

    self.getAll();
});

app.filter('startFrom', function() {
    return function(input, start) {
        start = +start;
        return input.slice(start);
    }
});
