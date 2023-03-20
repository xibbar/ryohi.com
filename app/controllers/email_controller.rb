class EmailController < ApplicationController
  before_action :require_login, except: [:activate]
  before_action :confirm_activate_code, only: [:activate]

  def new
    current_user.emails.build if current_user.emails.empty?
  end

  def create
    current_user.attributes = params[:company].permit(:current_password, :emails_attributes => [:email])

    if current_user.valid?(:email)
      current_user.emails.first.save!
      Mailer.email(current_user).deliver
      redirect_to target_months_path
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'new'
    end
  end

  def activate
    current_user.update_attributes(email: @email.email)
    @email.destroy
    redirect_to target_months_path, notice: t('notice.update', model_name: f(Email))
  end

  private

  def confirm_activate_code
    login_from_key(params[:login_key])
    @email = current_user.emails.find_by_activate_key(params[:activate_key]) if current_user
    return redirect_to root_path, alert: t('alert.code_missing') unless @email
  end
end
