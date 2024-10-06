class PrdsController < ApplicationController
  before_action :set_product_idea
  before_action :set_prd, only: [:show, :generating, :check_status]

  def new
    @prd = @product_idea.prds.new
  end

  def create
    @prd = @product_idea.prds.new(prd_params)
    @prd.status = 'pending'

    if @prd.save
      GeneratePrdJob.perform_later(@prd.id)
      flash[:notice] = 'PRD generation has started. Please wait...'
      redirect_to generating_product_idea_prd_path(@product_idea, @prd)
    else
      flash[:alert] = 'Failed to start PRD generation. Please try again.'
      render :new
    end
  end

  def show
    flash[:notice] = 'PRD generated successfully!' if @prd.status == 'completed'
  end

  def update
    @prd = Prd.find(params[:id])
    if @prd.update(prd_params)
      redirect_to product_idea_prd_path(@prd.product_idea, @prd), notice: 'PRD was successfully updated.'
    else
      render :edit
    end
  end

  def generating
  end

  def check_status
    render json: { 
      status: @prd.status, 
      url: @prd.status == 'completed' ? product_idea_prd_path(@product_idea, @prd) : nil,
      error: @prd.status == 'failed' ? @prd.content : nil
    }
  end

  private

  def set_product_idea
    @product_idea = ProductIdea.find(params[:product_idea_id])
  end

  def set_prd
    @prd = @product_idea.prds.includes(:product_idea).find(params[:id])
  end

  def prd_params
    params.require(:prd).permit(:content)
  end
end

