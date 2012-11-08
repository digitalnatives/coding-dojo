class AddPaperclipToBwimage < ActiveRecord::Migration
  def self.up
    add_attachment :bwimages, :image
  end

  def self.down
    remove_attachment :bwimages, :image
  end
end
