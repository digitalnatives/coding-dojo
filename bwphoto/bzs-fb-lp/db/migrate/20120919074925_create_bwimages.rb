class CreateBwimages < ActiveRecord::Migration
  def change
    create_table :bwimages do |t|
      t.string :status
      t.string :title
      t.string :filename
      t.string :content_type
      t.string :camera
      t.datetime :date
      t.string :author
      t.string :url

      t.timestamps
    end
  end
end
