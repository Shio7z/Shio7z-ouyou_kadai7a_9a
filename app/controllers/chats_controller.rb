class ChatsController < ApplicationController
  def show
    @partner = User.find(params[:id])
    @chats = Chat.where("(partner_id = ?) OR (users_id = ?)", @partner.id, @partner.id)
    @chat = Chat.new
  end

  def create
    chat = Chat.new(chat_params)
    chat.users_id = current_user.id
    chat.save
    redirect_to  chat_path(chat_params["partner_id"])
  end


  private
  # ストロングパラメータ
  def chat_params
    params.require(:chat).permit(:message, :partner_id)
  end
end
