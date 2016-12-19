describe("Local Comercial", function() {
  var local;
  var dia = new Dia();
  
  beforeEach(function() {
    var atencionTMañana = new Horario();
    atencionTMañana.horaInicio = JSJoda.LocalTime.parse('08:30:00');
    atencionTMañana.horaCierre = JSJoda.LocalTime.parse('13:30:00');
    var atencionTTarde = new Horario();
    atencionTTarde.horaInicio = JSJoda.LocalTime.parse('15:30:00');
    atencionTTarde.horaCierre = JSJoda.LocalTime.parse('20:00:00');
    
    local = new LocalComercial();
    local.coordenadaOrigen = new Point(1,2);
    
    var rubro = new Rubro();
    rubro.maximaDistanciaEnKms = 20;
    
    local.rubroAsociado = rubro;
    local.diasHorariosDeAtencion = new ServicioAtencion(
      "atencion",[
        new DiaHorarioServicio(dia.lunes,[atencionTMañana,atencionTTarde]),
        new DiaHorarioServicio(dia.martes,[atencionTMañana,atencionTTarde]),
        new DiaHorarioServicio(dia.miercoles,[atencionTMañana,atencionTTarde]),
        new DiaHorarioServicio(dia.jueves,[atencionTMañana,atencionTTarde]),
        new DiaHorarioServicio(dia.viernes,[atencionTMañana,atencionTTarde]),
        new DiaHorarioServicio(dia.sabado,[atencionTMañana])
      ]);

      });

  it('LocalComercial -> debe estar cerca', function() {
    expect(local.estaCerca(new Point(1.123,2.1145))).toBeTruthy;
  });

  it('LocalComercial -> NO debe estar cerca', function() {
    expect(local.estaCerca(new Point(1133,2.1145))).toBeFalsy();
  });

  it('LocalComercial -> debe estar disponible un sabado por la mañana', function() {
    expect(local.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-10T09:42'))).toBeTruthy;
  });
});