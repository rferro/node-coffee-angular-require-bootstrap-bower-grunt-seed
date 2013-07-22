
require.config
  baseUrl: '/js'
  paths:
    'jquery': [
      '//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min'
      '/components/jquery/jquery.min'
    ]
    'angular': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min'
      '/components/angular/angular.min'
    ]
    'bootstrap': [
      '//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min'
      '//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/js/bootstrap.min'
      '/components/components-bootstrap/js/bootstrap'
    ]
    'socket.io': [
      # '//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.16/socket.io.min'
      '/socket.io/socket.io.js'
    ]
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
