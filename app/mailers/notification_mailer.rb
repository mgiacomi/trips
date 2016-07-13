class NotificationMailer < ApplicationMailer
  def fsa signup
    @signup = signup
    mail(to: signup.email, subject: '5th/8th Grade Trip Receipt')
  end
end
