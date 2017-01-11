Maxwell Interview Skeleton
================

# Ruby on Rails

This application requires:

- Rails 5.0.1
- Node.js 5.1.0
- NPM 3.5.0

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

# Getting Started

```
bundle
cp config/database.yml.sample config/database.yml && cp config/secrets.yml.sample config/secrets.yml
bundle exec rake db:create
bundle exec rake db:migrate
npm install
```

# Running The Application

```
foreman start -f Procfile.dev
```

# Add some seed data

```
rake db:seed
```

# Rails Exercise

### Refactoring Exercise

Refactor `controllers/people_controller.rb`, `mailers/emails.rb` and `tasks/accounts.rake`

#### Hints/Suggestions:

* avoid use of attr_accessible.
* skinny controller fat model
* create a spec test for the model.
* use scopes.
* if you plan to use a gem for any utilities, indicate that in a comment.
