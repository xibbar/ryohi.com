$('#schedulesTable').html('<%=j render "target_months/schedules" %>')
$('#totalTable').html('<%=j render "target_months/total_table" %>')
$('#scheduleFlash').html('<%= bootstrap_flash %>').slideDown()
$('#scheduleForm').slideUp().html('')
$('#newSchedule').slideDown()

