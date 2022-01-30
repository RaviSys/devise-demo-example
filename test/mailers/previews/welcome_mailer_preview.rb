# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/welcome_mailer/send_greetings_notification
  def send_greetings_notification
    WelcomeMailer.send_greetings_notification
  end

end
