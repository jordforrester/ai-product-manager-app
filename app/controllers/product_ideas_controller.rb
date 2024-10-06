class ProductIdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_idea, only: [:show, :edit, :update, :destroy]

  def index
    @product_ideas = current_user.product_ideas.order(created_at: :desc)
  end

  def show
  end

  def new
    @product_idea = current_user.product_ideas.build
  end

  def edit
  end

  def create
    @product_idea = current_user.product_ideas.build(product_idea_params)

    respond_to do |format|
      if @product_idea.save
        format.html { redirect_to product_ideas_path, notice: 'Product idea was successfully created.' }
        format.json { render :show, status: :created, location: @product_idea }
      else
        format.html { render :new }
        format.json { render json: @product_idea.errors, status: :unprocessable_entity }
      end
    end
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
    @product_idea = current_user.product_ideas.find(params[:id])
    redirect_to product_ideas_path, alert: "Product idea not found." unless @product_idea
  end

  def product_idea_params
    params.require(:product_idea).permit(:title, :description, :status, :customer_acv, :customer_impact, :tshirt_size_effort)
  end
end
