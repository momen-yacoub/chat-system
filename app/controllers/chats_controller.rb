class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, except: %i[create]

  def create
    result = ChatServices::Create.call(@application)
    if result.success?
      render json: result.object, status: :created
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def update
    result = ChatServices::Update.call(@chat)
    if result.success?
      render json: result.object, status: :ok
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def show
    render json: @chat, status: :found
  end

  private

  def set_application
    @application = Application.find_by!(sanitize_sql_for_conditions(['token=?', params[:application_token]]))
  end

  def set_chat
    @chat = Chat.find_by!(sanitize_sql_for_conditions(['application_id = ? AND chat_number = ?',
                                                       @application.id,
                                                       params[:number]]))
  end
end
