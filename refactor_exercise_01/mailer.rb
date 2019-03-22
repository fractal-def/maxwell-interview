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
    # we are using instance vars because the mailer view 
    # uses them in its template
    @user = user 
    @admins = admins
    mail to: admins, from: 'foo@example.com'
  end
  
  def admin_new_user(admins, user)
    # we are using instance vars because the mailer view 
    # uses them in its template
    @user = user
    @admins = admins
    mail to: admins, from: 'foo@example.com'
  end

  def admin_removing_unvalidated_users(admins, users)
    # we are using instance vars because the mailer view 
    # uses them in its template
    @users = users
    @admins = admins
    mail to: admins, from: 'foo@example.com'
  end
end