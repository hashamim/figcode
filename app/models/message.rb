# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  content              :string
#  number_of_characters :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  sender_id            :integer
#  receiver_id          :integer
#

class Message < ApplicationRecord
    validates :content, :sender_id, :receiver_id, :body, presence: true
    attr_reader :body
    def body=(content)
        self.content = content
        self.number_of_characters = content.length
    end
end
