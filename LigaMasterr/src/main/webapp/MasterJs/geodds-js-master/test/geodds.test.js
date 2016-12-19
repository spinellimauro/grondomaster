
describe("La Bombonera", function() {

	var bombonera;
	var comisaria24;
	var obelisco;

	beforeEach(function() {
		bombonera = new Point(-34.63565, -58.36465)
		comisaria24 = new Point(-34.6342281,-58.3603267)
		obelisco = new Point(-34.603739,-58.38157)
	});

	it("debería estar a más de 4 cuadras de la comisaria 24", function() {
		expect(bombonera.distance(comisaria24)).toBeGreaterThan(0.4);
	});

	it("debería estar a menos de 4 cuadras y 1/2 de la comisaria 24", function() {
		expect(bombonera.distance(comisaria24)).toBeLessThan(0.45);
	});

	it("debería estar a más de 38 cuadras del obelisco", function() {
		expect(bombonera.distance(obelisco)).toBeGreaterThan(3.8);
	});

	it("debería estar a menos de 40 cuadras del obelisco", function() {
		expect(bombonera.distance(obelisco)).toBeLessThan(4);
	});

});

describe("Villa Urquiza", function() {

	var villaUrquiza;
	var plazaEcheverria;
	var obelisco;

	beforeEach(function() {
		villaUrquiza = new Polygon([
			new Point(-34.569557, -58.509089),
			new Point(-34.557541, -58.485485),
			new Point(-34.572808, -58.467976),
			new Point(-34.584822, -58.489090)
		]);

		plazaEcheverria = new Point(-34.571960, -58.489090);
		obelisco = new Point(-34.603739,-58.38157);

	});

	it("debería contener Plaza Echaverría", function() {
		expect(villaUrquiza.isInside(plazaEcheverria)).toBe(true);
	});

	it("no debería contener el obelisco", function() {
		expect(villaUrquiza.isInside(obelisco)).toBe(false);
	});

});


