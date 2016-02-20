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
    if @company.update(company_params)
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

  private

  def company_params
    params.require(:company).permit( :name, :daily_allowance )
  end

  def set_company
    @company = current_user.companies.find( params[:id] )
  end
end
