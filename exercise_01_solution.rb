class People < ActionController::Base

  # ... Other REST actions

  def create
    @person = Person.new(params[:person]) do |person|
      person.slug = "ABC123#{Time.now.to_i}1239827#{rand(10_000)}"
      person.admin = false
      person.team = Person.count.even? ? 'LaserScorpions' : 'UnicornRainbows'
      person.handle = person.team + (Person.count + 1)
    end

    if @person.save
      Emails.with(person: @person).validate_email(@person).deliver
      @admins = Person.is_admin
      Emails.with(person: @person, admins: @admins).admin_new_user_email.deliver
      redirect_to @person, notice: 'Account added!'
    else
      render :new
    end
  end
end

class Person < ActiveRecord::Base
  scope :created_this_month, lambda {
    where('created_at < ?', 30.days.ago.from_now)
  }
  scope :is_admin, -> { where(admin: true) }
  scope :not_validated, -> { where(validated: false) }

  # NOTE
  # I emailed regarding the requirement to remove attr_accessible.
  # In a real application, these definitions are automatic based on
  # the underlying table. So in theory, these could all just be
  # removed completely assuming they are backed by db columns.
  attr_accessible :first_name,
                  :last_name,
                  :email,
                  :admin,
                  :slug,
                  :validated,
                  :handle,
                  :team

  validates_inclusion_of :team, in: %w[LaserScorpions UnicornRainbows]
  validates_uniqueness_of :slug
end

class Emails < ActionMailer::Base
  # Migrated to ActionMailer #with syntax from Rails 5.x
  before_action { @admins = params[:admin] ? params[:admin].collect(&:email) : [] }
  before_action { @user, @person = params[:user], @params[:person] }

  def welcome_email
    mail to: @person, from: 'foo@example.com'
  end

  def validate_email
    mail to: @person, from: 'foo@example.com'
  end

  def admin_user_validated_email
    mail to: @admins, from: 'foo@example.com'
  end

  def admin_new_user_email
    mail to: @admins, from: 'foo@example.com'
  end

  def admin_removing_unvalidated_users_email
    mail to: @admins, from: 'foo@example.com'
  end
end

namespace :accounts do

  desc 'Remove accounts where the email was never validated and it is over 30 days old'
  task :remove_unvalidated do
    @people = Person
                .created_this_month
                .not_validated
    @people.each do |person|
      Rails.logger.info "Removing unvalidated user #{person.email}"
      person.destroy
    end
    Emails
      .with(admins: Person.is_admin, users: @people)
      .admin_removing_unvalidated_users_email
      .deliver
  end

end
