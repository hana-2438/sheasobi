class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿が完了しました！"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    # memberが退会済みだったら（is_deletedのみで退会を意味する）
    if @post.member.is_deleted
      redirect_to root_path
    end

    # その日一日、該当の投稿を閲覧していない場合閲覧数としてカウントする
    if member_signed_in?
      unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(member_id: current_member.id, post_id: @post.id)
       current_member.read_counts.create(post_id: @post.id)
      end
    end

    @member = @post.member.id
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新が完了しました！"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def index

    @tags = Tag.all
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      # modelに退会ユーザーを除外するメソッドを記述している(is_not_deleted)
      posts = @tag.posts.includes(:favorited_members).is_not_deleted
      order_posts = posts.order(created_at: :desc)
      
      @posts = order_posts.page(params[:page]).per(6)
      @count = @tag.posts.is_not_deleted.count
    else
      posts = Post.includes(:favorited_members).is_not_deleted
      if params[:sort] === "favorite"
        # left_joinsでいいねが0の投稿についても一覧に表示させる。groupで投稿ごとに分け、投稿ごとのいいね多い順で並び替える（pluckは配列で返す）
        order_posts = posts.left_joins(:favorites).group(:post_id).order('count(post_id) desc')
      else
        order_posts = posts.order(created_at: :desc)
      end
      @posts = order_posts.page(params[:page]).per(6)
      @count = Post.all.is_not_deleted.count
    end
  end
  private

  def post_params
    params.require(:post).permit(:tag_id, :region_id, :title, :place, :caption, :image).merge(member_id: current_member.id)
  end
end
