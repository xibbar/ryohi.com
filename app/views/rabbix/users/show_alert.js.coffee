notice = $('.notice')
notice.remove()
target = $('.alert')
if target.size() == 0
  $('.content').before('<%=j "<div class='alert'>#{flash[:alert]}</div>".html_safe %>')
else
  $('.alert').html('<%= flash[:alert] %>')
form = $('#<%= form_name %>')
form.replaceWith('<%=j render render_file %>')

