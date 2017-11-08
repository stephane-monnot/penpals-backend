class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = current_user.messages.paginate(page: params[:page], per_page: 20)
    json_response(@messages)
  end

  # POST /messages
  def create
    @message = current_user.messages.create!(message_params)
    json_response(@message, :created)
  end

  # GET /messages/:id
  def show
    json_response(@message)
  end

  # PUT /messages/:id
  def update
    raise(ExceptionHandler::ForbiddenError, ResponseMessage.forbidden) if @current_user.id != @message.creator.id
    @message.update(message_params)
    head :no_content
  end

  # DELETE /messages/:id
  def destroy
    raise(ExceptionHandler::ForbiddenError, ResponseMessage.forbidden) if @current_user.id != @message.creator.id
    @message.destroy
    head :no_content
  end

  private

  def message_params
    # whitelist params
    params.permit(:title, :content)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
