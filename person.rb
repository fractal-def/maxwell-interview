class Person < ActiveRecord::Base
  UNICORN_RAINBOWS = "UnicornRainbows"
  LASER_SCORPIONS = "LaserScorpions"
  scope :administrators -> { where(admin: true) }
  scope :admins_with_email -> { administrators.where.not(email: nil) }
  scope :unvalidated -> { where("created_at < ? AND validated = ?", Time.now - 30.days, false)}

  def add_initial_attributes
    self.slug = "ABC123#{Time.now.to_i.to_s}1239827#{rand(10000)}"
    self.admin = false
    count = self.class.count

    team = (count + 1).odd? ? UNICORN_RAINBOWS : LASER_SCORPIONS
    set_team_and_handle(team)
  end

  def set_team_and_handle(team)
      self.team = team
      self.handle = team + (count + 1).to_s
  end

  def validate_email
    self.validated = true
    if self.save
      Rails.logger.info "USER: User ##{self.id} validated email successfully."
      true
    else
      false
    end
  end
end