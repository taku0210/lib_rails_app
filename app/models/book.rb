class Book < ApplicationRecord
  has_many :loans
  has_many :users, through: :loans

  # 貸出可能な冊数を計算
  def available_copies
    # 総数から、まだ返却されていない貸出数を引く
    # .reload を追加して、キャッシュではなくDBから最新の貸出情報を取得する
    total_copies - loans.reload.where(returned_at: nil).count
  end
end
