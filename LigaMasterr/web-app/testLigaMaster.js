describe("un DT", function() {
  var mauro;

  beforeEach(function() {
  	mauro = new DT();
    rulli = new Jugador();
    rulli.precioVenta = 200;
    deBruyne = new Jugador();
    deBruyne.precioVenta = 300;
  });
  
  it('deberia tener 2 jugadores', function() {
    mauro.addJugador(rulli);
    mauro.addJugador(deBruyne);
    expect(mauro.getCantidadJugadores()).toBe(2);
  }); 
  
});