class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_member.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save!
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new

  end

  def destroy
    PostComment.find(params[:post_id]).destroy!
    @post = Post.find(params[:id])

  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
