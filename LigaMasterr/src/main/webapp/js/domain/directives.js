app.directive('errSrc', function() {
    return {
        link: function(scope, element, attrs) {
            element.bind('error', function() {
                if (attrs.src != attrs.errSrc) {
                    attrs.$set('src', attrs.errSrc);
                }
            });
        }
    };
});

app.directive('jugadores', function() {
    return {
        templateUrl: 'partials/jugadores.html',
        controller: 'listaController as listaCtrl',
        scope: {
            lista: '='
        }
    };
});

app.directive('detalle', function() {
    return {
        templateUrl: 'partials/jugador.html',
        controller: 'mainController as mainCtrl',
        scope: {
            jugador: '='
        }
    };
});

app.directive('detallePartido', function() {
    return {
        templateUrl: 'partials/torneos/partido.html',
        controller: 'mainController as mainCtrl',
        scope: {
            partido: '='
        }
    };
});