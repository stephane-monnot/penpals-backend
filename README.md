# Pen pals API Backend
[![Build Status](https://travis-ci.org/stephane-monnot/penpals-backend.svg?branch=master)](https://travis-ci.org/stephane-monnot/penpals-backend)

API to manage messages between pen pals.

## Installation

### Requirements
This project is based on Docker container. To start using them, you have to make sure Docker Engine and Docker compose 
tool are installed.

### Build the project
```bash
$ docker-compose build
$ docker-compose run web bundle
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
```

### Start the server
```bash
$ docker-compose up
```

## How to run the test suite
```bash
$ docker-compose run -e "RAILS_ENV=test" web rspec
```