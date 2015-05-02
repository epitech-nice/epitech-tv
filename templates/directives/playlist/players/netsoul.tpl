<div class="player netsoulMediaPlayer">
  <div class="group" ng-repeat="group in players.netsoul.groups">
    <h4>{{group.name}}</h4>
    <div class="thumbnail" ng-repeat="login in group.logins">
      <img style="width:100%" ng-src="https://cdn.local.epitech.eu/userprofil/profilview/{{login.login}}.jpg" />
      <div class="netsoul" ng-class="{isAtSchool: login.isAtSchool}"></div>
    </div>
  </div>
</div>
