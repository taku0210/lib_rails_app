# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 管理者ユーザーを検索または作成
User.find_or_create_by!(student_no: 'admin') do |user|
  user.name = '管理者'
  user.password = 'password' # 強力なパスワードに変更してください
  user.password_confirmation = 'password'
  user.role = 'admin'
  puts '管理者ユーザーを作成しました。'
end

# 書籍データを検索または作成
books_data = [
  {
    title: "はじめてのRuby",
    author: "Yukihiro Matsumoto",
    isbn: "978-4-7973-9626-9",
    category: "プログラミング",
    total_copies: 5
  },
  {
    title: "Ruby on Rails チュートリアル",
    author: "Michael Hartl",
    isbn: "978-4-908142-92-1",
    category: "Web開発",
    total_copies: 3
  },
  { title: "オブジェクト指向設計実践ガイド", author: "Sandi Metz", isbn: "978-4-7741-9133-0", category: "ソフトウェア設計", total_copies: 4 },
  { title: "リーダブルコード", author: "Dustin Boswell", isbn: "978-4-87311-565-8", category: "プログラミング", total_copies: 10 },
  { title: "SQLアンチパターン", author: "Bill Karwin", isbn: "978-4-87311-589-4", category: "データベース", total_copies: 2 }
]

books_data.each do |book_attrs|
  Book.find_or_create_by!(isbn: book_attrs[:isbn]) do |book|
    book.assign_attributes(book_attrs)
    puts "書籍 '#{book.title}' を作成しました。"
  end
end
