class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :create_default_settings
  after_filter :discard_flash_if_xhr

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
end
