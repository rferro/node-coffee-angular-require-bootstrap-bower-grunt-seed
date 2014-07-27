
define ['angular'], (angular) ->
  app = angular.module 'app.services', []

  app.service 'socket', ['socketFactory', (socketFactory) ->
    getInstance: (path, options) ->
      socketFactory ioSocket: io.connect(path, options)
  ]