class ApplicationController < ActionController::Base
  around_action :set_time_zone, if: :current_user

  private

  def set_time_zone
    user_time_zone = current_user.time_zone
    Time.use_zone(user_time_zone) { yield }
  end
end
