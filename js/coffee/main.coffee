##
#The MIT License (MIT)
#
# Copyright (c) 2013 Jerome Quere <contact@jeromequere.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
##

app = angular.module('app', ['ngRoute']);

app.config ['$locationProvider', '$routeProvider', ($locationProvider, $routeProvider) ->
	$routeProvider.when('/', {templateUrl: "templates/pages/home/index.tpl", controller: 'HomePageController'});
	$routeProvider.when('/loading', {templateUrl: "templates/pages/loading/index.tpl", controller: 'LoadingPageController'});
	$locationProvider.html5Mode(true);
]

app.factory('config', ConfigServiceController.factory);
app.factory('djYayo', DjYayoServiceController.factory);
app.factory('epitechWs', EpitechWsServiceController.factory);

app.directive('clock', () -> ClockDirectiveController.getConfig());
app.directive('countdown', () -> CountdownDirectiveController.getConfig());
app.directive('djYayo', () -> DjYayoDirectiveController.getConfig());
app.directive('epitechTvBlock', () -> EpitechTvBlockDirectiveController.getConfig());
app.directive('playlist', () -> PlaylistDirectiveController.getConfig());
app.directive('timeline', () -> TimelineDirectiveController.getConfig());

app.run ['$location', ($location) =>
	$location.path('/loading');
]
