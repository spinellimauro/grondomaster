function Jugador() {
    this.id;
    this.nombre;
    this.nivel;
    this.potencial;
    this.habilitado;
    this.precioVenta;
    this.vecesNoPagadas;
}

Jugador.asJugador = function(jsonJugador) {
    return angular.extend(new Jugador(), jsonJugador);
}

function DT() {
    this.nombreDT;
    this.nombreEquipo;
    this.plata;
    this.slots;
    this.listaJugadores;
    this.ofertasRecibidas;
    this.fechasDisponibles;
}

DT.asDT = function(jsonDT) {
    var dt = angular.extend(new Jugador(), jsonDT);
    dt.listaJugadores = _.map(jsonDT.listaJugadores, Jugador.asJugador);
    return dt;
}

function Partido() {
    this.numeroFecha;
    this.dtLocal;
    this.dtVisitante;
    this.score;
}

Partido.asPartido = function(jsonPartido) {
    return angular.extend(new Partido(), jsonPartido);
}

function Torneo() {
    this.nombreTorneo;
    this.listaParticipantes;
    this.listaPartidos;
    this.limiteAmarillas;
    this.terminado;

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
}
