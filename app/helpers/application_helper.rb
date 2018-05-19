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

  def days_view(days)
    if days == 1
      "日帰り"
    else
      "#{days}日間"
    end
  end

  # 企業が登録されていなかったら登録を促す
  # 社員が登録されていなかったら登録を促す
  # 旅費精算書が登録されていなかったら登録を促す
  # 出張が登録されていなかったら登録を促す
  # 旅費が登録されていなかったら登録を促す
  def navigation
    if logged_in?
      # 会社が一社も登録されていない場合
      if current_user.companies.where.not(id: nil).empty?
        content_tag(:div,  class: 'panel panel-warning', id: 'navigation') do
          content_tag(:div,  class: 'panel-heading') do
            (t('navigation.no_company')+
             link_to(t('link.companies'), companies_path, class: '')+
             t('navigation.please_register')
            ).html_safe
          end
        end
      else
        # 会社が登録されているが、社員が登録されていない場合
        if current_user.companies.select{|c|c.employees.empty?}.any?
          content_tag(:div,  class: 'panel panel-warning', id: 'navigation') do
            content_tag(:div,  class: 'panel-heading') do
              (t('navigation.no_employee')%{path: link_to(t('link.companies'), companies_path, class: '')}
              ).html_safe
            end
          end
        # 日当が登録されていない場合
        elsif current_user.companies.select{|c|c.daily_allowances.empty?}.any?
          content_tag(:div,  class: 'panel panel-warning', id: 'navigation') do
            content_tag(:div,  class: 'panel-heading') do
              (t('navigation.no_daily_allowance')%{path: link_to(t('link.companies'), companies_path, class: '')}
              ).html_safe
            end
          end
        # 宿泊費が登録されていない場合
        elsif current_user.companies.select{|c|c.accommodation_charges.empty?}.any?
          content_tag(:div,  class: 'panel panel-warning', id: 'navigation') do
            content_tag(:div,  class: 'panel-heading') do
              (t('navigation.no_accommodation_charge')%{path: link_to(t('link.companies'), companies_path, class: '')}
              ).html_safe
            end
          end
#         # ターゲット月が登録されていない場合
#         elsif current_user.target_months.where.not(id: nil).empty?
#           content_tag(:div,  class: 'panel panel-warning', id: 'navigation') do
#             content_tag(:div,  class: 'panel-heading') do
#               (t('navigation.no_target_month')%{path: link_to(t('link.employees'), companies_path, class: '')}
#               ).html_safe
#             end
#           end
        elsif current_user.schedules.where.not(id: nil).empty?
          content_tag(:div,  class: 'panel panel-warning', id: 'navigation') do
            content_tag(:div,  class: 'panel-heading') do
              (t('navigation.no_schedule')%{path: link_to(t('link.employees'), companies_path, class: '')}
              ).html_safe
            end
          end
        else
          ''.html_safe
        end
      end
    else
      ''.html_safe
    end
  end

end
