class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.all
    json_response(@messages)
  end

  # POST /messages
  def create
    @message = Message.create!(message_params)
    json_response(@message, :created)
  end

  # GET /messages/:id
  def show
    json_response(@message)
  end

  # PUT /messages/:id
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    # whitelist params
    params.permit(:title, :content, :created_by)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
