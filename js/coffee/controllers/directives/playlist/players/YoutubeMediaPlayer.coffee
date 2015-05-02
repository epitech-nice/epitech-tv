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


#This method is call by the YoutubeAPI
window.onYouTubeIframeAPIReady = () ->
	YoutubeMediaPlayer.onYouTubeIframeAPIReady()

class YoutubeMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$q', '$timeout']

	@youTubeIframeAPIReady = false;
	@onYouTubeIframeAPIReady: () ->
		if (YoutubeMediaPlayer.youTubeIframeAPIReady == false)
			YoutubeMediaPlayer.youTubeIframeAPIReady = true;
		else
			YoutubeMediaPlayer.youTubeIframeAPIReady.resolve(true);

	constructor:	(@$scope, @$element, @$q) ->
		super(@$element, @$q, @$timeout);

		@player = null;
		@id = "YoutubeMediaDisplay#{Math.floor(Math.random() * 10000)}";
		@$element.attr('id', @id);

	resize: () -> @$element.width(Math.floor(@$element.parent().height() * 16 / 9));

	# Resolve the promise when video is ended
	onPlayerStateChange: (event) =>
		if (event.data == YT.PlayerState.ENDED) then @defer.resolve(true);

	onPlayerError: (error) =>
		console.log("YoutubeMediaPlayer::onError", error);
		@defer.resolve(true);

	# This function return a promise that will be resolve when the player is fully ready
	onReady: () ->
		state = YoutubeMediaPlayer.youTubeIframeAPIReady
		if (state == true or state == false)
			YoutubeMediaPlayer.youTubeIframeAPIReady = @$q.defer();
		if (state == true)
			YoutubeMediaPlayer.youTubeIframeAPIReady.resolve(true);
		return YoutubeMediaPlayer.youTubeIframeAPIReady.promise.then () =>
			if (@player?) then return true;
			defer = @$q.defer();
			@player = new YT.Player(@id, {
				playerVars: { 'autoplay': 1, 'controls': 0, rel: 0},
				events: {
					onReady: =>
						@$element = jQuery("##{@id}");
						@resize();
						defer.resolve(true);
					onStateChange: @onPlayerStateChange
					onError: @onPlayerError
				}
			});
			return defer.promise;


	play: (media) ->
		@show();
		return @onReady().then () =>
			@defer = @$q.defer();
			@player.setVolume(media.volume);
			@player.loadVideoById(media.videoId, 0, "large");
			return @defer.promise.finally () => @hide()

jQuery () ->
	playerType = 'youtube';
	playerDomClass = 'youtubeMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/youtube.tpl';
	playerController =  YoutubeMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
