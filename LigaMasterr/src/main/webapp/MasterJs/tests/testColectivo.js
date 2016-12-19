describe("Colectivo", function() {
	var colectivo;

	  beforeEach(function() {
	
	    colectivo = new Colectivo();
	    colectivo.maximaDistanciaEnMts = 111.12;
	    colectivo.addParada(new Point(1,1));
	    colectivo.addParada(new Point(1,2));
	    colectivo.addParada(new Point(2,1));
	    
	  });
	  
	  it('Colectivo -> alguna parada debe estar cerca', function() {
	    expect(colectivo.estaCerca(new Point(2,1))).toBeTruthy;
	  });  

	  it('Colectivo -> alguna parada NO debe estar cerca', function() {
	    expect(colectivo.estaCerca(new Point(124,1))).toBeFalsy();
	  });  
	
	  it('Colectivo ->  debe estar disponible', function() {
	    expect(colectivo.estaDisponible(JSJoda.LocalDateTime.parse('2016-09-01T09:42'))).toBeTruthy;
	  });  
});