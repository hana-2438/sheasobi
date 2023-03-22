class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    if @range == "ユーザー"
      @members = Member.looks(params[:word]).page(params[:page]).per(12)
    else
      @posts = Post.looks(params[:word]).page(params[:page]).per(6)
    end
    @word = params[:word]
  end
  
end
