class LoansController < ApplicationController
  before_action :require_user
  before_action :set_loan, only: [:update]

  # GET /loans
  # ログインユーザーの貸出一覧
  def index
    @borrowing_loans = current_user.loans.where(returned_at: nil).order(due_at: :asc)
    @returned_loans = current_user.loans.where.not(returned_at: nil).order(returned_at: :desc)
  end

  # POST /loans
  # 貸出処理
  def create
    book = Book.find(params[:book_id])

    # 在庫チェック
    if book.available_copies <= 0
      redirect_to book_path(book), alert: "この本は現在すべて貸出中です。"
      return
    end

    # 貸出期間は2週間とする
    @loan = current_user.loans.new(
      book: book,
      borrowed_at: Time.zone.today,
      due_at: 2.weeks.from_now.to_date
    )

    if @loan.save
      # 貸出成功後は、操作を行った元のページ（書籍一覧や詳細）に戻す
      redirect_to request.referer || root_path, notice: "#{book.title} を借りました。返却期限は #{@loan.due_at} です。"
    else
      redirect_to book_path(book), alert: "貸出処理に失敗しました。"
    end
  end

  # PATCH/PUT /loans/:id
  # 返却処理
  def update
    if @loan.update(returned_at: Time.zone.today)
      redirect_to loans_path, notice: "#{@loan.book.title} を返却しました。"
    else
      redirect_to loans_path, alert: "返却処理に失敗しました。"
    end
  end

  private

  def set_loan
    @loan = current_user.loans.find(params[:id])
  end
end