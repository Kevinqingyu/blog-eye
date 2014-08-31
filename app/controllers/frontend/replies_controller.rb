class Frontend::RepliesController < BloggerController
  
  def create
    @reply = Reply.new(reply_params)
    @reply.user_id = current_user.id
    @reply.post_id = @post.id

    if @reply.save
      flash[:notice] = '你已经成功提交了回复。'
      redirect_to frontend_post_path(@post)
    else
      flash[:error] = '提交回复失败，请注意以下提示。'
      redirect_to frontend_post_path(@post)
    end
  end

  protected
  # override super method
  def load_blogger
    post_id = params[:post_id]
    @post = Post.find(post_id)
    @blogger = @post.user
  end

  private
  def reply_params
    params.require(:reply).permit(:user_id, :post_id, :last_reply_id, :content, :is_public)
  end
end
