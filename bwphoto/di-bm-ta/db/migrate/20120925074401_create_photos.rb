class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string    :title, :null => false
      t.string    :author
      t.string    :camera
      t.string    :url
      t.datetime  :taken_at
      t.string    :status, :null => false, :default => "queued"
      t.has_attached_file :photo
      t.timestamps
    end
  end
end
