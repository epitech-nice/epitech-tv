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

class DoodleMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$timeout', '$q', '$http']

	constructor: (@$scope, $element, @$timeout, $q, @$http) ->
		super($element, $q, @$timeout)
		@$scope.title = null
		@$scope.options = []
		@promise = null
		@doodleId = null

	onTimeout: () =>
		@$scope.options = [];
		@promise = @$timeout(@onTimeout, 1000 * 60 * 10);
		@$http.get("http://yayo.fr/doodle.php?id=#{@doodleId}").success (data) =>
			if (data.code != 200) then throw data.msg;
			@$scope.options = data.data;
			total = 0
			for option in data.data
				total += option.count;
			for option in @$scope.options
				option.percent = Math.max(20, Math.floor((option.count / total) * 100));

	play: (media) ->
		@show();
		@$scope.title = media.title
		@$scope.options = []
		@doodleId = media.doodleId;
		@$scope.url = "http://doodle.com/#{@doodleId}"
		url = encodeURI(@$scope.url);
		@$scope.qrcode = "https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=#{url}";
		@onTimeout();
		return @timeout(media.time).finally () =>
			if @promise then @$timeout.cancel(@promise)
			@promise = null;
			@hide()

jQuery () ->
	playerType = 'doodle';
	playerDomClass = 'doodleMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/doodle.tpl';
	playerController =  DoodleMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
