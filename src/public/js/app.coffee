
define ['angular'], (angular) ->
  angular.module('App', [])
    .config(
      [
        '$routeProvider'
        '$locationProvider'
        ($routeProvider, $locationProvider) ->
          $routeProvider
            .when('/',      templateUrl: 'partials/view0.html', controller: 'ViewCtrl0')
            .when('/view1', templateUrl: 'partials/view1.html', controller: 'ViewCtrl1')
            .when('/view2', templateUrl: 'partials/view2.html', controller: 'ViewCtrl2')
            .when('/view3', templateUrl: 'partials/view3.html', controller: 'ViewCtrl3')
            .otherwise(redirectTo: '/')

          $locationProvider.html5Mode true
      ]
    )
