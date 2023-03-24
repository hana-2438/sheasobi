class Public::PostsController < ApplicationController
  before_action :ensure_correct_member, only: [:edit, :update]

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
      # ReadCountレコードの中に今日の日付のデータ（member_idがcurrent_member.id,で、post_idが現在params[:id]を受け取っている投稿）が存在しないか
      unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(member_id: current_member.id, post_id: @post.id)
        # 存在していなければ閲覧数としてカウントする
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
      # includesで親子関係にあるfavorited_membersのデータをすべて取得し、有効会員のデータのみ取得する
      posts = Post.includes(:favorited_members).is_not_deleted
      if params[:sort] === "favorite"
        # a,bで<=>演算子で比較し降順で並べ替えをする（いいね多い順）
        order_posts = posts.sort { |a, b| b.favorites.count <=> a.favorites.count }
      else
        # 投稿日の降順（新着順）で並び替え
        order_posts = posts.order(created_at: :desc)
      end
      if order_posts.class == Array
        @posts = Kaminari.paginate_array(order_posts).page(params[:page]).per(6)
      else
        @posts = order_posts.page(params[:page]).per(6)
      end
      @count = Post.all.is_not_deleted.count
    end
  end
  private

   # current_member以外は編集できないようにするための記述
  def ensure_correct_member
    @member = Post.find(params[:id]).member_id
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end

  def post_params
    # 認証目的でcurrent_member.idを渡している
    params.require(:post).permit(:tag_id, :region_id, :title, :place, :caption, :image).merge(member_id: current_member.id)
  end

end
