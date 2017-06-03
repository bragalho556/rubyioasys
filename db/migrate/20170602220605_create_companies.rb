class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :about
      t.integer :ctype

      t.timestamps
    end
  end
end
