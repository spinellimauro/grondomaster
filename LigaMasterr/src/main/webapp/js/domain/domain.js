function Jugador() {}

Jugador.asJugador = function(jsonJugador) {
    return angular.extend(new Jugador(), jsonJugador);
};

function DT() {
    this.init = function() {
        this.plantel = _.filter(this.listaJugadores, function(jugador) {
            return jugador.habilitado;
        });

        this.deshabilitados = _.filter(this.listaJugadores, function(jugador) {
            return !jugador.habilitado;
        });

    };

    this.agregarJugador = function(jugador) {
        this.plantel.put(jugador);
    };

}

DT.asDT = function(jsonDT) {
    var dt = angular.extend(new DT(), jsonDT);
    dt.listaJugadores = _.map(jsonDT.listaJugadores, Jugador.asJugador);
    dt.init();
    return dt;
};

function Partido() {}

Partido.asPartido = function(jsonPartido) {
    return angular.extend(new Partido(), jsonPartido);
};

function Torneo() {
    this.fecha = function(nroFecha) {
        return _.filter(this.listaPartidos, function(partido) {
            return partido.numeroFecha == nroFecha;
        });
    };
}

Torneo.asTorneo = function(jsonTorneo) {
    var torneo = angular.extend(new Torneo(), jsonTorneo);
    torneo.listaParticipantes = _.map(jsonTorneo.listaParticipantes, DT.asDT);
    torneo.listaPartidos = _.map(jsonTorneo.listaPartidos, Partido.asPartido);
    return torneo;
};
