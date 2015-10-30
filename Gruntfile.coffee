module.exports = (grunt)->
  grunt.initConfig

    watch:
      scripts:
        files: ['demo/**/*.jade','demo/scss/*.scss']
        tasks: ['default']
      options:
        spawn: false
        debounceDelay: 300
    clean:
      demo: ['output']
    sass:
      demo:
        files: [
          {
            expand: true,
            cwd: 'demo',
            src: ['scss/*.scss', '!scss/doc.scss']
            dest: 'output',
            ext: '.css'
          }
        ]
    coffee:
      demo:
        expand: true,
        cwd: 'demo/coffee',
        src: ['*.coffee'],
        dest: 'output/js',
        ext: '.js'

    jade:
      demo:
        options:
          data:
            debug: true,
            timestamp: "<%= new Date().getTime() %>"
        files:
          "index.html": "demo/index.jade"

    shell:
      installSASS:
        command: 'sudo gem install sass'
      installJADE:
        command: 'sudo npm install jade -g'

    copy:
      packages:
        cwd: 'demo'
        src: ['bower_components/**/*']
        dest: 'output'
        expand: true
  
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask "buildEnv", ["shell:installSASS", "shell:installJADE"]
  grunt.registerTask "build", ["sass:demo", "coffee:demo", "jade:demo", "copy:packages"]
  grunt.registerTask "default", ["clean:demo", "build"]
