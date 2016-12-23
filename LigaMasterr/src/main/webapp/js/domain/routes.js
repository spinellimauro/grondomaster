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
            'partidos@main.torneos': {
                templateUrl: 'partials/torneos/partidos.html'
            },
            'clasificacion@main.torneos': {
                templateUrl: 'partials/torneos/clasificacion.html'
            },
        }

    });

});
