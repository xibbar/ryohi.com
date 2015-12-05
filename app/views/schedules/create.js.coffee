$('#schedulesTable').html('<%=j render "target_months/schedules" %>')
$('#tripExpensesTable').html('<%=j render "target_months/trip_expenses" %>')
$('#totalTable').html('<%=j render "target_months/total_table" %>')
$('#scheduleForm').slideUp().html('')
$('#newSchedule').slideDown()
$('#bodyFlash').html('<%= bootstrap_flash %>')
$('#tripExpenseFlash').slideUp().html('')

