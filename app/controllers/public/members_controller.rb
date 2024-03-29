class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:edit, :update]
  before_action :ensure_guest_member, only: [:edit]

  def show
    @member = Member.find(params[:id])
    if @member.is_deleted
      redirect_to root_path
    end
    @posts = @member.posts.order(created_at: :desc).page(params[:page]).per(3)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "更新が完了しました！"
      redirect_to member_path(@member)
    else
      render :edit
    end
  end

  def confirm
    @member = current_member
  end

  def withdraw
    current_member.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  def favorites
    @member = Member.find(params[:id])
    # ユーザーがいいねしたすべての投稿のidを新着順で取得
    favorites = Favorite.order(created_at: :desc).where(member_id: @member.id).pluck(:post_id)
    # 投稿の中からユーザーがいいねした投稿を取得してくる
    @favorite_posts = Kaminari.paginate_array(Post.find(favorites)).page(params[:page]).per(6)
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :introduction, :is_deleted)
  end

  # current_member以外は編集できないようにするための記述
  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end

  # ゲストユーザーがプロフィール編集画面へ遷移できなくさせるための記述
  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.guest?
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      redirect_to member_path(current_member)
    end
  end

end

