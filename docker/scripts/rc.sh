#!/bin/bash
docker run -i -t -v /app:/app --link postgres:db  --rm rails:latest bash -c "cd /app && bundle exec rails c"
