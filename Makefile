#　build develop environment after clone our project
env:
	rm -rf node_modules
	npm install
	rm -rf bower_components
	bower install

# clear old output files
clean:
	rm -rf output

# build output files by grunt
# you can modify Gruntfile.coffee to change tasks
build:
	grunt
