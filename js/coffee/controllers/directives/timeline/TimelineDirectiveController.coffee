##
# The MIT License (MIT)
#
# Copyright (c) 2013 Jerome Quere <contact@jeromequere.com>
#
# Permission is hereby granted, free  of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction,	including without limitation the rights
# to use,  copy,  modify, merge, publish,  distribute,	sublicense, and/or sell
# copies  of  the  Software,  and  to  permit  persons	to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The  above  copyright	 notice and this permission notice shall be included in
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

class TimelineDirectiveController

	@getConfig: () -> {
		controller: TimelineDirectiveController,
		scope: true,
		templateUrl: 'templates/directives/timeline/index.tpl'
	}

	@$inject = ['$scope', '$timeout', '$attrs']

	constructor: (@$scope, @$timeout, $attrs) ->
		config = @$scope.$parent.$eval($attrs.timeline);
		@startDate = moment(config.start);
		@endDate = moment(config.end);
		@percent = 0;
		@$scope.title = config.title;
		@onTimeout()

	buidCountdown: () =>
		now = moment()
		if (@endDate.isBefore(now)) then return {days: 0, hours: 0, minutes: 0, seconds: 0}
		tmp =  moment(@endDate)
		days = tmp.diff(now, 'day');
		tmp = tmp.subtract(days, 'day');
		hours = tmp.diff(now, 'hour');
		tmp = tmp.subtract(hours, 'hour');
		minutes = tmp.diff(now, 'minute');
		tmp = tmp.subtract(minutes, 'minute')
		seconds = tmp.diff(now, 'second');
		return	{days: days, hours: hours, minutes: minutes, seconds: seconds}

	buildPercent: () =>
		now = moment();
		return Math.floor(Math.min(100, Math.max(0, 100 * (now.unix() - @startDate.unix()) / (@endDate.unix() - @startDate.unix()))))

	buildCountdownPosition: (percent) -> Math.max(20, Math.min(84, percent));

	onTimeout: () =>
		@$timeout(@onTimeout, 1000);
		@$scope.countdown = @buidCountdown();
		@$scope.percent = @buildPercent();
		@$scope.countdownPosition = @buildCountdownPosition(@$scope.percent);
