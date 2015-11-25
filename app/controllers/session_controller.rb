class SessionController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def new
  end

  def create
    if login(params[:login], params[:password])
      redirect_to companies_path, notice: t('notice.login_successfull')
    else
      flash.now[:alert] = t('alert.failer_login')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('notice.logged_out')
  end

  def menu
    @companies = current_user.companies
    @company = @companies.find( params[ :company_id ] ) if params[ :company_id ]

    render layout: nil
  end
end
