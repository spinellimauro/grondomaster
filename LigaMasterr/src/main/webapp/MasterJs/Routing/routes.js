busquedaMasterListApp.config(function ($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('buscarMaster', {
      url: "/busqueda",
      templateUrl: "index.html",
      controller: "BusquedaMasterController as busquedaMasterCtrl"
    })
});