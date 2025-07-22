class User < ApplicationRecord
  has_many :loans
  has_many :books, through: :loans

  validates :student_no, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
end
