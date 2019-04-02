# Instructions:
#
# This was developed using ruby version 2.6.2,,,, it will most likely work on lower versions.
#
# run `gem install httparty` from commandline to install dependency
#

require 'httparty'


class GithubScore

  def initialize(username: 'dhh')
    @username = username
    @score = 0
  end

  def result
    puts "#{@username.upcase}'s github score is #{@score}"
  end
end

gh = GithubScore.new
gh.result