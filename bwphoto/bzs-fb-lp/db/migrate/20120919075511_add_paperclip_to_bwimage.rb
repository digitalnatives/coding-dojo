class AddPaperclipToBwimage < ActiveRecord::Migration
  def self.up
    add_attachment :bwimage, :image
  end

  def self.down
    remove_attachment :bwimage, :image
  end
end
