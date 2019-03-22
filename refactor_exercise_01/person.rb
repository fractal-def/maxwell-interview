class Person < ActiveRecord::Base
  scope :admins, -> { where(admin: true) }
  scope :invalidated, -> do 
    where(
      Person.arel_table[:created_at].lt(30.days.ago)
    ).where(validated: false) 
  end
end