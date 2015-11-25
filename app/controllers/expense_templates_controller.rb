class ExpenseTemplatesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index ]
  before_action :set_company
  before_action :set_employee
  before_action :set_expense_template, only: [:move, :edit, :update, :destroy]

  def index
    @expense_templates = @employee.expense_templates
  end

  def move
    case params[:move_type]
    when 'up'
      @expense_template.move_higher
      @target = @expense_template.lower_item
    when 'down'
      @expense_template.move_lower
      @target = @expense_template.higher_item
    else
      return head :ok
    end
  end

  def new
    @expense_template = @employee.expense_templates.build
  end

  def create
    @expense_template = @employee.expense_templates.build( expense_template_params )

    if @expense_template.save
      redirect_to company_employee_expense_templates_path( @company, @employee ), notice: t('notice.create', model_name: f(ExpenseTemplate))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  def edit
    render :new
  end

  def update
    if @expense_template.update( expense_template_params )
      redirect_to company_employee_expense_templates_path( @company, @employee ), notice: t('notice.update', model_name: f(ExpenseTemplate))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  def destroy
    @expense_template.destroy
    redirect_to company_employee_expense_templates_path( @company, @employee ), notice: t('notice.destroy', model_name: f(ExpenseTemplate))
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:employee_id])
  end

  def set_expense_template
    @expense_template = @employee.expense_templates.find(params[:id])
  end

  def expense_template_params
    params.require(:expense_template).permit(:section, :round, :way, :price)
  end
end
