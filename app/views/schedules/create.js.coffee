$('#schedulesTable').html('<%=j render "target_months/schedules" %>')
$('#totalTable').html('<%=j render "target_months/total_table" %>')
$('#scheduleForm').slideUp().html('')
$('#newSchedule').slideDown()
$('#bodyFlash').html('<%= bootstrap_flash %>')

