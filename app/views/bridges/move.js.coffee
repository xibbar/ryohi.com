content = $('#<%= @bridge.position %>').fadeOut ->
  content.replaceWith('<%=j render 'bridge', bridge: @bridge %>').fadeIn()

target = $('#<%= @target.position %>').fadeOut ->
  target.replaceWith('<%=j render 'bridge', bridge: @target %>').fadeIn()

