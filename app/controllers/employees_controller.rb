class EmployeesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index ]
  before_action :set_company
  before_action :staff_restrict_confirm, only: [ :new, :create ]

  def index
  end

  def new
    @employee = @company.employees.build
  end

  def create
    @employee = @company.employees.build( employee_params )
    if @employee.save
      flash[:notice] = t('notice.create', model_name: f(Employee))
    else
      flash[:alert] = t('alert.cant_save')
      render 'session/show_alert'
    end
  end

  def edit
    @employee = @company.employees.find(params[:id])
    render 'new'
  end

  def update
    @employee = @company.employees.find(params[:id])
    if @employee.update_attributes( employee_params )
      flash[:notice] = t('notice.update', model_name: f(Employee))
    else
      flash[:alert] = t('alert.cant_save')
      render 'session/show_alert'
    end
  end

  def destroy
    @employee = @company.employees.find(params[:id])
    @employee.destroy
    flash[:notice] = t('notice.destroy', model_name: f(Employee))
  end

  private

  def set_company
    @company = current_user.companies.find( params[ :company_id ] )
  end

  def employee_params
    params.require(:employee).permit(:name, :daily_allowance, :accommodation_charges)
  end

  def staff_restrict_confirm
    return redirect_to( company_employees_path( @company ), alert: t('alert.staff_restrict_over') ) if current_user.staff_restrict_over?
  end
end
