class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :genre
      t.string :ean_prefix, null: false
      t.string :registration_group, null: false
      t.string :registrant, null: false
      t.string :publication, null: false
      t.string :check_digit, null: false
      t.integer :total_copies, null: false
      t.integer :available_copies

      t.timestamps
    end
  end
end
