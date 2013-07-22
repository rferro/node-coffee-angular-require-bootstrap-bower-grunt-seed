
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
    'bootstrap-css': [
      # '//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min'
      '/components/components-bootstrap/css/bootstrap'
    ]
    'socket.io': [
      # '//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.16/socket.io.min'
      '/socket.io/socket.io.js'
    ]
    'controllers': 'app/controllers'
    'directives':  'app/directives'
    'filters':     'app/filters'
    'services':    'app/services'
    # plugins
    'css':         '/components/require-css/css'
    'normalize':   '/components/require-css/normalize'
  shim:
    'angular':
      exports: 'angular'
      deps: ['jquery']
    'bootstrap':
      deps: ['jquery']
    'app':
      deps: [
        'css!/style/style'
        'css!bootstrap-css'
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
