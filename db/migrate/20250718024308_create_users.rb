class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :student_no
      t.string :name
      t.string :role
      t.string :password

      t.timestamps
    end
  end
end
