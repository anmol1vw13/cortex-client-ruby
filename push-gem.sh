#!/bin/bash

gem install bundler -v 2.0.2
bundle install
bundle exec rake install
GEM_NAME=$(ls ./pkg/*.gem)
gem push ${GEM_NAME}