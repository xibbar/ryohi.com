module ApplicationHelper
  def error_messages_on(object, method, css_class = "formError")
    if (obj = (object.respond_to?(:errors) ? object : instance_variable_get("@#{object}"))) && (errors = obj.errors[method])
      errors_list = errors.map{|error| "[!] #{obj.errors.full_message(method, error)}<br/>"}.join
      content_tag("div", sanitize(errors_list), :class => css_class)
    else
      ''
    end
  end

  def enter_convert(text='', args={})
    sanitize(text.gsub(/\r\n|\r|\n/, "<br />"), args) if text
  end

  def default_sanitize
    { tags: %w(b i u sup sub small table tr th td br img font), attributes: %w(src color) }
  end

  def escape_tags(text='')
    enter_convert(text.gsub(/</, "&lt;").gsub(/>/, "&gt;"), default_sanitize)
  end

  def individual_css_file_exists?(name)
    !Ryohiseisan::Application.assets.find_asset("#{name}.css").nil?
  end

  def individual_js_file_exists?(name)
    !Ryohiseisan::Application.assets.find_asset("#{name}.js.erb").nil?
  end

  def form_require_description
#    I18n.t('[ * ] Required fields. Please be sure to enter.')
    I18n.t('require_message')
  end

  def require_mark
    sanitize("<span class='require_mark'>#{t('form.require')}</span>")
  end

  def active_current_controller?(cont, act=nil)
    if cont==request[:controller]
      if act
        act = [act] if act.is_a?(String)
        return act.member?(request[:action]) ? "active" : ""
      else
        return "active"
      end
    else
      return ""
    end
  end

  def expired_tag
    current_user.expired?(@now) ? ' disabled' : ''
  end
  def et(str)
    current_user.expired?(@now) ? t('alert.expired') : t(str)
  end

  def navigation
    if @target_month.schedules.empty?
      content_tag(:div, t(''))
    end
  end

end
