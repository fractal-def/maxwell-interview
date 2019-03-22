class People < ActionController::Base

  # ... Other REST actions

  def create
    @person = Person.new(params[:person])

    slug = "ABC123#{Time.now.to_i.to_s}1239827#{rand(10000)}"
    @person.slug = slug
    @person.admin = false

    if (Person.count + 1).odd?
      team = "UnicornRainbows"
      handle = "UnicornRainbows" + (Person.count + 1).to_s
      @person.handle = handle
      @person.team = team
    else
      team = "LaserScorpions"
      handle = "LaserScorpions" + (Person.count + 1).to_s
      @person.handle = handle
      @person.team = team
    end

    if @person.save
      Emails.validate_email(@person).deliver_later
      Emails.admin_new_user(@person).deliver_later
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
      Emails.admin_user_validated(user)
      Emails.welcome(@user).deliver!
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(
        :first_name, :last_name, :email, 
        :slug, :validated, :handle, :team
      )
    end
end