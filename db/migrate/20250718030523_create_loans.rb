class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.integer :user_id
      t.integer :book_id
      t.date :borrowed_at
      t.date :due_at
      t.date :returned_at

      t.timestamps
    end
  end
end
