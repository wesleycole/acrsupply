var gulp = require('gulp');
var sourcemaps = require('gulp-sourcemaps');
var changed = require('gulp-changed');
var using = require('gulp-using');
var sass = require('gulp-sass');

var paths = {
  scss: './web/assets/src/css/**/*.scss',
  js: './web/assets/src/js/**/*.js',
  dist: './web/assets/dist'
}

gulp.task('scss', function () {
  return gulp.src(paths.scss)
    .pipe(using({ prefix: 'After changed:' }))
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(changed(paths.dist))
    .pipe(sourcemaps.write('.', { sourceRoot: '/' }))
    .pipe(gulp.dest(paths.dist))
});

gulp.task('app', gulp.parallel('scss'));

gulp.task('build', gulp.series('app'));

gulp.task('watch:styles', function () {
  gulp.watch(paths.scss, gulp.series('scss'));
});

gulp.task('watch', gulp.parallel('watch:styles'));

gulp.task('default', gulp.series('build', 'watch'));