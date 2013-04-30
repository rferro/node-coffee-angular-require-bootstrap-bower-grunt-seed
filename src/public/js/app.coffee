
app = angular.module 'App', []

app.service 'socket', ($rootScope) ->
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

app.controller 'AppCtrl', ($scope) ->
  $scope.name = 'World'

app.controller 'SocketCtrl', ($scope, socket) ->
  socket          = socket.getInstance null, 'force new connection': true
  $scope.messages = []

  $scope.start = ->
    socket.on 'serverEvent', (data) ->
      $scope.messages.push date: Date.now(), data: data
      $scope.messages = $scope.messages.splice -5

  $scope.stop = ->
    socket.removeAllListeners()
    $scope.messages = []

  $scope.start()
