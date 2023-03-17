class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(6)
  end
end
