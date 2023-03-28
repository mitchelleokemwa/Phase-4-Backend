class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors: ["Invalid username or password", "Please try again"]}, status: :unauthorized
        end
    end

    def destroy
        return render json: {errors: ["User not found", "kindly log in"]}, status: :unauthorized unless session.include? :user_id
        session.delete :user_id
        head :no_content
    end
end
