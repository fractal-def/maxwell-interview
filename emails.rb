class Emails < ActionMailer::Base
  default from: 'foo@example.com'

  class << self
     alias_method :admin_removing_unvalidated_users, :email_admins
   end

  def welcome(person)
    @person = person
    mail to: @person
  end

  def validate_email(person)
    @person = person
    mail to: @person
  end

  def admin_new_user(person)
    validate_email(person).deliver
    email_admins.deliver
  end

  def admin_user_validated(person)
    email_admins
    welcome(person).deliver!
  end

  def email_admins
    mail to: admins_with_email
  end

  private
  def admins_with_email
    @admins ||= Person.admins_with_email.to_a
  end
end