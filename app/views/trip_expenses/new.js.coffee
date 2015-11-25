$('#bodyFlash').slideUp().html('')
$('#scheduleFlash').slideUp().html('')
$('#tripExpenseFlash').slideUp().html('')
$('#scheduleForm').slideUp().html('')
$('#newSchedule').slideDown()
$('#tripExpenseForm').html('<%=j render "form" %>').slideDown()

