##
# The MIT License (MIT)
#
# Copyright (c) 2013 Jerome Quere <contact@jeromequere.com>
#
# Permission is hereby granted, free  of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction,	including without limitation the rights
# to use,  copy,  modify,  merge, publish,  distribute, sublicense, and/or sell
# copies  of  the  Software,  and  to  permit  persons	to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The  above  copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED  "AS IS",  WITHOUT WARRANTY	OF ANY KIND, EXPRESS OR
# IMPLIED,  INCLUDING BUT NOT LIMITED  TO THE  WARRANTIES  OF  MERCHANTABILITY,
# FITNESS  FOR A  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS  OR  COPYRIGHT  HOLDERS  BE  LIABLE  FOR  ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT  OF  OR  IN  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
##

class CountdownMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$q', '$timeout']

	constructor: (@$scope, $element, $q, $timeout) ->
		super($element, $q, $timeout)

	refresh: () =>
		@promise = @$timeout(@refresh, 500);
		now = moment()

		@$scope.days = 0;
		@$scope.hours = 0;
		@$scope.minutes = 0;
		@$scope.seconds = 0;

		if (@date.isBefore(now)) then return
		tmp =  moment(@date)
		@$scope.days = tmp.diff(now, 'day');
		tmp = tmp.subtract(@$scope.days, 'day');
		@$scope.hours = tmp.diff(now, 'hour');
		tmp = tmp.subtract(@$scope.hours, 'hour');
		@$scope.minutes = tmp.diff(now, 'minute');
		tmp = tmp.subtract(@$scope.minutes, 'minute')
		@$scope.seconds = tmp.diff(now, 'second');

		if (@$scope.hours < 10) then @$scope.hours = "0" + @$scope.hours
		if (@$scope.minutes < 10) then @$scope.minutes = "0" + @$scope.minutes
		if (@$scope.seconds < 10) then @$scope.seconds = "0" + @$scope.seconds

	play: (media) ->
		@show();
		@$scope.title = media.title;
		@date = moment(media.date);
		@refresh();
		return @timeout(media.time).finally () =>
			if @promise then @$timeout.cancel(@promise)
			@promise = null;
			@hide();

jQuery () ->
	playerType = 'countdown';
	playerDomClass = 'countdownMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/countdown.tpl';
	playerController =  CountdownMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
