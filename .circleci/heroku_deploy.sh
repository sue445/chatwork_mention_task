#!/bin/bash -xe

heroku config:add BUNDLE_WITHOUT="test:development" --app $HEROKU_APP_NAME

sleep 3

git push git@heroku.com:$HEROKU_APP_NAME.git $CIRCLE_SHA1:refs/heads/master

heroku run rake db:migrate --app $HEROKU_APP_NAME

# curl -s "https://${HEROKU_APP_NAME}.herokuapp.com/ops/heartbeat" | grep "heartbeat:ok"
