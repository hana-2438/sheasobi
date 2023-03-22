class Public::HomesController < ApplicationController
  def top
    # タグ検索のための記述
    @tags = Tag.all
    # 新着順に投稿を表示させる
    @posts = Post.all.order(created_at: :desc)
  end
end
