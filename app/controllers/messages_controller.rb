class MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, except: %i[create]

  def create
    result = MessageServices::Create.call(@application, @chat)
    if result.success?
      render json: result.object, status: :created
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def update
    result = MessageServices::Update.call(@message)
    if result.success?
      render json: result.object, status: :ok
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def show
    render json: @message, status: :found
  end

  private

  def message_params
    require(:message).permit(:body)
  end

  def set_application
    @application = Application.find_by!(sanitize_sql_for_conditions(['token=?', params[:token]]))
  end

  def set_chat
    @chat = Chat.find_by!(sanitize_sql_for_conditions(['application_id = ? AND chat_number = ?',
                                                       @application.id,
                                                       params[:chat_number]]))
  end

  def set_message
    @message = Message.find_by!(sanitize_sql_for_conditions(['chat_id = ? AND message_number = ?',
                                                             @chat.id,
                                                             params[:message_number]]))
  end
end
