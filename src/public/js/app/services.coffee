
define ['angular'], (angular) ->
  app = angular.module 'app.services', []

  app.config(
    [
      '$httpProvider'
      ($httpProvider) ->
        numLoadings   = 0
        loadingScreen = $('<div class="serviceLoading"><div class="dot"></div></div>').hide().appendTo $('body')

        $httpProvider.responseInterceptors.push ->
          (promise) ->
            numLoadings++
            loadingScreen.fadeIn('fast')
            hide = (r) ->
              loadingScreen.fadeOut('fast') unless --numLoadings
              r
            promise.then hide, hide
    ]
  )

  app.service 'socket', ['$rootScope', ($rootScope) ->
    @getInstance = (host, details) ->
      socket = io.connect host, details

      on: (eventName, callback) ->
        socket.on eventName, ->
          args = arguments
          $rootScope.$apply -> callback.apply socket, args
      emit: (eventName, data, callback) ->
        socket.emit eventName, data, ->
          args = arguments
          $rootScope.$apply -> callback.apply socket, args if callback
      removeAllListeners: ->
        socket.removeAllListeners()
  ]
