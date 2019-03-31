# simple-rest-api
[![Build Status](https://travis-ci.org/katherinelim/simple-rest-api.svg?branch=master)](https://travis-ci.org/katherinelim/simple-rest-api)

Simple-rest-api provides a basic code repository for a REST API micro service with pipeline.

It's implemented in Ruby, Sinatra and uses Docker for a development environment.

## Usage

Clone this repository and use it to kick off your own project.

## What it provides

This repository provides code for a REST API micro service and a pipeline configuration to test, build and publish the application as a Docker image.

### The application

A simple REST API micro service is provided in the file `server.rb`.

It has a couple of basic endpoints. Visiting `/` will output `Hello World`.
There is a `/status` endpoint which returns the following response:

```JSON
{
  "myapplication": [
    {
      "version": "1.0",
      "description": "Simple Rest API Application",
      "lastcommitsha": "e503e014bcbc8083714eca565930ba5843a11a6e"
    }
  ]
}
```

Included are the beginnings of an API at the endpoint `/api/v1/service1`. This code demonstrates API versioning and a fixed response. A more comprehensive example could demonstrate an interaction with a database here.
The response from this endpoint is:

```JSON
{
  "data1": "value1",
  "data2": "value2",
  "data3": "value3"
}
```

### Pipeline

The pipeline uses [Travis CI](https://travis-ci.com).

There are 3 stages:
1. Run tests.
2. Build the project.
3. Publish the Docker image to Docker Hub.

## Docker Image

The Docker Image is published at [Docker Hub](https://hub.docker.com) as
[`katdockero/simple-rest-api`](https://hub.docker.com/r/katdockero/simple-rest-api).

## Development Notes

`appmeta.yml`

YAML configuration file for `sinatra/config_file` to read in the values for `Version` and `Description`.

This file should be updated manually.

`SHA_HEAD.yml`

This is a temporary file which is used to store the output of `auto/save-sha-head`. It's in `.gitignore`.

`.rspec`

Configuration file for RSpec.

`app/server.rb`

A small REST micro service application written in Ruby with Sinatra.

`bin/run-server`

After running `auto/dev-environment`, run `bin/run-server` to start the web server.

`bin/run-image`

This is a convenient script to run the application's Docker container. The image must be supplied as a parameter, e.g., `bin/run-image 4ee5dbce45d3`

`auto/test`

Runs the code tests using RSpec in the `dev-environment`.

`auto/dev-environment`

Runs a Ruby Docker Container with the application code and starts on a shell prompt.

It uses `sinatra/reloader` so any saved code changes will reload the application in this environment.
There should be no need to restart the web server.

`auto/get-version`

Returns the `version:` value from `appmeta.yml`.

`auto/publish`

Publisheds the Docker image to Docker Hub.

`auto/rake-test`

Runs `bundle exec rake`.

`auto/build`

Builds and tags the Docker image.

`auto/save-sha-head`

Saves the output of `git rev-parse HEAD` for the `lastcommitsha` value.

`Dockerfile`

Configuration file to assemble the Docker image.

`config.ru`

Configuration file for Rack which connects Ruby Frameworks (Sinatra) to a supported web server (Puma).

`spec/spec_helper.rb`

Helper code for RSpec.

`spec/server_spec.rb`

RSpec tests for the REST API micro service code.

`Rakefile`

Rake's version of a Makefile. Used to define RSpec tasks here.

`Gemfile`

Describes gem dependencies for Ruby programs.

`Gemfile.lock`

Where Bundler records the exact gem versions.

`docker-compose.yml`

Defines the services that make up this application so it can be run in an isolated environment.

It's used here to stand up the development environment.

`.travis.yml`

Configuration file for Travis CI.

## Limitations and Risks

There are some limitations and risks to this implementation which are discussed in this section.

The application is written in Ruby using the Sinatra framework. It could be in NodeJS or Golang but the code demonstrates microservice endpoints and includes a very basic demonstration of an API endpoint. It follows the [Twelve Factor App Methodology](https://12factor.net/) where it is feasible.

There is no graceful error handling but all application events are logged to `stdout` - the console. Cloud services like AWS will collect the console logs in any case. In further work, the logged events could be redirected as required, either to a file, syslog or elsewhere using a data collector like [Fluentd](https://www.fluentd.org/).

Although HTTPS is supported by the Puma web server, it's out of scope of this implementation. For secure connections to the micro service, it could be listening behind a load balancer or proxy which can handle secure connections.

Due to the basic nature of the code provided, the API does not have metering or access control. This could be implemented or a gateway service could provide the functionality, like AWS API Gateway.

No monitoring support is provided in this project. There is scope for adding support for better health checks of the API in the code. Services like New Relic or Sentry could be integrated.

Although Puma is a multi-threaded web server, the project would not be considered resilient enough for production use. Further work would consist of deploying it behind a load balancer and adjusting the number of instances or tasks to serve the projected request volumes.

This project depends on GitHub to host the code, Travis CI for the pipeline and Docker Hub to host the built image. This is less of a risk as development, test and build can be accomplished on the developer's own computer with Ruby, Sinatra and Docker installed along with other expected software.
