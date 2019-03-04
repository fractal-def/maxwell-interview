# Score Card Feature

Adds Ability to Score a Github User

## Why Gem?

In the spirit of consistency and portability, I wrapped the exercises with a gem. Makes for easy and familiar testing and dependency management

## Setup

```
git clone, or git pull
git checkout ex-1-github-score-challenge
bundle
```

## Run Test Suite

```
bundle exec rake test
```

Test output

```
...S...............
Fabulous run in 0.006579s, 2887.9769 runs/s, 2735.9781 assertions/s.
19 runs, 18 assertions, 0 failures, 0 errors, 1 skips
```

### Skipped Test?

The skipped test is a real call to the Github API. It's a smoke test to ensure things actually work. Uncomment to make a real HTTP call.

## Class Summary

There are three classes: `Base` API, `GithubUsers` API, and a `ScoreCard`

### Score Card

Provides a ScoreCard class which gets data from a github user and scores their activity based on an established point system. By default, the user is 'dhh' but any user can be scored by doing the following;

```
  user = 'davewoodall'
  score_card = Maxwell::ScoreCard.new(user: user)
  score_card.score
  => 109
```

### GithubUser API

Example GET request body

```
  user = 'davewoodall'
  request = Maxwell::Http::GithubUsers.new(user: user)
  req = request.get
  req.body
```

### Base API

Create a generic HTTP layer to encapsulate use of HTTParty
