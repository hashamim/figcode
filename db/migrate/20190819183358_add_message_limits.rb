class AddMessageLimits < ActiveRecord::Migration[5.2]
  def change
        add_column :users, :remaining_emails, :integer
        add_column :users, :remaining_characters, :integer
  end
end
