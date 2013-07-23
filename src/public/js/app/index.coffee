
define ['angular'], (angular) ->
  angular.module('app', ['ui.state', 'app.controllers', 'app.directives', 'app.filters', 'app.services'])
    .config(
      [
        '$stateProvider'
        '$urlRouterProvider'
        '$locationProvider'
        ($stateProvider, $urlRouterProvider, $locationProvider) ->
          $locationProvider.html5Mode true
          $urlRouterProvider.otherwise '/'

          $stateProvider
            .state('view0', url: '/',      templateUrl: '/partials/view0.html', controller: 'ViewCtrl0')
            .state('view1', url: '/view1', templateUrl: '/partials/view1.html', controller: 'ViewCtrl1')
            .state('view2', url: '/view2', templateUrl: '/partials/view2.html', controller: 'ViewCtrl2')
            .state('view3', url: '/view3', templateUrl: '/partials/view3.html', controller: 'ViewCtrl3')
      ]
    )
