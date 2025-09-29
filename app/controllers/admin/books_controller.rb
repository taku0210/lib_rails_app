class Admin::BooksController < Admin::BaseController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /admin/books
  def index
    @books = Book.all.order(created_at: :desc)
  end

  # GET /admin/books/1
  def show
  end

  # GET /admin/books/new
  def new
    @book = Book.new
  end

  # GET /admin/books/1/edit
  def edit
  end

  # POST /admin/books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to admin_book_url(@book), notice: "書籍を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/books/1
  def update
    if @book.update(book_params)
      redirect_to admin_book_url(@book), notice: "書籍情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/books/1
  def destroy
    @book.destroy!
    redirect_to admin_books_url, notice: "書籍を削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :isbn, :category, :total_copies)
    end
end