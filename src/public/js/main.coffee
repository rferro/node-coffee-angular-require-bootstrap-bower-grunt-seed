
require.config
  baseUrl: 'js'
  paths:
    'jquery':    '/components/jquery/jquery'
    'angular':   '/components/angular/angular.min'
    'bootstrap': '/components/components-bootstrap/js/bootstrap'
    'socket.io': '/socket.io/socket.io.js'
  shim:
    'angular':
      exports: 'angular'

require ['jquery', 'angular', 'bootstrap', 'socket.io'], ->
  require(
    [
      'angular'
      'app'
      'app/services'
      'app/controllers'
      'app/directives'
      'app/filters'
    ],
    (angular) ->
      angular.bootstrap document, ['app']
  )
