# Humanify MVP
[![Code Climate](https://codeclimate.com/github/vsquared10/humanifymvp/badges/gpa.svg)](https://codeclimate.com/github/vsquared10/humanifymvp)

This is the alpha version of the [*Humanify MVP*](http://humanify.co) application. Please visit our [*Pivotal*](https://www.pivotaltracker.com/n/projects/1656689) tracker for a prioritized list of stories to complete for getting the alpha ready to launch. 

# Setup

## Install Gems / NPM Packages
```
bundle install;
```
## Create an .env file with your [Pusher](https://pusher.com) enviroment variables:
```
PUSHER_ID='YOUR PUSHER ID'
PUSHER_KEY='YOUR PUSHER KEY'
PUSHER_SECRET='YOUR PUSHER SECRET'
GOOGLE_ANALYTICS='YOUR GOOGLE ANALYTICS KEY'
```

# Dockerify
preface: [easiest way to install docker](https://docs.docker.com/docker-for-mac/)

1. Build the images (rails with gems, elasticsearch, etc.)

	```
	docker-compose build
	```

2. Run the images (logs to stdout, navigate to localhost:3000 in your browser)

	```
	docker-compose up
	```

3. Set up db and stuff

	- run a shell in the docker container (to run rake commands)
	```
	docker exec -it humanifymvp_web_1 /bin/bash
	```

	- set up the dev and test db
	```
	rake db:create db:migrate db:test:prepare
	```

	- run the specs
	```
	./bin/rspec
	```
