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
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company, product_documents: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :company, product_documents: []])
  end
end

class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end

class ApplicationController < ActionController::Base
  before_action :prepare_notifications

  private

  def prepare_notifications
    return if flash.empty?

    if turbo_frame_request?
      flash.each do |type, message|
        response.set_header('Turbo-Stream', turbo_stream.append("notifications", partial: "shared/notification", locals: { message: message, type: type }))
      end
    else
      @notifications = flash.map do |type, message|
        { type: type, message: message }
      end
    end
  end
end