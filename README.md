My Workout Diary
================

[![Build Status](https://travis-ci.org/BraviSoftware/my-workout-diary.png?branch=master)](https://travis-ci.org/BraviSoftware/my-workout-diary)
[![Coverage Status](https://coveralls.io/repos/BraviSoftware/my-workout-diary/badge.png?branch=master)](https://coveralls.io/r/BraviSoftware/my-workout-diary?branch=master)
[![Code Climate](https://codeclimate.com/github/BraviSoftware/my-workout-diary.png)](https://codeclimate.com/github/BraviSoftware/my-workout-diary)



### Pre-Configuration
Add these configurations below into your .bashrc or .zshrc file and reload the shell after that:
```bash
export MWD_FACEBOOK_APP_ID="insert_the_facebook_app_id_here"
export MWD_FACEBOOK_SECRET="insert_the_secrete_key_here"
export MWD_GOOGLE_KEY="insert_the_google_client_id_here"
export MWD_GOOGLE_SECRET="insert_the_google_client_secrete_here"
export MWD_MAIL_USERNAME="insert_the_username_email_sender_here"
export MWD_MAIL_PASSWORD="insert_the_password_email_sender_here"
export MWD_HOSTNAME="insert_the_app_url_here"
```

There are some data which are always the same (e.g., Activity Types). So lets up the seed data:
```bash
rake db:seed
```