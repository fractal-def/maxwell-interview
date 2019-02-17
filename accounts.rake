namespace :accounts do
  desc "Remove accounts where the email was never validated and it is over 30 days old"
  task :remove_unvalidated do
    @people = Person.unvalidated
    Rails.logger.info "Removing unvalidated users."
    @people.destroy_all
    Emails.admin_removing_unvalidated_users.deliver
  end
end