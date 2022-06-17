class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
