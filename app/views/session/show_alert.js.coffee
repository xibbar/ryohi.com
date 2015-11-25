form = $('#<%=@formid || "form" %>')
form.html('<%=j render "form" %>')
$('#form_flash').html('<%= bootstrap_flash %>')
