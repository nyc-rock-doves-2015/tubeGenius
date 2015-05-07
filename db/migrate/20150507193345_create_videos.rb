class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, null: false
      t.text :description
      t.string :url, null: false
      t.string :category
      t.references :user
      t.string :availability

      t.timestamps
    end
  end
end
