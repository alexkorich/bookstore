class CategoriesController < ApplicationController
  authorize_resource
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @category=Category.find(params[:id])
    @books=@category.books.page(params[:page])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params[:category]
    end
end
