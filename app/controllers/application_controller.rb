class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end

def after_sign_in_path_for(resource)
  authenticated_root_path
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end

class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource_or_scope)
    root_path # or any other path you prefer
  end
end