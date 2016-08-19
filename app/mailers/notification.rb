class Notification < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.bookreturned.subject
  #
  def bookreturned(barrowingbook,user)
    @barrowingbook = barrowingbook
    @user =user
    
    mail to: "#{@barrowingbook.user.email}",cc: "#{user.email}",subject: "Book has been returned!"
  end
end


