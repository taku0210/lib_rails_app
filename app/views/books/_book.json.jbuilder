json.extract! book, :id, :title, :author, :isbn, :category, :total_copies, :created_at, :updated_at
json.url book_url(book, format: :json)
