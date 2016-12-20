app.config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/");

    $stateProvider.state('login', {
        url: "/",
        templateUrl: "partials/login.html"
    })

    .state('main', {
        url: "/main",
        templateUrl: "partials/main.html",
        controller: "mainController as mainCtrl"
    })

    .state('main.inicio', {
        url: '',
        templateUrl: 'partials/inicio.html'
    })

    .state('main.buscar', {
        url: '',
        controller: "busquedaController as busquedaCtrl",
        templateUrl: 'partials/buscador.html'
    })

    .state('main.mercado', {
        url: '',
        templateUrl: 'partials/mercado.html'
    })

    .state('main.equipos', {
        url: '',
        templateUrl: 'partials/equipos.html'
    })

    .state('main.torneos', {
        url: '',
        templateUrl: 'partials/torneos.html'
    })

})
