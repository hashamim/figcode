class MessagesController < ApplicationController
    def new
        @user = User.find_by(session_token: session[:session_token])

        #query the database for all the messages from the start of the calendar week
        week_start = Date.today.beginning_of_week
        @sent_messages = @user.sent_messages #.where("messages.created_at > ':week_start'",week_start: week_start)
        if @sent_messages.length < 5
            if @sent_messages.inject(0){ |total, msg| total + msg.number_of_characters} < 200
                @received_messages = @user.received_messages #.sort{|msg1, msg2| msg1.created_at <=> msg2.created_at}
                render :new
            else
                render json: {error: "no more characters left"}
            end
        else
            render json: {error: "out of emails"}
        end
    end
end