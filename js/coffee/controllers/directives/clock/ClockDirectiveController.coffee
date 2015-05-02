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
# The  above  copyright notice and this permission notice  shall be included in
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

class ClockDirectiveController

	@getConfig: () -> {
		controller: ClockDirectiveController,
		scope: true,
		templateUrl: 'templates/directives/clock/index.tpl'
	}

	@$inject = ['$scope', '$timeout']

	constructor: (@$scope, @$timeout) ->
		@onTimeout();

	formatTime: (date) ->
		hours = if (date.getHours() >= 10) then date.getHours() else "0" + date.getHours()
		minutes = if (date.getMinutes() >= 10) then date.getMinutes() else "0" + date.getMinutes()
		seconds = if (date.getSeconds() >= 10) then date.getSeconds() else "0" + date.getSeconds()
		return "#{hours}:#{minutes}:#{seconds}";

	formatDate: (date) ->
		day = ['', "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
		month = ["janvier", "fevier", "mars", "avril", "mai", "juin", "juillet", "aout", "septembre", "octobre", "novembre", "decembre"]
		d = if (date.getDate() >= 10) then date.getDate() else "0" + date.getDate()
		return "#{day[date.getDay()]} #{d} #{month[date.getMonth()]}"

	onTimeout: () =>
		@$timeout(@onTimeout, 1000);
		date = new Date();
		@$scope.time = @formatTime(date);
		@$scope.date = @formatDate(date);
