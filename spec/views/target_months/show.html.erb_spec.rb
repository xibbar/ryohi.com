require 'spec_helper'

describe "target_months/show" do
  before(:each) do
    @target_month = assign(:target_month, stub_model(TargetMonth,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Staff Name/)
    rendered.should match(/Index/)
    rendered.should match(/New/)
    rendered.should match(/Edit/)
    rendered.should match(/Create/)
    rendered.should match(/Update/)
    rendered.should match(/Destroy/)
  end
end
