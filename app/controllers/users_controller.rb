class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    def create
        @user = User.new(user_params)
        # debugger
        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages #flash.now for render and redirect for other
            render :new
        end
    end

    def destroy
        logout
        @user = User.new
        render :new
    end


    private
        #future use
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
