function Horario() {
    this.horaInicio;
    this.horaCierre;
}
Horario.prototype.estaDisponible = function(momento) {
    var hora = momento.toLocalTime();
    return (this.horaInicio < hora && hora < this.horaCierre);
}

function DiaHorarioServicio(dia,horario) {
    this.dia = dia;
    this.horario = horario || [];
}
DiaHorarioServicio.prototype.estaDisponible = function(momento) {
    return this.dia == momento.dayOfWeek().value() && 
        this.horario.some(elem => elem.estaDisponible(momento));
}

function ServicioAtencion(nombreServicio, diasHorarioDeServicio){
    this.nombreServicio = nombreServicio;
    this.diasHorarioDeServicio = diasHorarioDeServicio || [];
}
ServicioAtencion.prototype.estaDisponible = function(momento) {
    return this.diasHorarioDeServicio.some(elem => elem.estaDisponible(momento));
}

function Dia(){
    this.domingo = 0;
    this.lunes = 1;
    this.martes = 2;
    this.miercoles = 3;
    this.jueves = 4;
    this.viernes = 5;
    this.sabado = 6;
}
Dia.prototype.toString = function(dia) {
    switch (dia) {
        case this.lunes:
            return "lunes";
        case this.martes:
            return "martes";
        case this.miercoles:
            return "miércoles";
        case this.jueves:
            return "jueves";
        case this.viernes:
            return "viernes";
        case this.sabado:
            return "sábado";
        case this.domingo:
            return "domingo";
    }
}