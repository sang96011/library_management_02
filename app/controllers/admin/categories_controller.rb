class Admin::CategoriesController < ApplicationController
  before_action :find_category, except: [:new, :index, :create]

  def index
    @categories = Category.all
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.categories.create.success"
      redirect_to admin_category_path @category
    else
      flash[:success] = t "admin.categories.create.error"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.categories.update.success"
      redirect_to admin_categories_path
    else
      flash[:success] = t "admin.categories.update.error"
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "admin.categories.destroy.success"
    redirect_to admin_categories_path
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "admin.categories.error.not_found"
      redirect_to admin_root_path
    end
  end

  def category_params
    params.require(:category).permit :name
  end
end
