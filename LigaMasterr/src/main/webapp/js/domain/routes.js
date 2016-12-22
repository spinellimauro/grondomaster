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
        views: {
            '': {
                templateUrl: 'partials/inicio/layout.html'
            },
            'plantel@main.inicio': {
                templateUrl: 'partials/inicio/plantel.html'
            },
            'deshabilitados@main.inicio': {
                templateUrl: 'partials/inicio/deshabilitados.html'
            }
        }
    })

    .state('main.mercado', {
        url: '/mercado',
        views: {
            '': {
                templateUrl: 'partials/mercado/layout.html',
                controller: "buscarController as buscarCtrl"
            },
            'transferibles@main.mercado': {
                templateUrl: 'partials/mercado/transferibles.html'
            },
            'buscador@main.mercado': {
                templateUrl: 'partials/mercado/buscador.html'
            }
        }
    })

    .state('main.equipos', {
        url: '/equipos',
        templateUrl: 'partials/equipos.html'
    })

    .state('main.torneos', {
        url: '/torneos',
        views: {
            '': {
                templateUrl: 'partials/torneos/layout.html',
            },
            'partidos@main.torneos': {
                templateUrl: 'partials/torneos/partidos.html'
            },
            'clasificacion@main.torneos': {
                templateUrl: 'partials/torneos/clasificacion.html'
            },
        }

    })

})
