class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception

  # ビューでも使えるようにヘルパーメソッドとして定義
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  # ログインが必要なコントローラで呼び出すためのメソッド
  def require_user
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です。"
    end
  end
end
