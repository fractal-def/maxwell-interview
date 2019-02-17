class People < ActionController::Base
  before_action :create_person, only: [:create]
  # ... Other REST actions

  def create
    if @person.save
      Emails.validate_email(@person).deliver
      @admins = Person.administrators
      Emails.admin_new_user(@admins, @person).deliver
      redirect_to @person, :notice => "Account added!"
    else
      render :new
    end
  end

  def validateEmail
    @user = Person.find_by_slug(params[:slug])
    if @user.present?
      @user.validated = true
      @user.save
      Rails.logger.info "USER: User ##{@person.id} validated email successfully."
      @admins = Person.administrators
      Emails.admin_user_validated(@admins, user)
      Emails.welcome(@user).deliver!
    end
  end

  private
  def create_person
    @person = Person.new(params[:person])
    @person.add_initial_attributes
  end
end