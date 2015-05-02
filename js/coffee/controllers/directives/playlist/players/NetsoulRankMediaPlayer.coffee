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
# The  above  copyright notice and this permission  notice shall be included in
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

class NetsoulRankMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$timeout', '$q', 'epitechWs']

	constructor: (@$scope, $element, @$timeout, $q, @epitechWs) ->
		super($element, $q, @$timeout)
		@$scope.scores = [];
		@promise = null;
		@city = null;

	onTimeout: () =>
		@$scope.scores = [];
		@promise = @$timeout(@onTimeout, 1000 * 60 * 10);
		start = moment().subtract(8, 'days').toDate();
		@epitechWs.getNetsoulReport(@city, start, new Date()).then (netsoulReport) =>
			tmp = [];
			for login,stats of netsoulReport
				tmp.push({login: login, stats: stats});
			netsoulReport = tmp;
			netsoulReport.sort (r1, r2) -> return (r2.stats.school + r2.stats.idleSchool) - (r1.stats.school + r1.stats.idleSchool)
			for i in [0..11]
				total = netsoulReport[i].stats.school + netsoulReport[i].stats.idleSchool;
				hours = Math.floor(total / 3600);
				min = Math.floor(total / 60) - hours * 60;
				sec = Math.floor(total % 60);
				@$scope.scores.push({login: netsoulReport[i].login, stats: {hours: hours, minutes: min, seconds: sec}});

	play: (media) ->
		@show();
		@city = media.city;
		@$scope.scores = []
		@onTimeout();
		return @timeout(media.time).finally () =>
			if @promise then @$timeout.cancel(@promise)
			@promise = null;
			@city = null;
			@hide()

jQuery () ->
	playerType = 'netsoulRank';
	playerDomClass = 'netsoulRankMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/netsoulRank.tpl';
	playerController =  NetsoulRankMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
