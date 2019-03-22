class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :admin, :slug, :validated, :handle, :team
  scope :admins, -> { where(admin: true) }
  scope :invalidated, -> do 
    where(
      Person.arel_table[:created_at].lt(30.days.ago)
    ).where(validated: false) 
  end
end