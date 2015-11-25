target = $('#tripExpensesTable')
<% if @target_month.order_trip_expenses.empty? -%>
target.html('')
<% else -%>
target.html('<%=j render "target_months/trip_expenses" %>')
<% end -%>
$('#body_flash').html('<%= bootstrap_flash %>')
$('#totalTable').html('<%=j render "target_months/total_table" %>')

