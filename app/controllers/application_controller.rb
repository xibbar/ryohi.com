class ApplicationController < ActionController::Base

  protect_from_forgery
  before_action :create_default_settings
  after_action :discard_flash_if_xhr
#  before_action :force_redirect_to_www

  private

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

  def create_default_settings
    @now = Time.zone.now
    @page_name = "#{params[:controller].gsub(/\//, '.')}.#{params[:action]}"
  end

  def f(model, column = nil)
    model = model.class unless model.respond_to? :model_name
    column ? model.human_attribute_name(column) : model.model_name.human
  end
  helper_method :f

  def login_from_key(login_key)
    current_user = Company.find_by_login_key(login_key) if login_key || false
  end

  def expired_confirm
    return redirect_back_or_default( companies_path, alert: t('alert.expired') ) if current_user.expired?( @now )
  end

  def redirect_back_or_default( default_url, options )
    redirect_to ( request.referer || default_url ), options
  end

  def force_redirect_to_www
    if Rails.env == 'production' && request.host =~ /^ryohi\.com/
      redirect_to 'https://www.ryohi.com/'
    end
  end

  def csv_download( file_name, file_data )
    send_data( file_data,
              type: :csv,
              filename: NKF.nkf( '-U -s -Lw', file_name ),
              Disposition: 'download' )
  end
end
