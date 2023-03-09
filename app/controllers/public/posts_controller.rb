class Public::PostsController < ApplicationController
  before_action :exclude_deleted_member_posts, only: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path(@post)
    else
      redirect_to request.referer
    end
  end

  def show
  end

  def edit
  end

  def index
  end

private

  def post_params
    params.require(:post).permit(:tag_id, :region_id, :title, :place, :caption, :image).merge(member_id: current_member.id)
  end

  def exclude_deleted_member_posts
    # is_deletedがtrueのユーザーの投稿を除外する
    @posts = Post.joins(:member).where(member: { is_deleted: false })
  end
end
