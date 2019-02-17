class Emails < ActionMailer::Base
  default from: 'foo@example.com'

  class << self
     alias_method :admin_user_validated, :email_admins
     alias_method :admin_new_user, :email_admins
     alias_method :admin_removing_unvalidated_users, :email_admins
   end

  def welcome(person)
    @person = person
    mail to: @person
  end

  def add_account(person)
    validate_email(person).deliver
    admin_new_user.deliver
  end

  def validate_email(person)
    @person = person
    mail to: @person
  end

  def email_admins
    mail to: admins_with_email
  end

  private
  def admins_with_email
    @admins ||= Person.admins_with_email.to_a
  end
end