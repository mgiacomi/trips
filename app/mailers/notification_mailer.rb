class NotificationMailer < ApplicationMailer
  def fsa signup
    @signup = signup
    mail(to: signup.email, subject: '5th/8th/SSI Grade Trip Receipt')
  end
end
