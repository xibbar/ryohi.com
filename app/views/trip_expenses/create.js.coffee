$('#tripExpensesTable').html('<%=j render "target_months/trip_expenses" %>')
$('#totalTable').html('<%=j render "target_months/total_table" %>')
$('#body_flash').html('<%= bootstrap_flash%>')
$('#newSchedule').slideDown()
$('#tripExpenseForm').slideUp()
$('#tripExpenseFlash').html('<%=bootstrap_flash%>').slideDown()