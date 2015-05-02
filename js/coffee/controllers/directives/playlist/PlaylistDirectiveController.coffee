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

class PlaylistDirectiveController
	#Directive information
	@getConfig: () -> {
		controller: PlaylistDirectiveController,
		templateUrl: "templates/directives/playlist/index.tpl",
		scope: {
			playlist: '='
		}
	}

	@$inject = ['$scope', '$element', '$timeout', '$injector', '$q']

	@playersFactories = {};
	@registerPlayer: (type, classname, template, controller) ->
		PlaylistDirectiveController.playersFactories[type] = {
			controller: controller,
			classname: classname,
			template: template
		};

	constructor: (@$scope, @$element, @$timeout, @$injector, $q) ->
		@players =  {};
		@medias = []
		@$scope.players = {}
		@$scope.templates = []

		# Add all players template url to $scope to load them and generate a promise that
		# will be resolved when template is loaded
		promises = []
		for type, data of PlaylistDirectiveController.playersFactories
			@$scope.players[type] = {};
			defer = $q.defer();
			@$scope.templates.push {
				'url': data.template,
				'defer': defer
			}
			promises.push defer.promise

		# When all players template are loaded we can continue
		$q.all(promises).then () =>
			for type, data of PlaylistDirectiveController.playersFactories
				@players[type] = @$injector.instantiate(data.controller, {
					'$scope': @$scope.players[type],
					'$element':	@$element.find(".#{data.classname}")
				});

			@running = false;
			@run()

			# Loading media from the attr
			@$scope.$watch('playlist', @onPlaylistUpdate);
			@onPlaylistUpdate();

			@checkHeightChange();

	checkHeightChange: () =>
		if @height != @$element.height()
			@height = @$element.height();
			for player in @players
				player.onResize()
		@$timeout(@checkHeightChange, 5000);

	onPlaylistUpdate: () =>
		@medias =  @$scope.playlist;
		@run();

	getPlayerByMedia: (media) ->
		if (@players[media.type]?)
			return @players[media.type];
		return null;

	# display the media passed in parameter using the right payer
	displayMedia: (media) ->
		player = @getPlayerByMedia(media);
		if (not player)
			return console.log("Unknown media %s", media.type);
		player.play(media).finally () =>
			@nextMedia();

	run: () =>
		if (@running == true) then return;
		@current = -1;
		if (@medias.length > 0 )
			@running = true;
			@nextMedia();

	nextMedia: () =>
		if (@medias.length == 0)
			@running = false;
			return;
		@current = (@current + 1) % (@medias.length)
		@displayMedia(@medias[@current]);
