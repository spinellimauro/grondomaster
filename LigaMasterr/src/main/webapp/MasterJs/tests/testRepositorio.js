describe("Repositorio", function() {
var repositorio;

beforeEach(function() {
	repositorio = new Repositorio();
	
});

 it('Repositorio -> NO debe contener un Poi', function() {
	    repositorio.buscar("Trompeta");
	    expect(repositorio.resultados.length).toBe(0);
	  });

 it('Repositorio -> debe contener un Poi', function() {
   repositorio.buscar("Citi");
   expect(repositorio.resultados.length).toBe(1);
 });
  
 it('Repositorio -> debe contener mas de un Poi', function() {
	   repositorio.buscar("Citi");
	   repositorio.buscar("Martita");
	   expect(repositorio.resultados.length).toBe(2);
	 });
	  
  
});