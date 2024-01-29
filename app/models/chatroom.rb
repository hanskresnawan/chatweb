class Chatroom < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :chat_histories, dependent: :destroy
end
