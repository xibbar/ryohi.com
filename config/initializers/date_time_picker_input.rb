class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group date form_datetime') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat span_table
    end
  end

  def input_html_options
    # classには配列で複数の設定が入ってくるので、それに'form-control'を追加してあげる
    # 単純にmergeしてしまうと、前のものが消えて'form-control'のみになってしまいバグる
    classes = (super[:class] || [])
    classes << :'form-control'
    # viewで指定された'readonly'がある場合は上書きしないようにする
    # カレンダーからの入力のみを許可したい場合は readonly: true を設定
    options = super
    options.merge({class: classes})
    options.merge({readonly: false}) unless options[:readonly]
    options
  end


  def span_table
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_table
    end
  end

  def icon_table
    "<span class='glyphicon glyphicon-calendar'></span>".html_safe
  end

end
