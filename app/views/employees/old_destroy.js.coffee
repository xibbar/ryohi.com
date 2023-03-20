$('#<%= dom_id @employee %>').remove()
target = $('.noitce')
if target.size() == 0
  $('.content').prepend('<%=j "<div class='notice'>#{flash[:notice]}</div>".html_safe %>')
else
  $('.notice').html('<%=j "<div class='notice'>#{flash[:notice]}</div>".html_safe %>')
$('#navigation').replaceWith('<%= navigation %>')

