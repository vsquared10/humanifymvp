# Humanify MVP
[![Code Climate](https://codeclimate.com/github/vsquared10/humanifymvp/badges/gpa.svg)](https://codeclimate.com/github/vsquared10/humanifymvp)

This is the alpha version of the [*Humanify MVP*](http://humanify.co) application.
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

## Create Database and Migrate
```
rake db:create db:migrate
```

## Start Rails Server
```
rails s
```
