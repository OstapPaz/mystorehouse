class Admin::CategoriesController < Admin::BaseController

  def index
    @category = Category.new
    @categories = Category.all
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:info] = 'New category added'
      redirect_to admin_categories_path
    else
      render 'show'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = 'Category updated'
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'Category deleted'
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end