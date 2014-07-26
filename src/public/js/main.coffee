
require.config
  baseUrl: '/js'
  paths:
    # components
    'jquery': [
      '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min'
      '/components/jquery/dist/jquery.min'
    ]
    'angular': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular.min'
      '/components/angular/angular.min'
    ]
    'angular-route': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular-route'
      '/components/angular-route/angular-route'
    ]
    'angular-animate': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular-animate'
      '/components/angular-animate/angular-animate'
    ]
    'bootstrap-js': [
      '//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min'
      '/components/bootstrap/dist/js/bootstrap.min'
    ]
    'bootstrap-css': [
      # require-css don't have support to fallback, for now use the local file
      # '//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min'
      '/components/bootstrap/dist/css/bootstrap.min'
    ]
    'bootstrap-css-theme': [
      '/components/bootstrap/dist/css/bootstrap-theme.min'
    ]
    'socket.io': [
      '/socket.io/socket.io'
    ]
    # app
    'app':             'app/index'
    'app.controllers': 'app/controllers'
    'app.directives':  'app/directives'
    'app.filters':     'app/filters'
    'app.services':    'app/services'
    # plugins
    'css':       '/components/require-css/css'
    'normalize': '/components/require-css/normalize'
  shim:
    'angular':
      exports: 'angular'
      deps:    ['jquery']
    'angular-route':
      deps:    ['angular']
    'angular-animate':
      deps:    ['angular']
    'bootstrap-js':
      deps: ['jquery']
    'socket.io':
      exports: 'io'
    'app':
      deps: [
        'css!/style/style'
        'css!bootstrap-css'
        'css!bootstrap-css-theme'
        'angular'
        'angular-route'
        'angular-animate'
        'bootstrap-js'
        'socket.io'
        'app.controllers'
        'app.directives'
        'app.filters'
        'app.services'
      ]

define ['socket.io'], (io) ->
  window.io = io
  require ['app']
