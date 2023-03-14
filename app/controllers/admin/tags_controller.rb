class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all.page(params[:page]).per(10)
    @tag = Tag.new
  end

  def create
    tag = Tag.new(tag_params)
    tag.save
    redirect_to request.referer
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = "更新が完了しました！"
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "タグを削除しました。"
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
