require 'spec_helper'

describe "target_months/index" do
  before(:each) do
    assign(:target_months, [
      stub_model(TargetMonth,
        :company_id => 1,
        :year => 2,
        :month => 3,
        :staff_name => "Staff Name",
        :index => "Index",
        :new => "New",
        :edit => "Edit",
        :create => "Create",
        :update => "Update",
        :destroy => "Destroy"
      ),
      stub_model(TargetMonth,
        :company_id => 1,
        :year => 2,
        :month => 3,
        :staff_name => "Staff Name",
        :index => "Index",
        :new => "New",
        :edit => "Edit",
        :create => "Create",
        :update => "Update",
        :destroy => "Destroy"
      )
    ])
  end

  it "renders a list of target_months" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Staff Name".to_s, :count => 2
    assert_select "tr>td", :text => "Index".to_s, :count => 2
    assert_select "tr>td", :text => "New".to_s, :count => 2
    assert_select "tr>td", :text => "Edit".to_s, :count => 2
    assert_select "tr>td", :text => "Create".to_s, :count => 2
    assert_select "tr>td", :text => "Update".to_s, :count => 2
    assert_select "tr>td", :text => "Destroy".to_s, :count => 2
  end
end
