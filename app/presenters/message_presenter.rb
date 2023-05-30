class MessagePresenter
  def initialize(messages)
    @messages = messages
  end

  def formatted_created_at
    @messages.map { |message| message.created_at.strftime("%B - %Y") }  
  end
end
