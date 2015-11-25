class CompaniesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index, :change_company ]
  before_action :set_company, only: [ :show, :edit, :update, :destroy, :change_daily_allowance ]

  def index
    @companies = current_user.companies
  end

  def show
  end

  def new
    @company = current_user.companies.build
  end

  def create
    @company = current_user.companies.build( company_params )
    if @company.save
      redirect_to companies_path, notice: t('notice.create', model_name: f(Company))
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'new'
    end
  end

  def edit
  end

  def update
    @company.attributes = params[:company].permit(:name, :current_password)
    if @company.valid?(:email)
      @company.save!
      redirect_to companies_path, notice: t('notice.update', model_name: f(Company))
    else
      flash.now[:alert] = t('alert.cant_save')
      render 'edit'
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_path, notice: t('notice.destroy', model_name: f(Company))
  end

  def change_daily_allowance
    logger.debug @page_name.inspect
    @company.update( daily_allowance: !( @company.daily_allowance ) )
  end

#  def resent_code
#  end

  def change_company
    company = current_user.companies.find( params[:next_id] ) if params[ :next_id ].present?
    if company
      redirect_to company_target_months_path( company ), notice: t( 'notice.change_successfull' )
    else
      redirect_to companies_path, alert: t( 'alert.change_unsuccessfull' )
    end
  end

  private

  def company_params
    params.require(:company).permit( :name )
  end

  def set_company
    @company = current_user.companies.find( params[:id] )
  end
end
