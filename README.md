## Crispy Search
Test project from [Nimbl3](http://nimbl3.com/). It will extract large amounts of data from the Google search results page and generate report.

### System dependencies
* Ruby 2.2.1
* Mysql 5.7.9
* Redis 3.0.5

### Gems 
* rails 4.2.4
* authentication: devise, doorkeeper, omniauth-google-oauth2
* API: active_model_serializers
* background process: sidekiq
* test: RSpec, factory_girl, faker, database_cleaner
* view & assets: bootstrap-sass, font-awesome, haml

### Setup guide
Copy `database.yml` to config directory.
```console
cp config/database.yml.dist config/database.yml
```

Prepare database
```console
rake db:create && rake db:migrate
```

Start `redis` server. If you don't have one, easiest way is install by `homebrew`
```console
 brew install redis
```
then run this
```console
 redis-server /usr/local/etc/redis.conf
```
\*\*If you don't want to install `redis` checkout section **Background Job**


Run `sidekiq`
```console
sidekiq -q default -q low_priority
```

Run seed file 
```console
rake db:seed
```

You are ready to go.


### Background Job

This project use ActiveJob with Sidekiq to fetch keyword search result from Google, Sidekiq require Redis. So if you don't want to setup Redis you can do ignore background process queue and process it immediately by little change in `keyword.rb`.

**But it extremely slow!!**

```ruby
# app/models/keyword.rb
...
  def generate_report
    SearchGoogleJob.perform_now(self) # Bye bye sidekiq we will remember you.
  end
...
```

### TL;DR
Coming soon





