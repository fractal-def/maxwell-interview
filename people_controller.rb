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
      Emails.validate_email(@person).deliver
      @admins = Person.where(:admin => true)
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
      @admins = Person.where(:admin => true)
      Emails.admin_user_validated(@admins, user)
      Emails.welcome(@user).deliver!
    end
  end

end