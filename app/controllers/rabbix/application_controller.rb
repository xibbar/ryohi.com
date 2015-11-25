class Rabbix::ApplicationController < ApplicationController
  protect_from_forgery
  before_action :rabbix_confirm
  layout "administrator"


  private

  def rabbix_confirm
    authenticate_or_request_with_http_basic do |user, pass|
      user == Setting.basic_name && pass == Setting.basic_pass
    end
  end
end
