class Public::HomesController < ApplicationController
  def top
    @tags = Tag.all
    @posts = Post.all.order(created_at: :desc)
  end
end
