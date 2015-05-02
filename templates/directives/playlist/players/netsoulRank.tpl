<div class="player netsoulRankMediaPlayer">
  <div class="row">
    <div class="col-md-2" ng-repeat="score in players.netsoulRank.scores">
      <div class="thumbnail center">
	<img width="100%" ng-src="https://cdn.local.epitech.eu/userprofil/profilview/{{score.login}}.jpg" />
	<div class="caption">
	  <i class="icon-trophy" style="float:left;font-size: 30px"></i>
	  <b>{{score.login}}</b><br/>
	  {{score.stats.hours}}h {{score.stats.minutes}}m {{score.stats.seconds}}s
	</div>
      </div>
    </div>
  </div>
</div>
