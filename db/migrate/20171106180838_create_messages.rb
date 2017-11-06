class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.string :created_by

      t.timestamps
    end
  end
end
