class MessagesController < ApplicationController

  def show
    @message = User.eager_load(:messages).select("users.*, messages.*").find(params[:id])
  end

  def index
    @messages = Message.includes(:user)
  end

	def new
	  @message = Message.new
  end

	def edit
    @message = Message.find(params[:id])
  end

	def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      flash[:notice] = "Your message was posted successfully"
      AdminMailer.new_message(@message).deliver_now
      redirect_to messages_path
    else
      @error_messages = @message.errors.full_messages
      render 'new', status: :unprocessable_entity
		end
  end

  def update
    @message = Message.find(params[:id])
    if @message
      if @message.update(message_params)
        flash[:notice] = "Post was updated successfully"
        redirect_to messages_path
      else
        flash[:notice] = "Post updation was not successfull"
        render 'edit'
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message
      if @message.destroy
        flash[:notice] = "Message deleted successfully"
        redirect_to messages_path
      else 
        flash[:alert] = "Message not Found"
        redirect_to messages_path, status: :unprocessable_entity
      end
    end
  end

  private

  def message_params
    params.required(:message).permit(:message, :user_id)
  end
end
