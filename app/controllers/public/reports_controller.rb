class Public::ReportsController < ApplicationController

  def new
    @report = Report.new
    # どのユーザーに対する通報か
    @member = Member.find(params[:member_id])
  end

  def create
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    # 通報者のidにcurrent_member.idを代入
    @report.reporter_id = current_member.id
    # 通報される人のid
    @report.reported_id = @member.id
    if @report.save
      ReportMailer.report_member(@member.email, @report.reason).deliver_now
      redirect_to member_path(@member), notice: "ご報告ありがとうございます。通報が完了しました。"
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end

end
