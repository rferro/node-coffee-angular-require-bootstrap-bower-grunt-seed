
require.config
  baseUrl: '/js'
  paths:
    # components
    'jquery': [
      '//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min'
      '/components/jquery/jquery.min'
    ]
    'angular': [
      '//ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min'
      '/components/angular/angular.min'
    ]
    'angular-ui-router': [
      '/components/ui-router/release/angular-ui-router.min'
    ]
    'bootstrap-js': [
      '//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min'
      '//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/js/bootstrap.min'
      '/components/components-bootstrap/js/bootstrap'
    ]
    'bootstrap-css': [
      # require-css don't have support to fallback, for now use the local file
      # '//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min'
      '/components/components-bootstrap/css/bootstrap'
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
    'domReady':  '/components/requirejs-domready/domReady'
  shim:
    'angular':
      exports: 'angular'
      deps:    ['jquery']
    'bootstrap-js':
      deps: ['jquery']
    'angular-ui-router':
      deps: ['angular']
    'app':
      deps: [
        'css!/style/style'
        'css!bootstrap-css'
        'angular'
        'angular-ui-router'
        'bootstrap-js'
        'socket.io'
        'app.controllers'
        'app.directives'
        'app.filters'
        'app.services'
      ]

require ['domReady!', 'app']
