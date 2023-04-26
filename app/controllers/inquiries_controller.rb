class InquiriesController < ApplicationController

  def index
    # 入力画面の表示
    @inquiry = Inquiry.new
    render :index
  end

  def confirm
    # 入力値のチェック（お問い合わせ内容はデータとして保存しない）
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.valid?
      render :confirm
    else
      render :index
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver_now
    # 完了画面を表示
    render :thanks
  end

end
