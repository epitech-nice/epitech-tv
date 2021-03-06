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

class ImageMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$timeout', '$q']

	constructor: (@$scope, @$element, @$timeout, @$q) ->
		super(@$element, @$q, @$timeout)
		@$scope.src = null;

	play: (media) =>
		@show();
		src = media.src;
		if (src.indexOf("http") == -1)
			src = "http://#{src}";
		@$scope.src = src;
		return @timeout(media.time).finally () => @hide()

jQuery () ->
	playerType = 'image';
	playerDomClass = 'imageMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/image.tpl';
	playerController =  ImageMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
