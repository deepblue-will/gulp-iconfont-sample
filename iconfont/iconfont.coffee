# see gulp-iconfont https://github.com/nfroidure/gulp-iconfont
# see http://dev.classmethod.jp/client-side/javascript/gulp-solo-adv-cal-23/

gulp = require 'gulp'
iconfont = require 'gulp-iconfont'
consolidate = require 'gulp-consolidate'
rename = require "gulp-rename"
runTimestamp = Math.round Date.now() / 1000

gulp.task 'Iconfont', () ->
  return gulp.src ['iconfont/svg/*.svg']
    .pipe iconfont
      fontName: 'myfont'
      appendUnicode: true
      formats: ['ttf', 'eot', 'woff', 'svg']
      timestamp: runTimestamp
    .on 'glyphs', (glyphs, options) ->
      cssFileName = 'font'
      engine = 'lodash'
      consolidateOption =
        glyphs: glyphs
        fontName: 'myfont'
        fontPath: '../fonts/'
        className: 'icon'

      gulp.src 'iconfont/template.css'
        .pipe consolidate engine, consolidateOption
        .pipe rename basename: cssFileName
        .pipe gulp.dest 'app/css/'
        .pipe gulp.dest 'doc/iconfont/css'

      consolidateOption.cssFileName = cssFileName
      gulp.src 'iconfont/template.html'
        .pipe consolidate engine, consolidateOption
        .pipe rename basename: 'font'
        .pipe gulp.dest 'doc/iconfont'
        .pipe gulp.dest 'app'
    .pipe gulp.dest 'app/fonts/'
    .pipe gulp.dest 'doc/iconfont/fonts/'