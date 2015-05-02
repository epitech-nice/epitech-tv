<div class="player countdownMediaPlayer">
    <h3>{{players.countdown.title}}</h3>
    <span ng-class="{red: total < 3600}">
        <span ng-show="days != 0"> {{players.countdown.days}} jours</span>
        {{players.countdown.hours}}h
        {{players.countdown.minutes}}m
        {{players.countdown.seconds}}s
    </span>
</div>
