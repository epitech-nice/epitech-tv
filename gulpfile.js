var gulp = require('gulp'),
coffee   = require('gulp-coffee'),
connect  = require('gulp-connect'),
concat   = require('gulp-concat'),
sass     = require('gulp-sass'),
uglify   = require('gulp-uglify'),
minify   = require('gulp-minify-css'),
order    = require('gulp-order'),
del      = require('del'),
beep     = require('beepbeep'),
modRewrite = require('connect-modrewrite');


function onCoffeeError(e) {
    beep(3)
    console.log("Coffee error [%s] in file [%s] on line %d", e.message, e.filename, e.location.first_line);
    this.emit('end');
}

function onSassError(e) {
    console.log("Sass error [%s] in file [%s] on line %d", e.message, e.fileName, e.lineNumber);
    this.emit('end');
}

gulp.task('coffee-dev', function () {
    return gulp.src(['js/coffee/**/*.coffee', "!js/coffee/**/.#*"])
    .pipe(order(['js/coffee/**/*.coffee', 'js/coffee/main.coffee']))
	.pipe(coffee({bare: true}))
    .on('error', onCoffeeError)
	.pipe(concat('script.js'))
	.pipe(gulp.dest('js/'));
});

gulp.task('sass-dev', function () {
    return gulp.src(["css/scss/style.scss"])
	.pipe(sass())
    .on('error', onSassError)
	.pipe(concat('style.css'))
	.pipe(gulp.dest('css/'));
});

gulp.task('coffee-prod', function () {
    return gulp.src(['js/coffee/**/*.coffee', "!js/coffee/**/.#*"])
    .pipe(order(['js/coffee/**/*.coffee', 'js/coffee/main.coffee']))
	.pipe(coffee({bare: true}))
	.pipe(concat('script.js'))
	.pipe(uglify())
	.pipe(gulp.dest('js/'));
});

gulp.task('sass-prod', function () {
    return gulp.src(["css/scss/style.scss"])
	.pipe(sass())
	.pipe(concat('style.css'))
	.pipe(minify())
	.pipe(gulp.dest('css/'));
});

gulp.task('js-vendor', function () {
    return gulp.src('js/vendor/*.js')
	.pipe(concat('vendor.js'))
	.pipe(uglify())
	.pipe(gulp.dest('js/'))
});

gulp.task('css-vendor', function () {
    return gulp.src('css/vendor/*.css')
	.pipe(concat('vendor.css'))
	.pipe(minify())
	.pipe(gulp.dest('css/'))
});

gulp.task('clean', function () {
    del(['css/vendor.css', 'js/vendor.js', 'css/style.css', 'js/script.js'])
    return null
});

gulp.task('connect', function (){
    connect.server({
	root: __dirname,
	port: 8000,
	open:false,
	middleware: function (connect, opt) {
	    return [modRewrite([
		'^(.*\.(js|json|css|gif|jpg|png|html|tpl|pdf|woff|eot|ttf|svg)(\\?.*)?)$ /$1 [L]',
		'^(.*)$ /index.html'
	    ])];
	}
    })
});

gulp.task('watch', function () {
     gulp.watch('js/coffee/**/*.coffee', ['coffee-dev']);
     gulp.watch(['css/scss/**/*.scss', "!css/scss/**/.#*"], ['sass-dev']);
     gulp.watch('js/vendor/*.js', ['js-vendor']);
     gulp.watch('css/vendor/*.css', ['css-vendor']);
});

gulp.task('default', ['js-vendor', 'css-vendor', 'coffee-prod', 'sass-prod']);
gulp.task('dev', ['js-vendor', 'css-vendor', 'coffee-dev', 'sass-dev' , 'watch', 'connect'])
