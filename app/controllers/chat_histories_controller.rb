class ChatHistoriesController < ApplicationController
    def index
        chatroom_id = params[:chatroom_id]
        @chat_histories = ChatHistory.where(chatroom_id: chatroom_id)
        render json: @chat_histories
      end
    def create
        @chat_history = ChatHistory.new(chat_history_params)
    
        if @chat_history.save
          redirect_to root_path
          render json: { message: 'Message sent successfully.' }, status: :ok
        else
          render json: { error: 'Error sending message.' }, status: :unprocessable_entity
        end
      end
      
      def fetch_messages
        # Your implementation to fetch chat messages based on the chatroom ID
        chatroom_id = params[:chatroom_id]
        @chat_histories = ChatHistory.where(chatroom_id: chatroom_id)

        render json: { messages: @chat_histories.map { |history| { user: history.user, text: history.text } } }
      end

        def fetch_for_chatroom
            chatroom_id = params[:chatroom_id]
            @chat_histories = ChatHistory.where(chatroom_id: chatroom_id)
        
            respond_to do |format|
              format.json { render json: @chat_histories }
            end
        end
      private
    
      def chat_history_params
        params.require(:chat_history).permit(:user, :text, :chatroom_id)
      end
end
