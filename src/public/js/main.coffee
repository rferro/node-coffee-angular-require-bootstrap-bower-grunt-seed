
require.config
  baseUrl: '/js'
  paths:
    # components
    'jquery': [
      '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min'
      '/assets/components/jquery/dist/jquery.min'
    ]
    'angular': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular.min'
      '/assets/components/angular/angular.min'
    ]
    'angular-route': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular-route'
      '/assets/components/angular-route/angular-route'
    ]
    'angular-animate': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular-animate'
      '/assets/components/angular-animate/angular-animate'
    ]
    'angular-socket-io': [
      '/assets/components/angular-socket-io/socket.min'
    ]
    'bootstrap-js': [
      '//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min'
      '/assets/components/bootstrap/dist/js/bootstrap.min'
    ]
    'bootstrap-css': [
      # require-css don't have support to fallback, for now use the local file
      # '//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min'
      '/assets/components/bootstrap/dist/css/bootstrap.min'
    ]
    'bootstrap-css-theme': [
      '/assets/components/bootstrap/dist/css/bootstrap-theme.min'
    ]
    'socket.io': [
      '/socket.io/socket.io'
    ]
    'animate-css': [
      '/assets/components/animate.css/animate.min'
    ]
    # app
    'app':             '/assets/js/app/index'
    'app.controllers': '/assets/js/app/controllers'
    'app.directives':  '/assets/js/app/directives'
    'app.filters':     '/assets/js/app/filters'
    'app.services':    '/assets/js/app/services'
    'app-css':         '/assets/style/style'
    # plugins
    'css':       '/assets/components/require-css/css'
    'normalize': '/assets/components/require-css/normalize'
  shim:
    'angular':
      exports: 'angular'
      deps:    ['jquery']
    'angular-route':
      deps:    ['angular']
    'angular-animate':
      deps:    ['angular']
    'angular-socket-io':
      deps:    ['angular']
    'bootstrap-js':
      deps: ['jquery']
    'socket.io':
      exports: 'io'
    'app':
      deps: [
        'css!animate-css'
        'css!app-css'
        'css!bootstrap-css'
        'css!bootstrap-css-theme'
        'angular'
        'angular-route'
        'angular-animate'
        'angular-socket-io'
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
