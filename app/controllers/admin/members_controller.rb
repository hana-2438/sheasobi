class Admin::MembersController < ApplicationController
  def index
    @members = Member.all.page(params[:page]).per(6)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
  end

end
