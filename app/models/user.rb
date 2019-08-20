# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string
#  password             :string
#  address              :string
#  session_token        :string
#  remaining_emails     :integer
#  remaining_characters :integer
#

class User < ApplicationRecord
    validates :username, :password, :address, presence: true
    validates :username, :address, uniqueness: :true

    has_many :sent_messages,
        primary_key: :id,
        foreign_key: :sender_id,
        class_name: :Message

    has_many :received_messages,
        primary_key: :id,
        foreign_key: :receiver_id,
        class_name: :Message

    after_initialize :ensure_session_token, :ensure_messages
    def ensure_messages
        self.remaining_characters ||= 200
        self.remaining_emails ||= 5
    end
    def ensure_session_token
        self.session_token ||= rand(255)
    end

    def reset_session_token!
        self.session_token = rand(255)
        self.save!
        self.session_token
    end
end
