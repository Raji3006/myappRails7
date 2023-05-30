class MessagesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  
  def show
    @message = User.eager_load(:messages).select("users.*, messages.*").find(params[:id])
    @presenter = MessagePresenter.new(@message)
  end

  def index
    @messages = Message.includes(:user)
    @presenter = MessagePresenter.new(@messages)
  end

	def new
	  @message = Message.new
  end

	def edit
    @message = Message.find(params[:id])
  end

	def create
    def create
      @message = Message.new
      if @message.create_message(current_user.id, message_params)
        handle_successful_message_creation
      else
        handle_failed_message_creation
      end
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message && @message.update(message_params)
      flash[:notice] = "Post was updated successfully"
      redirect_to messages_path
    else
      flash[:notice] = "Post updation was not successfull"
      render 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message && @message.destroy
      flash[:notice] = "Message deleted successfully"
      redirect_to messages_path
    else 
      flash[:alert] = "Message not Found"
      redirect_to messages_path, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.required(:message).permit(:message, :user_id)
  end

  def handle_successful_message_creation
    flash[:notice] = "Your message was posted successfully"
    redirect_to messages_path
  end

  def handle_failed_message_creation
    @error_messages = @message.errors.full_messages
    render 'new', status: :unprocessable_entity
  end
  
end
