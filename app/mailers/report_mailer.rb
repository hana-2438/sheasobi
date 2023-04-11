class ReportMailer < ApplicationMailer
  
  def report_member(member_email, report_reason)
    @report_reason = report_reason
     mail(:to => member_email, :subject => '【しぇあそび】通報されました')
  end
  
end
