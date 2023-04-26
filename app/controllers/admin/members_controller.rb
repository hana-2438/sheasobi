class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all.page(params[:page]).per(6)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "更新が完了しました！"
      redirect_to admin_members_path
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :introduction, :is_deleted)
  end

end
