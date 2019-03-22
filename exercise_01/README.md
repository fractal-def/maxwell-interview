## Exercise 1 Solution

This is a ruby program which when executed prints the score of a given github user.

### Setting it up
This app uses rubygems and ruby version 2.5.1. 

1. You can install ruby 2.5.1 with a tool like (RBenv)[https://github.com/rbenv/rbenv] or (RVM)[https://rvm.io/]

2. Make sure you're in the `exercise_01` directory then run `bundle install` to download all of the package dependencies.

## Running the app

You can run the app just like this to get DHH GitHub score:

```
$ ruby exercise.rb
```

But it also accepts a username, like this:

```
$ ruby exercise.rb abunsen
```

Finally it also supports JSON output:

```
$ ruby exercise.rb abunsen --json
> {"score":89,"username":"abunsen"}

$ ruby exercise.rb --json
> {"score":145,"username":"dhh"}
```