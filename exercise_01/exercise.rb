require 'httparty'
require_relative './score_calculator'

@calculator = ScoreCalculator.new
@calculator.add("IssuesEvent")
@calculator.add("IssuesEvent")
@calculator.add("PullRequestReviewCommentEvent")
puts "score is #{@calculator.score} (should be 18)"
