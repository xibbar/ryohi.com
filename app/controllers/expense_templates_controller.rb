class ExpenseTemplatesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index ]
  before_action :set_company
  before_action :set_expense_template, only: [:edit, :update, :destroy]

  def index
    @expense_templates = @company.expense_templates
  end

  def new
    @expense_template = @company.expense_templates.build
  end

  def create
    @expense_template = @company.expense_templates.build( expense_template_params )

    if @expense_template.save
      redirect_to company_expense_templates_path( @company ), notice: t('notice.create', model_name: f(ExpenseTemplate))
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
      @expense_template.touch
      redirect_to company_expense_templates_path( @company ), notice: t('notice.update', model_name: f(ExpenseTemplate))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  def destroy
    @expense_template.destroy
    redirect_to company_expense_templates_path( @company ), notice: t('notice.destroy', model_name: f(ExpenseTemplate))
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_expense_template
    @expense_template = @company.expense_templates.find(params[:id])
  end

  def expense_template_params
    params.require(:expense_template).permit(:section, :round, :way, :price)
  end
end
