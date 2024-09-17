class ProductIdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_idea, only: [:show, :edit, :update, :destroy]

  def index
    @product_ideas = ProductIdea.all
  end

  def show
    @product_idea = ProductIdea.includes(:prds).find(params[:id])
  end

  def new
    @product_idea = current_user.product_ideas.new
  end

  def create
    @product_idea = current_user.product_ideas.new(product_idea_params)
    if @product_idea.save
      redirect_to @product_idea, notice: 'Product idea was successfully created.'
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @product_idea.update(product_idea_params)
      redirect_to @product_idea, notice: 'Product idea was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product_idea.destroy
    redirect_to product_ideas_url, notice: 'Product idea was successfully destroyed.'
  end

  private

  def set_product_idea
    @product_idea = ProductIdea.includes(:prds).find(params[:id])
  end

  def product_idea_params
    params.require(:product_idea).permit(:title, :description, :status)
  end
end
