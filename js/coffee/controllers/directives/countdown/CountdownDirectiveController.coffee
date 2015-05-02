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
# The  above  copyright notice and  this permission notice shall be included in
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

class CountdownDirectiveController

	@getConfig: () -> {controller: CountdownDirectiveController, scope: true}
	@$inject = ['$scope', '$timeout', '$attrs']

	constructor: (@$scope, @$timeout, $attrs) ->
		@endDate = moment(@$scope.$parent.$eval($attrs.countdown));
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

	onTimeout: () =>
		@$timeout(@onTimeout, 1000);
		@$scope.countdown = @buidCountdown();
