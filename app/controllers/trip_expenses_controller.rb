class TripExpensesController < ApplicationController
  before_action :require_login
  # before_action :expired_confirm, except: [ :index, :change_company ]
  before_action :set_schedule

  def new
    # @trip_expense = TripExpense.new(schedule: @schedule)
    @trip_expense = @schedule.trip_expenses.build
  end

  def create
    @trip_expense = TripExpense.new(trip_expense_params.merge(schedule: @schedule))
    if @trip_expense.save
      flash[:notice] = t('notice.create', model_name: f(TripExpense))
      redirect_to schedule_path(@schedule)
    else
      render action: 'new'
    end
  end

  def edit
    @trip_expense = @schedule.trip_expenses.find(params[:id])
  end

  def update
    @trip_expense = @schedule.trip_expenses.find(params[:id])
    if @trip_expense.update(trip_expense_params)
      redirect_to @schedule, notice: t('notice.update', model_name: f(TripExpense)) 
    else
      render action: 'edit'
    end
  end

  def destroy
    @trip_expense = @schedule.trip_expenses.find(params[:id])
    if @trip_expense.destroy
      redirect_to schedule_path(@schedule) , notice: t('notice.destroy', model_name: f(TripExpense)) 
    else
      redirect_to schedule_path(@schedule) , alert: t('alert.destroy') 
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

  def add_template
    @trip_expense = @schedule.trip_expenses.find(params[:id])
    if @trip_expense.add_template( @schedule )
      flash[:notice] = t('notice.add', model_name: f(ExpenseTemplate))
    else
      flash[:alert] = t('alert.taken')
    end
    redirect_to schedule_path( @schedule )
  end

  private

  def set_schedule
    @schedule = current_user.schedules.find(params[:schedule_id])
  end

  def trip_expense_params
    params.require(:trip_expense).permit(:section, :round, :way, :price)
  end
end
