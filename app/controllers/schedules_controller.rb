class SchedulesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index, :change_company ]
  def index
    if params[:year]
      if params[:month]
        @date_range = Date.new(params[:year].to_i, params[:month].to_i)..Date.new(params[:year].to_i, params[:month].to_i).end_of_month
      else
        @date_range = Date.new(params[:year].to_i)..(Date.new(params[:year].to_i).end_of_year)
      end
      @schedules = current_user.schedules.where(date: @date_range).order(date: "DESC").page(params[:page])
    else
      @schedules = current_user.schedules.order(date: "DESC").page(params[:page])
    end
  end

  def new
    if params[:date]
      @schedule = Schedule.new(date: params[:date])
    else
      @schedule = Schedule.new(date: Date.today)
    end
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

  def daily_allowances
    if params[:employee_id]
      @daily_allowances = current_user.employees.find(params[:employee_id]).company.daily_allowances
    else
      render js: "$('#daily_allowances').html('')"
    end
  end

  def accommodation_charges
    if params[:employee_id] && params[:days] && params[:days].to_i > 1
      @accommodation_charges = current_user.employees.find(params[:employee_id]).company.accommodation_charges
    else
      render js: "$('#accommodation_charges').html('')"
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:employee_id, :date, :days, :destination, :business, :daily_allowance_id, :accommodation_charge_id)
  end
end
