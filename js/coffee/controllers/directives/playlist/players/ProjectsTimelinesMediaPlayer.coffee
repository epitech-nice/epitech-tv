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

class ProjectsTimelinesMediaPlayer extends AbstractMediaPlayer

	@$inject = ['$scope', '$element', '$timeout', '$q' , 'epitechWs']

	constructor: (@$scope, $element, @$timeout, $q, @epitechWs) ->
		super($element, $q, @$timeout);
		@city = null;
		@$scope.projects = [];
		date = new Date()
		AUGUST = 7;
		@scholarYear = date.getFullYear() - (if date.getMonth() < AUGUST then 1 else 0)
		@promise = null;

	loadProjectInfo: (city, scholarYear) =>
		return @epitechWs.getAllModules(city, scholarYear).then (modules) =>
			urls = ("/module/#{m.scholaryear}/#{m.moduleCode}/#{m.instanceCode}/activities" for  m in modules)
			return @epitechWs.getChained(urls).then (data) ->
				projects = []
				for m in data when m.data.code == 200
					for act in m.data.data when act.type == "proj"
						act.start =  moment(act.start, "YYYY-MM-DD HH:mm:ss");
						act.end =  moment(act.end, "YYYY-MM-DD HH:mm:ss");
						now = moment();
						if (act.start.isBefore(now) and act.end.isAfter(now) and act.end.diff(now, 'day') < 30)
							projects.push(act)
				projects.sort (p1, p2) -> p2.end.unix() < p1.end.unix()
				return projects;

	onTimeout: () =>
		@promise = @$timeout(@onTimeout, 1000 * 60 * 10);
		@loadProjectInfo(@city, @scholarYear).then (projects) =>
			@$scope.projects = projects;

	play: (media) =>
		@show();
		@city = media.city
		@$scope.projects = [];
		@onTimeout();
		return @timeout(media.time).finally () =>
			if (@promise) then @$timeout.cancel(@promise)
			@promise = null;
			@hide();

jQuery () ->
	playerType = 'projectsTimelines';
	playerDomClass = 'projectsTimelinesMediaPlayer';
	playerTemplateFile = '/templates/directives/playlist/players/projectsTimelines.tpl';
	playerController =  ProjectsTimelinesMediaPlayer;
	PlaylistDirectiveController.registerPlayer(playerType, playerDomClass, playerTemplateFile, playerController)
