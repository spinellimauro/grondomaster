describe("Favorito", function() {
 var local;
 var banco;
 var cgp;
 var colectivo;
 var usuario;
 
  beforeEach(function() {
	local = new LocalComercial();
	banco = new Banco();
	cgp = new CGP();
	colectivo = new Colectivo();
	
    usuario = new Usuario();
    usuario.agregarFavorito(local);
    
  });

  it('Usuario -> debe contener el favorito', function(){
	  expect(usuario.tieneFavorito(local)).toBeTruthy;
  });
  
  it('Usuario -> NO debe contener el favorito', function(){
	  expect(usuario.tieneFavorito(banco)).toBeFalsy();
  });
  
});