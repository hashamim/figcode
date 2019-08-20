class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :number_of_characters
      t.timestamps
      t.integer :sender_id
      t.integer :receiver_id
    end
  end
end
