<div ng-show="isEnabled">
  <div class="nosong" ng-hide="currentTrack">
    Choisis la prochaine chanson sur dj.yayo.fr
  </div>

  <div class="track" ng-show="currentTrack">
    <img ng-src="{{currentTrack.track.imgUrl}}" />
    <div class="info">
      <span class="title">{{currentTrack.track.name}}</span><br /><span class="artist">{{currentTrack.track.artists[0].name}}</span>
    </div>
  </div>

  <div ng-show="nextTrack" class="track next">
    <img ng-src="{{nextTrack.track.imgUrl}}" />
    <div class="info">
      <span class="title">{{nextTrack.track.name}}</span><br /><span class="artist">{{nextTrack.track.artists[0].name}}</span>
    </div>
  </div>
</div>
