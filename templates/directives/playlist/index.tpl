<div ng-repeat="template in templates">
    <div ng-include="template.url" onload="template.defer.resolve(1)">
    </div>
</div>
