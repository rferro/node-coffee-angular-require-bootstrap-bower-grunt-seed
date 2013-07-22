
require.config
  baseUrl: '/js'
  paths:
    'jquery':    '/components/jquery/jquery'
    'angular':   '/components/angular/angular.min'
    'bootstrap': '/components/components-bootstrap/js/bootstrap'
    'socket.io': '/socket.io/socket.io.js'
    'controllers': 'app/controllers'
    'directives':  'app/directives'
    'filters':     'app/filters'
    'services':    'app/services'
  shim:
    'angular':
      exports: 'angular'
      deps: ['jquery']
    'bootstrap':
      deps: ['jquery']
    'app':
      deps: [
        'angular'
        'bootstrap'
        'socket.io'
        'controllers'
        'directives'
        'filters'
        'services'
      ]

require ['angular', 'app'], (angular, app) ->
  angular.bootstrap document, ['app']
