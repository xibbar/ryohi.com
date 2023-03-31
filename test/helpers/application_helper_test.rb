require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'enter_convert' do
    assert_equal "sample<br>", enter_convert("sample\r\n")
  end

  test 'escape_tags' do
    assert_equal "&lt;div&gt;sample&lt;/div&gt;", escape_tags("<div>sample</div>")
  end

  test 'days_view' do
    assert_equal '日帰り', days_view(1)
    assert_equal '2日間', days_view(2)
  end
end
