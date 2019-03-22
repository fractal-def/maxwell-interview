class People < ActionController::Base

  # ... Other REST actions

  def create
    @person = Person.new(person_params)

    if @person.save
      Emails.validate_email(@person).deliver_later
      Emails.admin_new_user(@person).deliver_later
      redirect_to @person, :notice => "Account added!"
    else
      render :new
    end
  end

  def validate_email
    @user = Person.find_by_slug(params[:slug])
    if @user.present?
      @user.validated = true
      @user.save
      Rails.logger.info "USER: User ##{@person.id} validated email successfully."
      Emails.admin_user_validated(@user).deliver_later
      Emails.welcome(@user).deliver_later
    end
  end

  private
    # Strong params FTW
    def person_params
      params.require(:person).permit(
        :first_name, :last_name, :email, 
        :slug, :validated, :handle, :team
      )
    end
end