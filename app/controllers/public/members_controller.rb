class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:edit, :update]
  before_action :ensure_guest_member, only: [:edit]

  def show
    @member = Member.find(params[:id])
    if @member.is_deleted
      redirect_to root_path
    end
    @posts = @member.posts.page(params[:page]).per(3)

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
     @member = current_member.id
  end

  def withdraw
    current_member.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会しました。"
    redirect_to root_path
  end

  def favorites
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :introduction, :is_deleted)
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_user)
    end
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == "guestmember"
      redirect_to member_path(current_member), notice:"ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end


end

