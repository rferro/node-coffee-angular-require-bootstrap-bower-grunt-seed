
require.config
  baseUrl: '/js'
  paths:
    # components
    'jquery': [
      '//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min'
      '/components/jquery/jquery.min'
    ]
    'angular': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.2.0-rc.2/angular.min'
      '/components/angular/angular.min'
    ]
    'bootstrap-js': [
      '//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min'
      '/components/bootstrap/dist/js/bootstrap.min'
    ]
    'bootstrap-css': [
      # require-css don't have support to fallback, for now use the local file
      # '//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min'
      '/components/bootstrap/dist/css/bootstrap.min'
    ]
    'socket.io': [
      '//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.16/socket.io.min'
      '/socket.io/socket.io.js'
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
    'bootstrap-js':
      deps: ['jquery']
    'app':
      deps: [
        'css!/style/style'
        'css!bootstrap-css'
        'angular'
        'bootstrap-js'
        'socket.io'
        'app.controllers'
        'app.directives'
        'app.filters'
        'app.services'
      ]

require ['app']
