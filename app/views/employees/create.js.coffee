$('#form').html('')
$('#newLink').show()
flash = $('.alert')
if flash.size() != 0
  flash.hide()
target = $('#employeesTable')
target.append('<%=j render "employee", employee: @employee %>')
$('.content').prepend('<%=j "<div class='notice'>#{flash[:notice]}</div>".html_safe %>')

