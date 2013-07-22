
define ['angular'], (angular) ->
  app = angular.module 'app.controllers', []

  app.controller 'AppCtrl', ['$scope', ($scope) ->
    $scope.name = 'World'
  ]

  app.controller 'SocketCtrl', ['$scope', 'socket', ($scope, socket) ->
    socket          = socket.getInstance null, 'force new connection': true
    $scope.messages = []

    $scope.start = ->
      socket.removeAllListeners('serverEvent')
      socket.on 'serverEvent', (data) ->
        $scope.messages.push date: Date.now(), data: data
        $scope.messages = $scope.messages.splice -5

    $scope.stop = ->
      socket.removeAllListeners('serverEvent')
      $scope.messages = []

    $scope.start()
  ]

  app.controller 'ViewCtrl0', ['$scope', 'socket', ($scope, socket) ->
    socket         = socket.getInstance null, 'force new connection': true
    $scope.text    = 'ViewCtrl0 Text'
    $scope.loadavg = []
    $scope.uptime  = 0

    socket.on 'loadavg', (data) ->
      $scope.loadavg = data.map (v) -> v.toFixed(2)

    socket.on 'uptime', (data) ->
      $scope.uptime = parseInt(data / 60)
  ]

  app.controller 'ViewCtrl1', ['$scope', ($scope) ->
    $scope.text = 'ViewCtrl1 Text'
  ]

  app.controller 'ViewCtrl2', ['$scope', ($scope) ->
    $scope.text = 'ViewCtrl2 Text'
  ]

  app.controller 'ViewCtrl3', ['$scope', ($scope) ->
    $scope.text = 'ViewCtrl3 Text'
  ]
