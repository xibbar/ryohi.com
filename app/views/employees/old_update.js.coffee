$('#form').html('')
$('#newLink').show()
flash = $('.alert')
if flash.size() != 0
  flash.hide()
$('#<%= dom_id @employee %>').replaceWith('<%=j render "employee", employee: @employee %>')

