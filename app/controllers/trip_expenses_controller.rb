class TripExpensesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm
  before_action :set_company
  before_action :set_target_month
  before_action :set_trip_expense, only: [:edit, :update, :destroy, :add_template]

  def new
    @trip_expense = TripExpense.new( schedule_id: params[:schedule] )
    @post_url = company_target_month_trip_expenses_path(@company, @target_month)
    @schedules = @target_month.schedules
    @method   = :post
  end

  def create
    @trip_expense = TripExpense.new(trip_expense_params)

    if @trip_expense.save
      flash[:notice] = t('notice.create', model_name: f(TripExpense))
    else
      @post_url = company_target_month_trip_expenses_path(@company, @target_month)
      @schedules = @target_month.schedules
      @method   = :post
      flash[:alert] = t('alert.cant_save')
      @formid = "tripExpenseForm"
      render 'session/show_alert'
    end
  end

  def edit
    @post_url = company_target_month_trip_expense_path(@company, @target_month, @trip_expense)
    @schedules = @target_month.schedules
    @method   = :put
    render 'new'
  end

  def update
    if @trip_expense.update_attributes(trip_expense_params)
      flash[:notice] = t('notice.update', model_name: f(TripExpense))
      render 'create'
    else
      @post_url = company_target_month_trip_expense_path(@company, @target_month, @trip_expense)
      @schedules = @target_month.schedules
      @method   = :put
      flash[:alert] = t('alert.cant_save')
      render 'session/show_alert'
    end
  end
  
  def merge_template
    expense_template = ExpenseTemplate.where( id: params[:expense_template_id] ).first
    if expense_template
      return_data = { section: expense_template.section, round: expense_template.round, way: expense_template.way, price: expense_template.price }
    else
      return_data = { section: '', round: true, way: '', price: '' }
    end
    render json: return_data
  end

  def destroy
    @trip_expense.destroy
    flash[:notice] = t('notice.destroy', model_name: f(TripExpense))
  end

  def add_template
    if @trip_expense.add_template( @target_month )
      flash[:notice] = t('notice.add', model_name: f(ExpenseTemplate))
    else
      flash[:alert] = t('alert.taken')
    end
    redirect_to company_target_month_path( @company, @target_month )
  end

  private

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_target_month
    @target_month = @company.target_months.find(params[:target_month_id])
  end

  def set_trip_expense
    @trip_expense = @target_month.trip_expenses.find(params[:id])
  end

  def trip_expense_params
    params.require(:trip_expense).permit(:schedule_id, :section, :round, :way, :price)
  end
end
