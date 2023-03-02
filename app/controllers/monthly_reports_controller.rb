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

  def export_to_yayoi
    unless Setting.yayoi_export.member?(current_user.id)
      redirect_to root_path
      return
    end
    @company = current_user.companies.find(params[:company_id])
    @month_array = (Date.parse("#{params[:from_month]}01")..Date.parse("#{params[:to_month]}01")).map{|d| [d.year, d.month]}.uniq
    csv_data = render_to_string("export_to_yayoi.csv")
    csv_data = NKF.nkf( '-U -s -Lw', csv_data )
    filename = "yayoi_#{params[:from_month]}-#{params[:to_month]}.txt"
    csv_download( filename, csv_data )
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
