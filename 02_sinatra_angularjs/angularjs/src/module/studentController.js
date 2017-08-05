/*
mainApp.config(function($httpProvider) {
    //Enable cross domain calls
    $httpProvider.defaults.useXDomain = true;

    //Remove the header containing XMLHttpRequest used to identify ajax call 
    //that would prevent CORS from working
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
});*/

mainApp.controller('studentController', function($scope, $http) {
    var url = "http://175.40.0.3:5000/classassist/api/v1.0/students";       

    //$scope.reset();
    
    $scope.post = function(identification, fullName, email) {
        //alert(firstName+lastName+email)  
        $http.post(url, { 'identification': identification, 'fullName':fullName, 'email':email }).success(function(response) {
            console.log(response);
            $scope.result = response;
        }).error(function() {
            console.log("error");
        });

    };

    $scope.get = function(){
       $http.get(url).success( function(response) {
       $scope.students = response;
       });
    };

    $scope.put = function(identification, fullName, email) {
        $http.put(url, { 'identification': identification, 'fullName':fullName, 'email':email }).success(function(response) {
            console.log(response);
            $scope.result = response;
        }).error(function() {
            console.log("error");
        });
    };
    
    $scope.delete = function(identification,fullName,email) {
        $http.delete(url, { 'identification': identification, 'fullName':fullName, 'email':email }).success(function(response) {
            console.log(response);
            $scope.result = response;
        }).error(function() {
            console.log("error");
        });
    };

});