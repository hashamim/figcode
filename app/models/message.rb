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
    validates :content, :sender_id, :receiver_id, presence: true
    attr_reader :body
    attr_reader :receiver
    def body=(content)
        self.content = content
        self.number_of_characters = content.length
    end

    def receiver=(receiver)
        @receiver = receiver
        user = User.find_by(username: receiver)
        if(user)
            self.receiver_id = user.id
        else
            nil
        end
    end
end
