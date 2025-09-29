# app/controllers/admin/dashboard_controller.rb
class Admin::DashboardController < Admin::BaseController
  def index
    # ダッシュボードに表示するサマリー情報を取得
    @total_books_count = Book.count
    @total_users_count = User.where(role: 'user').count # 管理者を除いたユーザー数
    @borrowed_loans_count = Loan.where(returned_at: nil).count
    @overdue_loans_count = Loan.where(returned_at: nil).where('due_at < ?', Date.today).count
  end
end