class Rabbix::UsersController < Rabbix::ApplicationController
  before_action :set_user, except: [ :index ]

  def index
#    @users = User.order( :id ).page( params[ :page ] ).per( Setting.per_page )
    @users = User.search( params[:name], params[:order], params[:page] )
  end

  def update_user
  end

  def edit_staff_restrict
  end

  def update_staff_restrict
    unless @user.update_attributes( params.require( :user ).permit( :staff_restrict ) )
      flash[:alert] = t('alert.cant_save')
      render 'show_alert', locals: { form_name: "edit_user_#{ @user.id }", render_file: "staff_restrict_form" }
    end
    flash[:notice] = t('notice.update', model_name: f( User, :staff_restrict ))
  end

  def edit_expires
  end

  def update_expires
    @user.attributes = params.require( :user ).permit( :expires_at )
    if @user.valid?
      @user.update_attribute( :expires_at, @user.expires_at.try( :end_of_month ) )
      flash[:notice] = t('notice.update', model_name: f( User, :expires_at ))
    else
      flash[:alert] = t('alert.cant_save')
      render 'show_alert', locals: { form_name: "expires_form_#{ @user.id }", render_file: "expires_form" }
    end
  end

  private

  def set_user
    @user = User.find( params[ :id ] )
  end
end
