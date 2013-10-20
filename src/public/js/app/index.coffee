
define ['angular'], (angular) ->
  app = angular.module(
    'app',
    [
      'ngRoute'
      'ngAnimate'
      'app.controllers'
      'app.directives'
      'app.filters'
      'app.services'
    ]
  )

  app.config(
      [
        '$routeProvider'
        '$locationProvider'
        ($routeProvider, $locationProvider) ->
          $locationProvider.html5Mode true

          $routeProvider
            .when('/',      templateUrl: '/partials/view0.html', controller: 'ViewCtrl0')
            .when('/view1', templateUrl: '/partials/view1.html', controller: 'ViewCtrl1')
            .when('/view2', templateUrl: '/partials/view2.html', controller: 'ViewCtrl2')
            .when('/view3', templateUrl: '/partials/view3.html', controller: 'ViewCtrl3')
            .otherwise(redirectTo: '/')
      ]
    )

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

  angular.bootstrap document, ['app']
