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

class NetsoulMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$timeout', '$q', 'epitechWs']

	constructor: (@$scope, $element, @$timeout, $q, @epitechWs) ->
		super($element, $q, @$timeout)
		@$scope.groups = [];
		@promise = null;
		@city = null;

	onTimeout: () =>
		@promise = @$timeout(@onTimeout, 1000 * 60 * 2);
		@epitechWs.getNetsoul(@city).then (netsoul) =>
			for group in @$scope.groups
				for login in group.logins
					login.isAtSchool = netsoul[login.login].isAtEpitech

	play: (media) ->
		@show();
		@city = media.city;
		@$scope.groups = []
		for name, logins of media.groups
			group = {name: name, logins: []}
			for login in logins
				group.logins.push({login: login, isAtSchool: false});
			@$scope.groups.push(group);
		@onTimeout();
		return @timeout(media.time).finally () =>
			if @promise then @$timeout.cancel(@promise)
			@promise = null;
			@hide()

jQuery () ->
	playerType = 'netsoul';
	playerDomClass = 'netsoulMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/netsoul.tpl';
	playerController =  NetsoulMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
