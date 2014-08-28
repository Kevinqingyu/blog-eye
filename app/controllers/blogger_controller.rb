
class BloggerController < FrontendController

  layout 'frontend/blogger'

  before_action :load_blogger

  protected
  def load_blogger
    @blogger = User.find(params[:user_id] || params[:id])
    @categories = @blogger.categories
    @posts = @blogger.posts
  end
end
