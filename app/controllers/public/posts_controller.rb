class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to request.referer
    end
  end

  def show
    @post = Post.find(params[:id])
    # memberが退会済みだったら（is_deletedのみで退会を意味する）
    if @post.member.is_deleted
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  def edit
  end

  def index
    
    @posts = Post.is_not_deleted
  end

private

  def post_params
    params.require(:post).permit(:tag_id, :region_id, :title, :place, :caption, :image).merge(member_id: current_member.id)
  end
end
