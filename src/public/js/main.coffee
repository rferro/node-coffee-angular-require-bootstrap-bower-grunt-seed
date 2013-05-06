
require.config
  baseUrl: 'js'
  paths:
    'jquery':    '../components/jquery/jquery'
    'angular':   '../components/angular/angular.min'
    'bootstrap': '../components/components-bootstrap/js/bootstrap.min'
    'socket.io': '/socket.io/socket.io.js'
  shim:
    'angular':
      exports: 'angular'
    'app':
      deps:    ['jquery', 'socket.io', 'angular']

require(
  [
    'app'
    'angular'
    'app/controllers'
    'app/directives'
    'app/services'
    'app/filters'
    'bootstrap'
  ],
  (app, angular) ->
    angular.element(document).ready ->
      angular.bootstrap document, ['App']
)
