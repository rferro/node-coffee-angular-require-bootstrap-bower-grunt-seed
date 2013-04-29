
module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig(
      pkg: grunt.file.readJSON('package.json')
      meta:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      watch:
        coffee:
          files: ['src/**/*.coffee']
          tasks: ['coffee:dev']
        less:
          files: ['src/**/*.less']
          tasks: ['less:dev']
        jade:
          files: ['src/views/**']
          tasks: ['clean:viewsDev', 'copy:viewsDev']
      coffee:
        dev:
          options:
            bare: false
          files: [
            expand: true
            cwd:    'src'
            src:    '**/*.coffee'
            dest:   '_dev'
            ext:    '.js'
          ]
        build:
          options:
            bare: false
          files: [
            expand: true
            cwd:    'src'
            src:    '**/*.coffee'
            dest:   '_build'
            ext:    '.js'
          ]
      less:
        dev:
          options:
            compress: false
          files: [
            expand: true
            cwd:    'src'
            src:    '**/*.less'
            dest:   '_dev'
            ext:    '.css'
          ]
        build:
          options:
            compress: true
          files: [
            expand: true
            cwd:    'src'
            src:    '**/*.less'
            dest:   '_build'
            ext:    '.css'
          ]
      uglify:
        build:
          options:
            preserveComments: 'some'
            beautify:
              ascii_only: true
            compress:
              hoist_funs: false
              join_vars:  false
              loops:      false
              unused:     false
            mangle:
              except: [ 'undefined' ]
          files: [
            expand: true
            cwd:    '_build'
            src:    ['**/*.js', '!public/components/**/*']
            dest:   '_build'
            ext:    '.js'
          ]
      copy:
        viewsDev:
          files: [
            expand: true
            cwd:    'src/views'
            src:    '**'
            dest:   '_dev/views'
          ]
        viewsBuild:
          files: [
            expand: true
            cwd:    'src/views'
            src:    '**'
            dest:   '_build/views'
          ]
        componentsDev:
          files: [
            expand: true
            cwd:    'components'
            src:    '**'
            dest:   '_dev/public/components'
          ]
        componentsBuild:
          files: [
            expand: true
            cwd:    'components'
            src:    '**'
            dest:   '_build/public/components'
          ]
        core:
          files: [
            src:    'package.json'
            dest:   '_build/package.json'
          ]
      clean:
        dev:
          src: '_dev'
        viewsDev:
          src: '_dev/views'
        build:
          src: '_build'
        releases:
          src: '_releases'
      compress:
        build:
          options:
            archive:  '_releases/<%= pkg.name %>-<%= pkg.version %>-<%= grunt.template.today("yyyymmddHHMM") %>.zip'
          files: [
            expand:   true
            cwd:      '_build'
            src:      '**'
          ]
  )

  grunt.registerTask(
    'dev:config'
    [
      'clean:dev'
      'copy:componentsDev'
      'copy:componentsDev'
      'dev:make'
    ]
  )

  grunt.registerTask(
    'dev:make'
    [
      'coffee:dev'
      'less:dev'
      'copy:viewsDev'
    ]
  )

  grunt.registerTask(
    'build'
    [
      'clean:build'
      'copy:core'
      'copy:viewsBuild'
      'copy:componentsBuild'
      'coffee:build'
      'less:build'
      'uglify:build'
      'compress:build'
      'clean:build'
    ]
  )
