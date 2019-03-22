namespace :accounts do
  
  desc "Remove accounts where the email was never validated and it is over 30 days old"
  task :remove_unvalidated do
    @people = Person.invalidated
    @emails = @people.pluck(:email)
    @emails.each do |email|
      Rails.logger.info "Going to remove unvalidated user #{email}"
    end
    @people.destroy_all
    Emails.admin_removing_unvalidated_users(
      Person.admins.pluck(:email), 
      @people
    ).deliver
  end  
end