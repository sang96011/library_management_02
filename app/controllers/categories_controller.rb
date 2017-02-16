class CategoriesController < ApplicationController
  before_action :find_category, only: :show

  def show
    @categories = Category.all
    @books = @category.books
      .paginate page: params[:page], per_page: Settings.static_pages.per_page
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "categories.error.not_found"
      redirect_to root_path
    end
  end
end
