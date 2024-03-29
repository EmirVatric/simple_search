# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, index: true
      t.text :content, index: true
      t.timestamps
    end
  end
end
