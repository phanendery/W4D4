class SessionsController < ApplicationController
    
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email],params[:user][:password])
        
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(params[:user][:email],params[:user][:password])
            flash.now[:errors] = ["Invalid username or password combination"] #flash.now for render and redirect for other
            render :new
        end
    end

    def destroy
        logout
        render :new
    end
end
