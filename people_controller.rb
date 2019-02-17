class People < ActionController::Base
  before_action :create_person, only: [:create]
  # ... Other REST actions

  def create
    if @person.save
      Emails.add_account
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
      Emails.admin_user_validated
      Emails.welcome(@user).deliver!
    end
  end

  private
  def create_person
    @person = Person.new(params[:person])
    @person.add_initial_attributes
  end
end