class RsvMailer < ApplicationMailer

  def complete_email(guest)
    @guest = guest
    mail(to: @guest.mail, subject: 'ご予約ありがとうございました！')
  end

end
