class Emails < ActionMailer::Base
  default from: 'foo@example.com'

  def welcome(person)
    @person = person
    mail to: @person
  end

  def validate_email(person)
    @person = person
    mail to: @person
  end

  def admin_user_validated
    mail to: @admins
  end

  def admin_new_user
    mail to: @admins
  end

  def admin_removing_unvalidated_users
    mail to: @admins
  end

  private
  def admins_with_email
    @admins ||= Person.admins_with_email.to_a
  end
end