class SessionsController < ApplicationController
  def new
    # ログインフォームを表示する
  end

  def create
    user = User.find_by(student_no: params[:session][:student_no])

    # ユーザーが見つかり、かつパスワードが一致する場合
    if user && user.password == params[:session][:password]
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました。"
    else
      flash.now[:alert] = "学籍番号またはパスワードが間違っています。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "ログアウトしました。"
  end
end
