clean:
	echo "deleting generated html..."
	rm -rf public
build:
	hugo
	hugo deploy