describe("Banco", function() {
var banco;
var horario;
var dia = new Dia();

beforeEach(function() {
	
	horario = new Horario();
	horario.horaInicio = JSJoda.LocalTime.parse('09:00:00');
	horario.horaCierre = JSJoda.LocalTime.parse('15:00:00');

	banco = new Banco();
  	banco.maximaDistanciaEnMts = 200;
  	banco.coordenadaOrigen = new Point(1,1);
    banco.servicios = [
      new ServicioAtencion("",[new DiaHorarioServicio(dia.lunes,[horario])]),
      new ServicioAtencion("",[new DiaHorarioServicio(dia.martes,[horario])]),
      new ServicioAtencion("",[new DiaHorarioServicio(dia.miercoles,[horario])]),
      new ServicioAtencion("",[new DiaHorarioServicio(dia.jueves,[horario])]),
      new ServicioAtencion("",[new DiaHorarioServicio(dia.viernes,[horario])])
    ];
	
});

  it('Banco -> debe estar cerca', function() {
    expect(banco.estaCerca(new Point(1,1))).toBeTruthy();
  });

  it('Banco -> NO debe estar cerca', function() {
    expect(banco.estaCerca(new Point(152,124))).toBeFalsy();
  });

  it('Banco -> debe estar disponible', function() {
    expect(banco.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-01T09:42'))).toBeTruthy;
  });
  
});