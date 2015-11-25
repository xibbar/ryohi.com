class TargetMonthsController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index, :show ]
  before_action :set_company
  before_action :set_target_month, only: [:show, :edit, :update, :destroy]
  before_action :set_employees, except: [:index, :show, :destroy]

  # GET /target_months
  # GET /target_months.json
  def index
    @target_months = @company.target_months.order(year: :desc, month: :desc).page(params[:page]).per(Setting.per_page)
  end

  # GET /target_months/1
  # GET /target_months/1.json
  def show
    @style = 'seisansho'
  end

  # GET /target_months/new
  def new
    @target_month = @company.target_months.build( year: @now.year, month: @now.month )
  end

  # POST /target_months
  # POST /target_months.json
  def create
    @target_month = @company.target_months.build(target_month_params)

    respond_to do |format|
      if @target_month.save
        format.html { redirect_to [ @company, @target_month ], notice: t('notice.create', model_name: f(TargetMonth)) }
        format.json { render action: 'show', status: :created, location: @target_month }
      else
        flash[:alert] = t('alert.cant_save')
        format.html { render action: 'new' }
        format.json { render json: @target_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /target_months/1/edit
  def edit
  end

  # PATCH/PUT /target_months/1
  # PATCH/PUT /target_months/1.json
  def update
    respond_to do |format|
      if @target_month.update(target_month_params)
        format.html { redirect_to [ @company, @target_month ], notice: t('notice.update', model_name: f(TargetMonth)) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @target_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /target_months/1
  # DELETE /target_months/1.json
  def destroy
    @target_month.destroy
    respond_to do |format|
      format.html { redirect_to company_target_months_path( @company ) }
      format.json { head :no_content }
    end
  end

  private
    def set_company
      @company = current_user.companies.find( params[:company_id] )
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_target_month
      @target_month = @company.target_months.find(params[:id])
    end

    def set_employees
      @employees = @company.employees
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_month_params
      params.require(:target_month).permit(:company_id, :year, :month, :employee_id, :employee_name)
    end
end
