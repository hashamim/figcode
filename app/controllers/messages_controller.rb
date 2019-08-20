class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def new
        @user = User.find_by(session_token: session[:session_token])

        #query the database for all the messages from the start of the calendar week
        week_start = Date.today.beginning_of_week
        @sent_messages = @user.sent_messages #.where("messages.created_at > ':week_start'",week_start: week_start)
        @remaining_messages = 5 - @sent_messages.length
        if @remaining_messages > 0
            @remaining_characters = 200 - @sent_messages.inject(0){ |total, msg| total + msg.number_of_characters}
            if @remaining_characters > 0
                @received_messages = @user.received_messages #.sort{|msg1, msg2| msg1.created_at <=> msg2.created_at}
                render :new
            else
                render json: {error: "no more characters left"}
            end
        else
            render json: {error: "out of emails"}
        end
    end

    def create
        @message = Message.new(message_params)
        if @message.save
            redirect_to new_message_url
        else
            render json: {error: @message.errors.full_messages }
        end
    end

    private
    def message_params
        params.require(:message).permit(:receiver, :body, :sender_id)
    end
end