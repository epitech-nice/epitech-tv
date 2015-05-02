<div class="progress">
  <div class="progress-bar progress-bar-info" role="progressbar" ng-style="{width: percent + '%'}">
    <span class="title"><b>{{title}}</b></span>
  </div>
  <span class="countdown" ng-style="{left: countdownPosition + '%'} ">
      <span ng-show="countdown.days">{{countdown.days}} jours</span>
      <span ng-show="countdown.days || countdown.hours">{{countdown.hours}}h</span>
      <span ng-show="countdown.days || countdown.hours || countdown.minutes">{{countdown.minutes}}m</span>
      <span ng-show="countdown.days || countdown.hours || countdown.minutes || countdown.seconds">{{countdown.seconds}}s</span>
  </span>
</div>
