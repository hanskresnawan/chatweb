class ChatroomsController < ApplicationController
    def index
        @chatrooms = Chatroom.all
      end
      def show
        @current_chatroom = Chatroom.find(params[:id])
      end
    def new
        @chatroom = Chatroom.new
        @chatrooms = Chatroom.all
      end
    
      def create
        puts "Submitted Params: #{params.inspect}" 
        @chatroom = Chatroom.new(chatroom_params)        
        
        if @chatroom.save
          redirect_to root_path, notice: 'Chatroom created successfully.'
        else
            flash.now[:alert] = 'Chatroom creation failed. Please fix the errors below.'
            render :new
        end
      end
      def destroy
        @chatroom = Chatroom.find(params[:id])
        @chatroom.chat_histories.destroy_all
        @chatroom.destroy
        
      
        respond_to do |format|
            redirect_to new_chatroom_path, notice: 'Chatroom deleted successfully.'
        end
      end
      def find_chatroom_id
        # Assuming you have a method to find the chatroom ID by name
        chatroom_name = params[:name]
        chatroom_id = Chatroom.find_by(name: chatroom_name)&.id
    
        render json: { chatroom_id: chatroom_id }
      end
      private
    
      def chatroom_params
        params.require(:chatroom).permit!
      end
end
