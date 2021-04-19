#!/bin/bash

// deploy.sh
if [[ $TRAVIS_BRANCH == 'site' ]] ; then
  cd _site
  git init

  git config user.name "Roberto Ramírez"
  git config user.email "me@robertoramirez.mx"
  git add .
  git commit -m "Deploy"

  # We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  git push --force --quiet "https://${GH_TOKEN}@github.com/me@robertoramirez.mx/robertoramirez.github.io.git" master:master > /dev/null 2>&1
else
  echo 'Invalid branch. You can only deploy from site.'
  exit 1
fi