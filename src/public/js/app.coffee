
app = angular.module 'App', []

app.factory 'socket', ($rootScope) ->
  socket = io.connect()

  on: (eventName, callback) ->
    socket.on eventName, ->
      args = arguments
      $rootScope.$apply -> callback.apply socket, args

  emit: (eventName, data, callback) ->
    socket.emit eventName, data, ->
      args = arguments
      $rootScope.$apply -> callback.apply socket, args if callback

app.controller 'AppCtrl', ($scope, socket) ->
  $scope.name     = 'World'
  $scope.messages = []

  socket.on 'serverEvent', (data) ->
    $scope.messages.push date: Date.now(), data: data
    $scope.messages = $scope.messages.splice -5
