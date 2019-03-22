class Emails < ActionMailer::Base
  default from: "foo@example.com"
  before_action :set_admins, only: admin_user_validated

  def welcome(person)
    @person = person
    mail to: @person
  end

  def validate_email(person)
    @person = person
    mail to: @person
  end
  
  def admin_user_validated(admins, user)
    # we are using instance vars because the mailer view 
    # uses them in its template
    @user = user 
    mail to: @admins
  end
  
  def admin_new_user(user)
    # we are using instance vars because the mailer view 
    # uses them in its template
    @user = user
    mail to: @admins
  end

  def admin_removing_unvalidated_users(users)
    # we are using instance vars because the mailer view 
    # uses them in its template
    @users = users
    mail to: @admins
  end

  private
    def set_admins
      @admins = Person.admins.pluck(:email)
    end
end