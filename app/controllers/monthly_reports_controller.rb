class MonthlyReportsController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index, :change_company ]
  before_action :set_year_month
  def index
    @companies = current_user.companies
  end
  def show
    @employee = current_user.employees.find(params[:employee_id])
    @schedules = @employee.schedules.where("to_char(date, 'yyyy-mm') = ?", @date.strftime("%Y-%m")).reorder(date: :asc)
    # @schedules = Schedule.where("to_char(date, 'yyyy-mm') = ?", @date.strftime("%Y-%m"))
  end
  private
  def set_year_month
    if params[:year] && params[:month]
      @date = Date.new(params[:year].to_i, params[:month].to_i)
    else
      @date = Date.today
    end
  end
end
