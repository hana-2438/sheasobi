class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_member.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    # js.erb用インスタンス変数
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
  end

  def destroy
    PostComment.find(params[:id]).destroy
    # js.erb用インスタンス変数
    @post = Post.find(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
