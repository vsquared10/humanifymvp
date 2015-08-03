# Humanify MVP

This is the alpha version of the [*Humanify MVP*](http://humanify.co) application.

By [Victor Vulovic](http://linkedin.com/in/victorvulovic)

# Setup

## Install Gems / NPM Packages
```
bundle install;
npm install;
```
## Create an .env file with:
```
PUSHER_ID='SET ID'
PUSHER_KEY='SET KEY'
PUSHER_SECRET='SET SECRET'
LAYER_KEY_ID='SET ID'
LAYER_PROVIDER_ID='SET ID'
LAYER_PLATFORM_TOKEN='SET TOKEN'
```

## Create Database and Migrate
```
rake db:create db:migrate
```

## Start Rails Server
```
rails s
```
