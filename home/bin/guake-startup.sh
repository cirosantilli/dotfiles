#!/usr/bin/env bash

guake -e "cd ~/gitlab-development-kit/ && bundle exec foreman start"
guake -n "server" -e "cd ~/gitlab && bundle exec foreman start"
guake -n "server" -e "cd ~/gitlab"
guake -n "server" -e "cd \"$RAILS_DIR\""
