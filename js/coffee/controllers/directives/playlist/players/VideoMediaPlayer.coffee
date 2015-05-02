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

class VideoMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$sce', '$element', '$timeout', '$q']

	constructor: (@$scope, @$sce, $element, @$timeout, @$q) ->
		super($element, @$q, @$timeout)
		$element.find('video').bind('ended', @onVideoEnded);
		@$scope.src = null;
		@resize()

	findPlaylistDiv: () ->
		parent = @$element.parent();
		while (parent)
			if (parent.attr('playlist'))
				return parent;
			parent = parent.parent();

	resize: () ->
		playlist = @findPlaylistDiv();
		@$element.find("video").height(playlist.height())

	onVideoEnded: () =>
		@$scope.$apply () =>
			if (@defer) then @defer.resolve(true);

	playVideo: () =>
		@$element.find("video").get(0).play();

	play: (media) =>
		@show();
		@defer = @$q.defer();
		@resize();
		@$scope.src = @$sce.trustAsResourceUrl(media.src);
		@$timeout(@playVideo);
		return @defer.promise.finally () =>
			@hide();
			@defer = null;

jQuery () ->
	playerType = 'video';
	playerDomClass = 'videoMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/video.tpl';
	playerController =  VideoMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
