# ChatWorkMentionTask
ChatWorkMentionTask can automatically task the mentions that came to you, easily look back on it later.

https://chatwork-mention-task.herokuapp.com/

[![CircleCI](https://circleci.com/gh/sue445/chatwork_mention_task.svg?style=svg)](https://circleci.com/gh/sue445/chatwork_mention_task)

## Requirements
* Ruby
* PostgreSQL
* memcached
* ChatWork OAuth app

## Register ChatWork OAuth client
If you are developing or deploying ChatWorkMentionTask, you need to register the ChatWork OAuth client

* ChatWork.com: https://www.chatwork.com/service/packages/chatwork/subpackages/oauth/client_list.php
* KDDI ChatWork: https://kcw.kddi.ne.jp/service/packages/chatwork/subpackages/oauth/client_list.php

parameters

* Redirect URI: `https://<APP-HOST>/auth/chatwork/callback`
* Scope: followings
  * Access your profile information
  * Access your chatrooms list
  * Create tasks in your chatrooms

![OAurh client scope](img/oauth_client_scope.png)

## Development
```bash
./bin/setup
vi .env

bundle exec foreman s
```

## Heroku deploy
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/sue445/chatwork_mention_task)

Register `rake remind` to [Heroku Scheduler](https://addons.heroku.com/scheduler)

![Heroku Scheduler](img/heroku_scheduler.png)
