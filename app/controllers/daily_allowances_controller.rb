class DailyAllowancesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index ]
  before_action :set_company
  before_action :set_daily_allowance, only: [:show, :edit, :update, :destroy]

  # GET /daily_allowances
  # GET /daily_allowances.json
  def index
    @daily_allowances = @company.daily_allowances
  end

  # GET /daily_allowances/1
  # GET /daily_allowances/1.json
  def show
  end

  # GET /daily_allowances/new
  def new
    @daily_allowance = @company.daily_allowances.build
  end

  # GET /daily_allowances/1/edit
  def edit
    render :new
  end

  # POST /daily_allowances
  # POST /daily_allowances.json
  def create
    @daily_allowance = @company.daily_allowances.build(daily_allowance_params)
    if @daily_allowance.save
      redirect_to company_daily_allowances_path( @company ), notice: t('notice.create', model_name: f(DailyAllowance))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  # PATCH/PUT /daily_allowances/1
  # PATCH/PUT /daily_allowances/1.json
  def update
    if @daily_allowance.update( daily_allowance_params )
      redirect_to company_daily_allowances_path( @company ), notice: t('notice.update', model_name: f(DailyAllowance))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  # DELETE /daily_allowances/1
  # DELETE /daily_allowances/1.json
  def destroy
    @daily_allowance.destroy
    redirect_to company_daily_allowances_path( @company ), notice: t('notice.destroy', model_name: f(DailyAllowance))
  end

  private

  def set_daily_allowance
    @daily_allowance = @company.daily_allowances.find(params[:id])
  end

  def daily_allowance_params
    params.require(:daily_allowance).permit(:name, :one_day_allowance, :accommodation_day_allowance, :return_day_allowance)
  end

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

end
