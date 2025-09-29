class User < ApplicationRecord
  # パスワードをハッシュ化して保存
  has_secure_password

  has_many :loans
  has_many :books, through: :loans

  validates :student_no, presence: true, uniqueness: true
  validates :name, presence: true

  # ロール判定メソッド
  def admin?
    role == 'admin'
  end
end
