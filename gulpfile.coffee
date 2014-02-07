gulp = require('gulp')
coffee = require('gulp-coffee')
watch = require('gulp-watch')
clean = require('gulp-clean')
less = require('gulp-less')
nodemon = require('nodemon')
gutil = require('gulp-util');
_ = require('underscore')

demon_running = false
demon_command = '-e "js jade css json" ./build/app.js'

init_demon = ->
    if not demon_running
        try
            nodemon(demon_command)
            console.log gutil.colors.red("Nodemon started")
            demon_running = true
        catch error
    else
        nodemon.emit('restart')
        console.log gutil.colors.red('nodemon restarted')
init_demon = _.debounce init_demon, 1000

demon_watch = ->
    return watch (files)->
        init_demon()
        return files

build = './build/'

move_tasks = []

moveTask = (name, path, dest)->
    move_tasks.push name
    gulp.task name, ->
        gulp.src(path)
        .pipe(demon_watch())
        .pipe(gulp.dest(if dest? then dest else build))

moveTask 'makefile', './Makefile'
moveTask 'package.json', 'package.json'
moveTask 'js', ['./**/*.js', '!./build/**', '!node_modules/**']
moveTask 'views', './views/**/*.*', build+'views/'
moveTask 'env files', ['.test_env', '.production_env']
moveTask 'public files', ['public/**/*.*', '!public/**/*.coffee', '!public/**/*.less'], build+'public/'

gulp.task 'move', ->
    gulp.run task for task in move_tasks

gulp.task 'coffee', ->
    gulp.src(['./**/*.coffee', '!./gulpfile.coffee', '!node_modules/**'])
    .pipe(demon_watch())
    .pipe(coffee({bare:true}))
    .pipe(gulp.dest(build))

gulp.task 'less', ->
    gulp.src(['./**/*.less', '!node_modules/**'])
    .pipe(watch())
    .pipe(less())
    .pipe(gulp.dest(build))

gulp.task 'clean', ->
    gulp.src(build, {read: false})
    .pipe(clean())


gulp.task 'default', ->
    process.env.NODE_ENV = 'production'
    start_demon = ()->
        if not demon_running
            try
                nodemon(demon_command)
                console.log gutil.colors.red("Nodemon started")
                demon_running = true
                clearInterval(interval)
            catch error
    interval = setInterval start_demon, 1000

    gulp.run 'clean', ->
        gulp.run 'coffee', 'less', 'move'