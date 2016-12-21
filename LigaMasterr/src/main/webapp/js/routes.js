app.config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/login");

    $stateProvider.state('login', {
        url: "/login",
        templateUrl: "partials/login.html",
        controller: "loginController as loginCtrl"
    })

    .state('main', {
        url: "/main",
        templateUrl: "partials/main.html",
        controller: "mainController as mainCtrl"
     })

    .state('main.inicio', {
        url: '/',
        templateUrl: 'partials/inicio.html'
    })

    .state('main.buscar', {
        url: '/buscar',
        controller: "buscarController as buscarCtrl",
        templateUrl: 'partials/buscar.html'
    })

    .state('main.mercado', {
        url: '/mercado',
        controller: "buscarController as buscarCtrl",
        templateUrl: 'partials/mercado.html'
    })

    .state('main.equipos', {
        url: '/equipos',
        templateUrl: 'partials/equipos.html'
    })

    .state('main.torneos', {
        url: '/torneos',
        templateUrl: 'partials/torneos.html'
    })

})
