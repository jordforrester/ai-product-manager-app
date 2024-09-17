class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to authenticated_root_path if user_signed_in?
  end

  def dashboard
    # Add any dashboard-specific logic here
  end
end
