class InquiryMailer < ApplicationMailer

  # 送信元アドレス
  default from: "example@example.com"

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email, :subject => 'お問い合わせを承りました')
  end

end
