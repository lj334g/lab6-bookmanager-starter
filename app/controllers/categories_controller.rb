class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def show
    # @category is set by the before_action
  end

  def new
    @category = Category.new
  end

  def edit
    # @category is set by the before_action
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category), notice: "#{@category.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "#{@category.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category was successfully deleted."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
