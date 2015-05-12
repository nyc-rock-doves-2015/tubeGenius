class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :commentable
      t.string :commentable_type
      t.references :comment
      t.references :notifiable, polymorphic: true, index: true
      t.boolean :read
      t.timestamps
    end
  end
end

