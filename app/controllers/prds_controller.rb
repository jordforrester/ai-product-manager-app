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
      redirect_to generating_product_idea_prd_path(@product_idea, @prd), notice: 'PRD generation has started.'
    else
      render :new
    end
  end

  def show
  end

  def generating
  end

  def check_status
    @prd = @product_idea.prds.includes(:product_idea).find(params[:id])
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
    params.require(:prd).permit(:title)
  end
end

