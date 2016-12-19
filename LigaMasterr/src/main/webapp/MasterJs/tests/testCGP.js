describe("CGP", function() {
  var cgp;
  var dia = new Dia();
  
  beforeEach(function() {
    var atencionTMañana = new Horario();
    atencionTMañana.horaInicio = JSJoda.LocalTime.parse('08:30:00');
    atencionTMañana.horaCierre = JSJoda.LocalTime.parse('13:30:00');
    var atencionTTarde = new Horario();
    atencionTTarde.horaInicio = JSJoda.LocalTime.parse('15:30:00');
    atencionTTarde.horaCierre = JSJoda.LocalTime.parse('20:00:00');

    cgp = new CGP();
    cgp.comunaAsociada = new Comuna([
      new Point(1,1),
      new Point(1,3),
      new Point(3,3),
      new Point(3,1)
    ]);
    cgp.servicios = [
      new ServicioAtencion(
        "rentas",[
            new DiaHorarioServicio(dia.lunes,[atencionTMañana]),
            new DiaHorarioServicio(dia.martes,[atencionTMañana,atencionTTarde]),
            new DiaHorarioServicio(dia.miercoles,[atencionTMañana]),
            new DiaHorarioServicio(dia.jueves,[atencionTMañana,atencionTTarde]),
            new DiaHorarioServicio(dia.viernes,[atencionTMañana])
      ]),
      new ServicioAtencion(
        "informes",[
            new DiaHorarioServicio(dia.martes,[atencionTTarde]),
            new DiaHorarioServicio(dia.miercoles,[atencionTTarde]),
            new DiaHorarioServicio(dia.viernes,[atencionTTarde])
      ])
    ];
    
  });

  it('CGP -> debe estar cerca', function() {
    expect(cgp.estaCerca(new Point(2,2))).toBeTruthy;
  });

   it('CGP -> NO debe estar cerca', function() {
    expect(cgp.estaCerca(new Point(223,2))).toBeFalsy();
  });

  it('CGP -> Rentas esta disponible un martes por la tarde', function() {
    expect(cgp.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-06T19:40'),"rentas")).toBeTruthy;
  });
  it('CGP ->informes esta disponible un miercoles por la tarde', function() {
    expect(cgp.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-07T19:40'),"informes")).toBeTruthy;
  });

  it('CGP -> Rentas no esta disponible un miercoles por la tarde', function() {
    expect(cgp.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-07T19:40'),"rentas")).toBeFalsy();
  });
  it('CGP ->informes no esta disponible un miercoles por la mañana', function() {
    expect(cgp.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-07T09:40'),"informes")).toBeFalsy();
  });
});