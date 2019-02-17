class People < ActionController::Base
  before_action :create_person, only: [:create]
  # ... Other REST actions

  def create
    if @person.save
      Emails.admin_new_user(@person)
      redirect_to @person, :notice => "Account added!"
    else
      render :new
    end
  end


  private
  def create_person
    @person = Person.new(params[:person])
    @person.add_initial_attributes
  end

  def validate_email
    @user = Person.find_by(slug: params[:slug])
    Emails.admin_user_validated(@user) if @user && @user.validate_email
  end
end