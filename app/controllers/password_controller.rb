class PasswordController < ApplicationController
  before_filter :confirm_reset_code, only: [:edit, :update]

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.passwords.create unless user.password
      Mailer.forgot_password(user).deliver_now
      redirect_to root_path, notice: t('notice.send')
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'new'
    end
  end

#  http://localhost:3000/password/04ec4d54ec016ae2/5968a0888bb44dce
  def edit
  end

  def update
    if @user.update_attributes( params[:user].permit(:password, :password_confirmation) )
      @password.destroy
      redirect_to root_path, notice: t('notice.update', model_name: f(Password))
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'edit'
    end
  end

  private

  def confirm_reset_code
    @user = User.find_by_login_key(params[:login_key])
    @password = Password.find_by_reset_key(params[:reset_code])
    return redirect_to root_path, alert: t('alert.code_missing') unless @user.passwords.member?(@password)
  end
end
