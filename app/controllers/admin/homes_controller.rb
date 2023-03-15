class Admin::HomesController < ApplicationController
  def top
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(6)
  end
end
