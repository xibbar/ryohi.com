class Rabbix::DailyAllowancesController < Rabbix::ApplicationController
  before_action :set_daily_allowance, only: [:show, :edit, :update, :destroy]

  # GET /daily_allowances
  # GET /daily_allowances.json
  def index
    @daily_allowances = DailyAllowance.all
  end

  # GET /daily_allowances/1
  # GET /daily_allowances/1.json
  def show
  end

  # GET /daily_allowances/new
  def new
    @daily_allowance = DailyAllowance.new
  end

  # GET /daily_allowances/1/edit
  def edit
  end

  # POST /daily_allowances
  # POST /daily_allowances.json
  def create
    @daily_allowance = DailyAllowance.new(daily_allowance_params)

    respond_to do |format|
      if @daily_allowance.save
        format.html { redirect_to [:rabbix, @daily_allowance], notice: 'Employee daily allowance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @daily_allowance }
      else
        format.html { render action: 'new' }
        format.json { render json: @daily_allowance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_allowances/1
  # PATCH/PUT /daily_allowances/1.json
  def update
    respond_to do |format|
      if @daily_allowance.update(daily_allowance_params)
        format.html { redirect_to [:rabbix, @daily_allowance], notice: 'Employee daily allowance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @daily_allowance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_allowances/1
  # DELETE /daily_allowances/1.json
  def destroy
    @daily_allowance.destroy
    respond_to do |format|
      format.html { redirect_to daily_allowances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_allowance
      @daily_allowance = DailyAllowance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_allowance_params
      params.require(:daily_allowance).permit(:employee_id, :name, :one_day_allowance, :accommodation_day_allowance, :return_day_allowance)
    end
end
