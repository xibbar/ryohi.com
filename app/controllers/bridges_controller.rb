class BridgesController < ApplicationController
  before_filter :require_login
  before_filter :set_bridge, only: [ :move, :destroy ]

  def index
  end

  def move
    case params[:move_type]
    when 'up'
      @bridge.move_higher
      @target = @bridge.lower_item
    when 'down'
      @bridge.move_lower
      @target = @bridge.higher_item
    else
      return head :ok
    end
  end

  def new
    @bridge = current_user.bridges.build
  end

  def create
    @bridge = current_user.bridges.build( bridge_params )

    if @bridge.valid?( :check_password )
      @bridge.both_save
      redirect_to bridges_path, notice: t('notice.create', model_name: f(Bridge))
    else
      flash.now[:alert] = t('cant_save')
      render :new
    end
  end

  def destroy
    @bridge.both_destroy
    redirect_to bridges_path, notice: t('notice.destroy', model_name: f(Bridge))
  end

  private

  def set_bridge
    @bridge = current_user.bridges.find(params[:id])
  end

  def bridge_params
    params.require(:bridge).permit( :login, :password )
  end
end
