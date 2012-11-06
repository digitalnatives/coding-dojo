class CreateBwimages < ActiveRecord::Migration
  def change
    create_table :bwimages do |t|
      t.string :title
      t.string :photo
      t.string :camera
      t.date   :taken_at
      t.string :author
      t.string :filename
      t.string :status, default: "draft"
      t.string :url

      t.timestamps
    end
  end
end
