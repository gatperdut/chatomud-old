#!/bin/bash
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production rake db:drop
RAILS_ENV=production rake db:create
RAILS_ENV=production rake db:migrate VERSION=0
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake db:seed
