class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
  
    def new
      super
    end
  
    def create
      build_resource(sign_up_params)
  
      resource.save
      yield resource if block_given?
      if resource.persisted?
        create_product_domain
        upload_product_documents(resource)  # Pass resource as an argument
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  
    protected
  
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :name, 
        :company, 
        { product_documents: [] },  # Add this line to permit product documents
        product_domain_attributes: [:name, :description]
      ])
    end
  
    def create_product_domain
      return unless params[:user][:product_domain_attributes]
  
      @product_domain = resource.build_product_domain(params[:user][:product_domain_attributes])
      @product_domain.save
    end
  
    def upload_product_documents(resource)
      return unless params[:user] && params[:user][:product_documents]
      
      params[:user][:product_documents].each do |document|
        resource.product_documents.attach(document) if document.present?
      end
    end
  end