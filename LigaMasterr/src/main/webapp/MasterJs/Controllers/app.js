'use strict';

/* Controllers */
var busquedaMasterListApp = angular.module('busquedaMasterListApp', ['ui.router']);

busquedaMasterListApp.controller('BusquedaMasterController', function (BusquedaMasterService) {
  	this.getResultados = function() {
	    BusquedaMasterService.findAll(function(response) {
	    	self.resultados = _.map(response.data, transformarATarea);
	    });
	}	

	this.getTareas = function() {
	tareasService.findAll(function(response) {
		self.tareas = _.map(response.data, asJugador);
	}, notificarError);
}

 	this.getResultados();

});