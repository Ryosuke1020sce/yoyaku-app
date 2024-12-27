class ApplicationMailer < ActionMailer::Base
  helper :application # ApplicationHelper をインクルード
  default from: "Ryosuke Development"
  layout "mailer"
end
