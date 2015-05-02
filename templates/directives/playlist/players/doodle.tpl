<div class="player doodleMediaPlayer">
  <h3>{{players.doodle.title}}</h3>
  <div class="progress" ng-repeat="option in players.doodle.options">
    <div class="progress-bar progress-bar-info" role="progressbar" ng-style="{width: option.percent + '%'}">
      <span class="title"><b>{{option.name}} : {{option.count}} vote(s)</b></span>
    </div>
  </div>
  <div>
      {{players.doodle.url}}<br/>
      <img ng-src="{{players.doodle.qrcode}}" />
  </div>
</div>
