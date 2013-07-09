
module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    dirs:
      dev:   '_dev'
      build: '_build'
    env:
      dev:
        NODE_ENV: 'development'
      build:
        NODE_ENV: 'production'
    less:
      options:
        report: false
      dev:
        options:
          compress: false
        files: [
          {
            expand: true
            cwd:    'src'
            src:    '**/*.less'
            dest:   '<%= dirs.dev %>'
            ext:    '.css'
          }
        ]
      build:
        options:
          compress: true
        files: [
          {
            expand: true
            cwd:    'src'
            src:    '**/*.less'
            dest:   '<%= dirs.build %>'
            ext:    '.css'
          }
        ]
    coffee:
      options:
        bare: false
      dev:
        files: [
          {
            expand: true
            cwd:    'src'
            src:    '**/*.coffee'
            dest:   '<%= dirs.dev %>'
            ext:    '.js'
          }
        ]
      build:
        files: [
          {
            expand: true
            cwd:    'src'
            src:    ['**/*.coffee']
            dest:   '<%= dirs.build %>'
            ext:    '.js'
          }
        ]
    uglify:
      options:
        report:           false
        preserveComments: false
        banner:           '// <%= pkg.name %> <%= pkg.version %>\n// <%= grunt.template.today("yyyy-mm-dd HH:MM:ss Z") %>\n\n'
      dev:
        options:
          mangle:   false
          compress: false
          beautify:
            beautify:     true
            indent_level: 2
            ascii_only:   true
        files: [
          {
            expand: true
            cwd:    '<%= dirs.build %>'
            src:    ['**/*.js']
            dest:   '<%= dirs.build %>'
            ext:    '.js'
          }
        ]
      build:
        options:
          mangle:   true
          compress: false
          beautify: false
        files: [
          {
            expand: true
            cwd:    '<%= dirs.build %>'
            src:    ['**/*.js']
            dest:   '<%= dirs.build %>'
            ext:    '.js'
          }
        ]
    copy:
      dev:
        files: [
          {
            expand: true
            cwd:    'src/views'
            src:    '**'
            dest:   '<%= dirs.dev %>/views'
          }
          {
            expand: true
            cwd:    'components'
            src:    '**'
            dest:   '<%= dirs.dev %>/public/components'
          }
        ]
      dev_views:
        files: [
          {
            expand: true
            cwd:    'src/views'
            src:    '**'
            dest:   '<%= dirs.dev %>/views'
          }
        ]
      dev_components:
        files: [
          {
            expand: true
            cwd:    'components'
            src:    '**'
            dest:   '<%= dirs.dev %>/public/components'
          }
        ]
      build:
        files: [
          {
            expand: true
            cwd:    'src/views'
            src:    '**'
            dest:   '<%= dirs.build %>/views'
          }
          {
            expand: true
            cwd:    'components'
            src:    '**'
            dest:   '<%= dirs.build %>/public/components'
          }
          {
            src:    'package.json'
            dest:   '<%= dirs.build %>/package.json'
          }
        ]
    watch:
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee:dev']
      less:
        files: ['src/**/*.less']
        tasks: ['less:dev']
      jade:
        files: ['src/views/**']
        tasks: ['clean:dev_views', 'copy:dev_views']
      components:
        files: ['components/**']
        tasks: ['clean:dev_components', 'copy:dev_components']
    clean:
      dev_views:
        src: '<%= dirs.dev %>/views'
      dev_components:
        src: '<%= dirs.dev %>/components'
      dev:
        src: '<%= dirs.dev %>'
      build:
        src: '<%= dirs.build %>'
      releases:
        src: '_releases'
    shell:
      npmInstallBuild:
        command: 'npm install'
        options:
          stdout: true
          stderr: true
          execOptions:
            cwd: '<%= dirs.build %>'
    compress:
      build:
        options:
          archive: '_releases/<%= pkg.name %>-<%= pkg.version %>-<%= grunt.template.today("yyyymmddHHMM") %>.tar'
          mode:    'tar'
        files: [
          expand: true
          cwd:    '<%= dirs.build %>'
          src:    '**'
        ]
    removeDevDependencies:
      build:
        src: '<%= dirs.build %>/package.json'
  )

  grunt.registerMultiTask 'removeDevDependencies', ->
    file = this.data.src

    if !file or !grunt.file.isFile(file)
      grunt.log.writeln ("#{file} not exists").red

    try
      json = grunt.file.readJSON(file)
      delete json.devDependencies
      grunt.file.write file, JSON.stringify(json, undefined, '  ')
    catch e
      grunt.log.writeln e.toString().red

  grunt.registerTask(
    'dev'
    [
      'env:dev'
      'clean:dev'
      'coffee:dev'
      'uglify:dev'
      'less:dev'
      'copy:dev'
    ]
  )

  grunt.registerTask(
    'build'
    [
      'env:build'
      'clean:build'
      'coffee:build'
      'uglify:build'
      'less:build'
      'copy:build'
      'removeDevDependencies:build'
      'shell:npmInstallBuild'
      'compress:build'
      'clean:build'
    ]
  )
