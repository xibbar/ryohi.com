$('#<%= dom_id @user %>').replaceWith('<%=j render "user", user: @user %>')
$('#bodyFlash').html('<%= bootstrap_flash %>')

