class CreateBwimages < ActiveRecord::Migration
  def change
    create_table :bwimages do |t|
      t.string :name
      t.string :camera
      t.datetime :date
      t.string :author
      t.string :url
      add_attachment

      t.timestamps
    end
  end
end
