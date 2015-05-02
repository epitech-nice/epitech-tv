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
# The  above  copyright	 notice and this permission notice shall be included in
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

class ConfigServiceController

	@factory = ['$http', '$location', ($http, $location) ->
		return new ConfigServiceController($http, $location)
	];

	constructor: (@$http, @$location) ->
		@promise = null;
		@config = null;

	getEpitechWsUrl: () ->
		return @config.config['epitech-ws-url']

	getBlocks: () ->
		return @config.blocks

	getDjYayoConfig: () ->
		return @config.config.djYayo;

	load: () ->
		if @promise? then return @promise;
		search = @$location.search();
		if (not search.config?) then throw new Error('No config file specified');
		config = search.config;
		if (config.indexOf("http") == -1)
			config = "http://#{config}";
		@promise = @$http.get(config).success (data) =>
			@config = data;
			return true;
		return @promise;
