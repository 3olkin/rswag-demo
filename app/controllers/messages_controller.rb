class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    messages = Message.all
    render_json messages
  end

  def create
    message = current_user.messages.create!(message_params)
    render_json message, status: :created
  end

  def destroy
    message.destroy
    head(:no_content)
  end

  private

  def message
    @message ||= current_user.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:title, :body)
  end
end
