class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    unless user = user_exists?(params[:session][:email])
      flash.now[:danger] = 'Can\'t find the user with this email' # Not quite right!
      render 'new'
      return
    end

    if password_correct?(user, params[:session][:password])
      log_in(user)
      remember(user)
      flash[:success] = 'Successfully logged in'
      redirect_to user
    else
      flash.now[:danger] = "Invalid password for user #{user.email}" # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def password_correct?(user, password)
    !!user.authenticate(password)
  end

  def user_exists?(email)
    User.find_by(email: email.downcase)
  end
end
