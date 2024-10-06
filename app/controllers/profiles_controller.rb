# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
  
    def show
      @product_domain = @user.product_domain || @user.build_product_domain
      @product_documents = @user.product_documents
    end
  
    def edit
      @product_domain = @user.product_domain || @user.build_product_domain
    end
  
    def update
      if @user.update(user_params)
        if params[:user][:product_documents].present?
          params[:user][:product_documents].each do |document|
            @user.product_documents.attach(document) unless document.blank?
          end
        end
        redirect_to profile_path, notice: 'Profile updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def set_user
      @user = User.includes(:product_domain).find(current_user.id)
    end
  
    def user_params
      params.require(:user).permit(
        :name, 
        :email, 
        :company,
        product_domain_attributes: [:id, :name, :description]
      )
    end
  end