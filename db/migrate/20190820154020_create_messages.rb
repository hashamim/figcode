class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :number_of_characters
      t.timestamps
      t.references :sender, foreign_key: true
      t.references :receiver, foreign_key: true
    end
  end
end
