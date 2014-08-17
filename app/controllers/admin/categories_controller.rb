class Admin::CategoriesController < AdminController

  def index
    
  end

  def show
    @category = Category.find(params[:id])
    @posts = current_user.posts.where(category: @category)
    @posts = @posts.page(params[:page])
  end

end
