require 'securerandom'

class Person < ActiveRecord::Base
  before_create :set_admin, :set_slug, :set_team
  scope :admins, -> { where(admin: true) }
  scope :invalidated, -> do 
    where(
      Person.arel_table[:created_at].lt(30.days.ago)
    ).where(validated: false) 
  end

  private
    def set_admin
      self.admin = false if self.admin.nil?
    end

    def set_slug
      slug = SecureRandom.uuid
      while Person.where(slug: slug).exists?
        slug = SecureRandom.uuid
      end
      self.slug = slug 
    end

    def set_team
      id_number = Person.count + 1
      team = id_number.odd? ? "UnicornRainbows" : "LaserScorpions"
      self.handle = "#{team}#{id_number}"
      self.team = team
    end
end