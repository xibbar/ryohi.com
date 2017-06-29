class AccommodationChargesController < ApplicationController
  before_action :require_login
  before_action :expired_confirm, except: [ :index ]
  before_action :set_company
  before_action :set_accommodation_charge, only: [:show, :edit, :update, :destroy]

  # GET /accommodation_charges
  # GET /accommodation_charges.json
  def index
    @accommodation_charges = @company.accommodation_charges
  end

  # GET /accommodation_charges/1
  # GET /accommodation_charges/1.json
  def show
  end

  # GET /accommodation_charges/new
  def new
    @accommodation_charge = @company.accommodation_charges.build
  end

  # GET /accommodation_charges/1/edit
  def edit
    render :new
  end

  # POST /accommodation_charges
  # POST /accommodation_charges.json
  def create
    @accommodation_charge = @company.accommodation_charges.build(accommodation_charge_params)

    if @accommodation_charge.save
      redirect_to company_accommodation_charges_path( @company ), notice: t('notice.create', model_name: f(AccommodationCharge))
    else
      render :new
    end
  end

  # PATCH/PUT /accommodation_charges/1
  # PATCH/PUT /accommodation_charges/1.json
  def update
    if @accommodation_charge.update(accommodation_charge_params)
      redirect_to company_accommodation_charges_path( @company ), notice: t('notice.update', model_name: f(DailyAllowance))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  # DELETE /accommodation_charges/1
  # DELETE /accommodation_charges/1.json
  def destroy
    @accommodation_charge.destroy
    respond_to do |format|
      format.html { redirect_to accommodation_charges_url }
      format.json { head :no_content }
    end
  end

  private

  def set_accommodation_charge
    @accommodation_charge = AccommodationCharge.find(params[:id])
  end

  def accommodation_charge_params
    params.require(:accommodation_charge).permit(:company_id, :name, :amount)
  end

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end
end
