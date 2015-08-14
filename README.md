# Humanify MVP

This is the alpha version of the [*Humanify MVP*](http://humanify.co) application.

By [Victor Vulovic](http://linkedin.com/in/victorvulovic)

# Setup

## Install Gems / NPM Packages
```
bundle install;
```
## Create an .env file with:
```
PUSHER_ID='YOUR PUSER ID'
PUSHER_KEY='YOUR PUSER KEY'
PUSHER_SECRET='YOUR PUSER SECRET'
```

## Create Database and Migrate
```
rake db:create db:migrate
```

## Start Rails Server
```
rails s
```
