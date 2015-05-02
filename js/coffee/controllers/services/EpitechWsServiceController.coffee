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

class EpitechWsServiceController

	@factory = ['$http', 'config', ($http, config) ->
		new EpitechWsServiceController($http, config.getEpitechWsUrl())
	]

	constructor: (@$http, @wsUrl) ->

	query: (path) ->
		return @$http.get("#{@wsUrl}/#{path}").then (httpRes) ->
			if (httpRes.data.code != 200) then throw httpRes.data.message
			return httpRes.data.data

	getAerDuty: (date) ->
		@query('aer/duty').then (data) ->
			month = if (date.getMonth() + 1 >= 10) then date.getMonth() + 1 else "0#{date.getMonth() + 1}"
			day = if (date.getDate() >= 10) then date.getDate() else "0#{date.getDate()}"
			date = "#{date.getFullYear()}-#{month}-#{day}"
			if (not data[date]?) then return ['', ''];
			return data[date];

	getProjects: (scholarYear) ->

	getDoodlePoll: (pollId) ->
		return @query("doodle/#{pollId}");

	getAllModules: (city, scholaryear) -> @query("#{city}/modules?year=#{scholaryear}");

	getNetsoul: (city) -> @query("#{city}/netsoul");

	getNetsoulReport: (city, start, end) ->
		start = moment(start).format("YYYY-MM-DD");
		end = moment(end).format("YYYY-MM-DD");
		@query("#{city}/nslog?start=#{start}&end=#{end}");

	getChained: (urls) ->
		path = ("urls=#{url}" for url in urls)
		path = path.join('&')
		return @query("chained?#{path}");
