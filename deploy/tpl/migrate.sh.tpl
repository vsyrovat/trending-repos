#!/usr/bin/env bash

docker-compose run app bin/app eval "App.Release.migrate"
