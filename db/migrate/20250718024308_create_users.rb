class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :student_no
      t.string :name
      t.string :role, default: 'student', null: false # string型に変更
      t.string :password_digest # passwordから変更

      t.timestamps
    end
  end
end
