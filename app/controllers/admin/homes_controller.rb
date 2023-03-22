class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    # created_at: :desc（降順）なので新着順に並ぶ
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(6)
  end
  
end
