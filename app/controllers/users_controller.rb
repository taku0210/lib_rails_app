class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功後、自動的にログインさせる
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ユーザー登録が完了し、ログインしました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:student_no, :name, :password)
  end
end
