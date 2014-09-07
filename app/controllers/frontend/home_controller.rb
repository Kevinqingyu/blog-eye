
class Frontend::HomeController < FrontendController

  def index
    @codes = Code.limit(10).includes(:user)
    @posts = Post.order("likes desc, created_at desc").limit(10).includes(:user)
  end

end
