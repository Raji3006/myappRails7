class AdminMailer < ApplicationMailer
  default to: -> { AdminUser.pluck(:email) },
          from: 'rajeswari.behera3006@gmail.com'

  def new_message(message)
    @message = message
    mail(subject: "New message created: #{@message.message}")
  end
end
