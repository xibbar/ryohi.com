content = $('#<%= @expense_template.position %>').fadeOut ->
  content.replaceWith('<%=j render 'expense_template', expense_template: @expense_template %>').fadeIn()

target = $('#<%= @target.position %>').fadeOut ->
  target.replaceWith('<%=j render 'expense_template', expense_template: @target %>').fadeIn()

