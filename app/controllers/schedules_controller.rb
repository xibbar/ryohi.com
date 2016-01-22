class SchedulesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm
  before_action :set_company
  before_action :set_target_month
  before_action :set_schedule, only: [:edit, :update, :destroy]

  def new
    @schedule = @target_month.schedules.build( trip_date: 1, days: 1 )
    @post_url = company_target_month_schedules_path(@company, @target_month)
    @method   = :post
  end

  def create
    @schedule = @target_month.schedules.build(schedule_params)

    if @schedule.save
      flash[:notice] = t('notice.create', model_name: f(Schedule))
    else
      @post_url = company_target_month_schedules_path(@company, @target_month)
      @method   = :post
      flash[:alert] = t('alert.cant_save')
      @formid = "scheduleForm"
      render 'session/show_alert'
    end
  end

  def edit
    @post_url = company_target_month_schedule_path(@company, @target_month, @schedule)
    @method   = :put
    render 'new'
  end

  def update
    if @schedule.update_attributes(schedule_params)
      flash[:notice] = t('notice.update', model_name: f(Schedule))
      render 'create'
    else
      @post_url = company_target_month_schedule_path(@company, @target_month, @schedule)
      @method   = :put
      flash[:alert] = t('alert.cant_save')
      @formid = "scheduleForm"
      render 'session/show_alert'
    end
  end

  def destroy
    @schedule.destroy
    flash[:notice] = t('notice.destroy', model_name: f(Schedule))
    render 'create'
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_target_month
    @target_month = @company.target_months.find(params[:target_month_id])
  end

  def set_schedule
    @schedule = @target_month.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:target_month_id, :trip_date, :days, :destination, :business, :trip_expense_only)
  end
end
