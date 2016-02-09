class SchedulesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index, :change_company ]
  def index
    @schedules = current_user.schedules
  end

  def new
    @schedule = Schedule.new(date: Date.today)
    @employees = current_user.employees
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @employees = current_user.employees
    @schedule.employee = nil unless current_user.employee_ids.include?(@schedule.employee_id)
    if @schedule.save
      redirect_to @schedule , notice: t('notice.create', model_name: f(Schedule)) 
    else
      render action: 'new'
    end
  end

  def show
    @schedule = current_user.schedules.find(params[:id])
  end

  def edit
    @schedule = current_user.schedules.find(params[:id])
    @employees = current_user.employees
  end

  def update
    @schedule = current_user.schedules.find(params[:id])
    @employees = current_user.employees
    if @schedule.update(schedule_params)
      redirect_to @schedule, notice: t('notice.update', model_name: f(Schedule)) 
    else
      render action: 'edit'
    end
  end

  def destroy
    @schedule = current_user.schedules.find(params[:id])
    if @schedule.destroy
      redirect_to :schedules , notice: t('notice.destroy', model_name: f(Schedule)) 
    else
      redirect_to schedule_path(@schedule) , alert: t('alert.destroy') 
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:employee_id, :date, :days, :destination, :business, :trip_expense_only)
  end
end
