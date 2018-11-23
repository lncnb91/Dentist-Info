class CreateDentistCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :dentist_codes do |t|
      t.string :code, unique: true
      t.string :category

      t.timestamps
    end
  end
end
