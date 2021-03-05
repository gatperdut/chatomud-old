#!/bin/bash
bin/rails db:environment:set RAILS_ENV=development
RAILS_ENV=development rake db:drop
RAILS_ENV=development rake db:create
RAILS_ENV=development rake db:migrate VERSION=0
RAILS_ENV=development rake db:migrate
RAILS_ENV=development rake db:seed
