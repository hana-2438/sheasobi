# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
   before_action :member_state, only:[:create]

  def after_sign_in_path_for(resource)
    flash[:alert] = 'ログインしました。'
    root_path
  end

  def after_sign_out_path_for(resource)
    flash[:alert] = 'ログアウトしました。'
    root_path
  end

  def member_state
    # emailでmemberを特定
    @member = Member.find_by(email: params[:member][:email])
    # memberが存在している場合
    return if !@member
    # passwordがmemberのpasswordと一致しているか、及びmemberが削除されていないか
    if @member.valid_password?(params[:member][:password]) && @member.is_deleted == false
      # memberのpasswordが一致していない場合
    elsif !@member.valid_password?(params[:member][:password])
      flash[:alert] = 'パスワードが違います'
      redirect_to new_member_session_path
    else
      # memberが削除されている
      flash[:alert] = '退会済みです。再度新規登録を行なってください。'
      redirect_to root_path
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def guest_sign_in
    member = Member.guest
    sign_in member
    flash[:alert] = 'ゲストユーザーでログインしました。'
    redirect_to root_path
  end

end
