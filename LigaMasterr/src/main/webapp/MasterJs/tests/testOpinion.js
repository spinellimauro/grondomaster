describe("Opinion", function() {
  var banco;
  var colectivo;
  var local;
  var cgp;
  var usuario;
  beforeEach(function() {

  	banco = new Banco();
  	
  	local = new LocalComercial();
  	
    colectivo = new Colectivo();

    cgp = new CGP();

    usuario = new Usuario();
    usuario.agregarFavorito(local);
    
  });

  it('Opinion -> debe contener una opinion al opinar', function(){
	  banco.calificar("hola","Pole",2);
	  expect(banco.opiniones.length).toBe(1);
  });

  it('Opinion -> NO debe contener una opinion al opinar', function(){
	  expect(colectivo.opiniones.length).toBe(0);
  });
  
  it('Opinion -> debe contener la correcta informacion al opinar', function(){
	  banco.calificar("hola","Pole",2);
	  opinion = banco.opiniones[0];
	  expect(opinion.comentario).toBe("hola");
	  expect(opinion.usuario).toBe("Pole");
	  expect(opinion.calificacion).toBe(2);	  
  });

  it('Opinion -> NO debe contener la correcta informacion al opinar', function(){
	  opinion = banco.opiniones[0];
	  expect(opinion.comentario == "hsla").toBeFalsy();
	  expect(opinion.usuario == "gil").toBeFalsy();
	  expect(opinion.calificacion == 3).toBeFalsy();
  });

  it('Opinion -> calificacionGeneral deberia ser 3.5', function(){
	  banco.calificar("hola","Pole",5);
	  banco.calificar("hola","Pole",5);
	  expect(banco.getCalificacion()).toBe(3.5);
  });

  it('Opinion -> calificacionGeneral NO deberia ser 5', function(){
	  expect(banco.getCalificacion() == 5).toBeFalsy();
  });
  
});