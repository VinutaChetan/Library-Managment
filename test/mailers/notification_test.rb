require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "bookreturned" do
    mail = Notification.bookreturned
    assert_equal "Bookreturned", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
