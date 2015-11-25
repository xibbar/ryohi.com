require 'spec_helper'

describe "target_months/new" do
  before(:each) do
    assign(:target_month, stub_model(TargetMonth,
      :company_id => 1,
      :year => 1,
      :month => 1,
      :staff_name => "MyString",
      :index => "MyString",
      :new => "MyString",
      :edit => "MyString",
      :create => "MyString",
      :update => "MyString",
      :destroy => "MyString"
    ).as_new_record)
  end

  it "renders new target_month form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", target_months_path, "post" do
      assert_select "input#target_month_company_id[name=?]", "target_month[company_id]"
      assert_select "input#target_month_year[name=?]", "target_month[year]"
      assert_select "input#target_month_month[name=?]", "target_month[month]"
      assert_select "input#target_month_staff_name[name=?]", "target_month[staff_name]"
      assert_select "input#target_month_index[name=?]", "target_month[index]"
      assert_select "input#target_month_new[name=?]", "target_month[new]"
      assert_select "input#target_month_edit[name=?]", "target_month[edit]"
      assert_select "input#target_month_create[name=?]", "target_month[create]"
      assert_select "input#target_month_update[name=?]", "target_month[update]"
      assert_select "input#target_month_destroy[name=?]", "target_month[destroy]"
    end
  end
end
