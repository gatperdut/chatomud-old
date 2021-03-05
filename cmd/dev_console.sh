#!/bin/bash
bin/rails db:environment:set RAILS_ENV=development
RAILS_ENV=development bundle exec rails c
