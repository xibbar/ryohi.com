$('#scheduleFlash').slideUp().html('')
$('#tripExpenseFlash').slideUp().html('')

$('#newSchedule').slideUp()
$('#tripExpenseForm').slideUp().html('')
$('#scheduleForm').html('<%=j render "form" %>')
$('#scheduleForm').slideDown()

