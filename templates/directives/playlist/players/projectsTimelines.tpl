<div class="player projectsTimelinesMediaPlayer">
  <div ng-repeat="project in players.projectsTimelines.projects">
    <div timeline="{start: project.start, end: project.end, title: project.name}"></div>
  </div>
</div>
