class Rabbix::AccommodationChargesController < Rabbix::ApplicationController
  before_action :set_accommodation_charge, only: [:show, :edit, :update, :destroy]

  # GET /accommodation_charges
  # GET /accommodation_charges.json
  def index
    @accommodation_charges = AccommodationCharge.all
  end

  # GET /accommodation_charges/1
  # GET /accommodation_charges/1.json
  def show
  end

  # GET /accommodation_charges/new
  def new
    @accommodation_charge = AccommodationCharge.new
  end

  # GET /accommodation_charges/1/edit
  def edit
  end

  # POST /accommodation_charges
  # POST /accommodation_charges.json
  def create
    @accommodation_charge = AccommodationCharge.new(accommodation_charge_params)

    respond_to do |format|
      if @accommodation_charge.save
        format.html { redirect_to @accommodation_charge, notice: 'Accommodation charge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accommodation_charge }
      else
        format.html { render action: 'new' }
        format.json { render json: @accommodation_charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accommodation_charges/1
  # PATCH/PUT /accommodation_charges/1.json
  def update
    respond_to do |format|
      if @accommodation_charge.update(accommodation_charge_params)
        format.html { redirect_to @accommodation_charge, notice: 'Accommodation charge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @accommodation_charge.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_accommodation_charge
      @accommodation_charge = AccommodationCharge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accommodation_charge_params
      params.require(:accommodation_charge).permit(:company_id, :name, :amount)
    end
end
