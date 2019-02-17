class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :admin, :slug, :validated, :handle, :team

  def add_initial_attributes
    self.slug = "ABC123#{Time.now.to_i.to_s}1239827#{rand(10000)}"
    self.admin = false
    count = self.class.count

    team = (count + 1).odd? ? "UnicornRainbows" : "LaserScorpions"
    set_team_and_handle(team)
  end

  def set_team_and_handle(team)
      self.team = team
      self.handle = team + (count + 1).to_s
  end
end