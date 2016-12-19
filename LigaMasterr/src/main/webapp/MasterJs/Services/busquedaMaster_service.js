busquedaMasterListApp.service("BusquedaMasterService", function ($http) {
  var self = this;
  this.jugadores = [];
  
  this.findAll = function (callback) {
    $http.get('/busqueda/jugadores').then(callback);
  };

  this.getJugadores = function () {
 
    this.findAll(function (response) {
      self.jugadores = [];
      response.data.forEach(function(element) {
        self.jugadores.push(self.asJugador(element));
      }, this);
     
    });
  };
  /*
  this.toJugador = function (jsonPoi){
      var jugador;
        jugador = new Jugador().asJugador(jsonPoi);
      return jugador;
  };
  */
});