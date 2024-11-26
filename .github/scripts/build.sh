#!/bin/bash
set -e

#### Running build ####
export COMMIT_ID=$(git log --pretty="%h" --no-merges -1)
export COMMIT_DATE="$(git log --date=format:'%Y-%m-%d %H:%M:%S' --pretty="%cd" --no-merges -1)"

printenv

rm -rf ./dist/apps/catalog

npx nx build catalog --configuration=production

mv dist/apps/catalog ./out