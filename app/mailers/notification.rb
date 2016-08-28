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

  def booktoreturn(barrowingbook,user)
    @barrowingbook=barrowingbook
    @user=user

    mail to:"#{@barrowingbook.user.email}",cc:"#{user.email}",subject:"Last date to return book!"
  end   
 
 def announcement(mail_ids,user)
    @user=user
    mail to:"#{mail_ids}",cc:"#{user.email}",subject:"Last date to return book!"
  end 

  def greeting(announcement)
    @announcement=announcement
    @recipents=User.all.pluck(:email)
    mail to:@recipents.join(","),subject:"#{@announcement.body}"
   end 
end


