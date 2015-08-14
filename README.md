# Humanify MVP

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
```

## Create Database and Migrate
```
rake db:create db:migrate
```

## Start Rails Server
```
rails s
```
