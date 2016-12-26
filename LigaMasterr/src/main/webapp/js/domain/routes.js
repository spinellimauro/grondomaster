app.config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/login');

    $stateProvider.state('login', {
        url: '/login',
        templateUrl: 'partials/login.html',
        controller: 'loginController as loginCtrl'
    })

    .state('main', {
        abstract: true,
        views: {
            '': {
                templateUrl: 'partials/main/layout.html',
                controller: 'mainController as mainCtrl'
            },
            'container@main': {
                template: '<ui-view>'
            },
            'topbar@main': {
                templateUrl: 'partials/main/topbar.html'
            },
            'sidebar@main': {
                templateUrl: 'partials/main/sidebar.html'
            }
        }
    })

    .state('main.inicio', {
        url: '/inicio',
        views: {
            '': {
                templateUrl: 'partials/inicio/layout.html'
            },
            'container@main.inicio': {
                template: '<ui-view>'
            },
        }
    })

    .state('main.inicio.plantel', {
        templateUrl: 'partials/inicio/plantel.html'
    })

    .state('main.inicio.deshabilitados', {
        templateUrl: 'partials/inicio/deshabilitados.html'
    })

    .state('main.inicio.ajustes', {
        templateUrl: 'partials/inicio/ajustes.html'
    })

    .state('main.mercado', {
        url: '/mercado',
        views: {
            '': {
                templateUrl: 'partials/mercado/layout.html',
                controller: 'buscarController as buscarCtrl'
            },
            'container@main.mercado': {
                template: '<ui-view>'
            }
        }
    })

    .state('main.mercado.transferibles', {
        templateUrl: 'partials/mercado/transferibles.html'
    })

    .state('main.mercado.buscador', {
        templateUrl: 'partials/mercado/buscador.html'
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
            'container@main.torneos': {
                template: '<ui-view>'
            }
        }

    })

    .state('main.torneos.partidos', {
        templateUrl: 'partials/torneos/partidos.html'
    })

    .state('main.torneos.posiciones', {
        templateUrl: 'partials/torneos/posiciones.html'
    })

    .state('main.torneos.goleadores', {
        templateUrl: 'partials/torneos/goleadores.html'
    })

    .state('main.torneos.fairPlay', {
        templateUrl: 'partials/torneos/fairPlay.html'
    });

});
