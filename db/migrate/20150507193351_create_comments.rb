class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.string :start_time
      t.string :end_time
      t.string :media_url
      t.string :media_type
      t.references :user
      t.references :video

      t.timestamps
    end
  end
end
