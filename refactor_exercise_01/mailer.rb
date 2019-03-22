class Emails < ActionMailer::Base

  def welcome(person)
    @person = person
    mail to: @person, from: 'foo@example.com'
  end

  def validate_email(person)
    @person = person
    mail to: @person, from: 'foo@example.com'
  end
  
  def admin_user_validated(admins, user)
    @user = user
    mail to: admins, from: 'foo@example.com'
  end
  
  def admin_new_user(admins, user)
    @user = user
    mail to: admins, from: 'foo@example.com'
  end

  def admin_removing_unvalidated_users(admins, users)
    @users = users
    mail to: admins, from: 'foo@example.com'
  end

end