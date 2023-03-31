class UsersController < ApplicationController
  before_action :require_login, except: [ :index, :new, :create, :activation ]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: t('notice.create', model_name: f(User))
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.attributes = params[:user].permit(:name, :current_password)
    if @user.valid?(:email)
      @user.save!
      redirect_to users_path, notice: t('notice.update', model_name: f(User))
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'edit'
    end
  end

  def email
    @user = current_user
  end

  def update_email
    @user = current_user
    @user.attributes = params[:user].permit(:email, :current_password)
    if @user.valid?(:email)
      @user.save!
      redirect_to users_path, notice: t('notice.update', model_name: f(User))
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'email'
    end
  end

  def prefecture
    @user = current_user
  end

  def update_prefecture
    @user = current_user
    @user.attributes = params[:user].permit(:prefecture, :current_password)
    if current_user.valid_password?(params[:user][:current_password]) && @user.valid?(:prefecture)
      @user.save!
      redirect_to users_path, notice: t('notice.update', model_name: f(User))
    else
      current_user.errors.add(:current_password, :mistake)
      flash.now[:alert] = t('alert.cant_save')
      render 'prefecture'
    end
  end

  def password
  end

  def update_password
    if current_user.valid_password?( params[ :user ][ :current_password ] )
      current_user.attributes = params[:user].permit(:password, :password_confirmation, :current_password)
      return redirect_to users_path, notice: t('notice.update', model_name: f(User)) if current_user.save(context: :password)
    else
      current_user.errors.add( :current_password, :mistake)
    end

    flash.now[:alert] = t('alert.cant_save')
    render 'password'
  end

  def activation
#http://localhost:3000/activation/SWkGsWMkV6av1ahVSNxg
    @user = User.find_by_activation_token(params[:activation_token])
    if @user
      @user.activate!
      auto_login( @user )
      redirect_to users_path, notice: t('notice.activation')
    else
      redirect_to root_path, alert: t('alert.code_missing')
    end
  end

  private

  def user_params
    params.require(:user).permit( :login, :email, :password, :password_confirmation, :name, :prefecture )
  end
end
