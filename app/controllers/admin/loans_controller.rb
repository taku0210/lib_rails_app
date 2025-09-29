class Admin::LoansController < Admin::BaseController
  # GET /admin/loans
  # 貸出・延滞一覧
  def index
    @borrowed_loans = Loan.includes(:user, :book).where(returned_at: nil).order(due_at: :asc)
    @overdue_loans = @borrowed_loans.where('due_at < ?', Date.today)
  end

  # GET /admin/loans/new
  # 新規貸出フォーム
  def new
    @loan = Loan.new
  end

  # POST /admin/loans
  # 貸出処理
  def create
    user = User.find_by(student_no: params[:loan][:student_no])
    book = Book.find_by(isbn: params[:loan][:isbn])

    unless user
      redirect_to new_admin_loan_path, alert: "学籍番号が見つかりません。" and return
    end
    unless book
      redirect_to new_admin_loan_path, alert: "ISBNが見つかりません。" and return
    end
    if book.available_copies <= 0
      redirect_to new_admin_loan_path, alert: "この本の在庫はありません。" and return
    end

    @loan = user.loans.new(
      book: book,
      borrowed_at: Time.zone.today,
      due_at: 2.weeks.from_now.to_date
    )

    if @loan.save
      redirect_to admin_loans_path, notice: "#{user.name}さんに「#{book.title}」を貸し出しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /admin/loans/:id
  # 返却処理
  def update
    loan = Loan.find(params[:id])
    loan.update!(returned_at: Time.zone.today)
    redirect_to admin_loans_path, notice: "「#{loan.book.title}」が返却されました。"
  end
end