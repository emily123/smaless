(function() {
  var app;

  app = angular.module('saslessDemo', []);

  app.controller('menuCtl', [
    '$scope', function($scope) {
      return $scope.showSubMenu = function() {
        if ($scope.showSubMenuFlag) {
          return $scope.showSubMenuFlag = false;
        } else {
          return $scope.showSubMenuFlag = true;
        }
      };
    }
  ]);

}).call(this);
