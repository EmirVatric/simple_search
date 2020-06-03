class CreateQueries < ActiveRecord::Migration[6.0]
  def change
    create_table :queries do |t|
      t.integer :user_id, index: true
      t.string :act_identifier, index: true
      t.string :query, index: true
      t.boolean :found
      t.integer :counter, :default => 1
      
      t.timestamps
    end
  end
end
