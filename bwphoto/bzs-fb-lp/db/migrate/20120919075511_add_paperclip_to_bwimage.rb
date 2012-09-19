class AddPaperclipToBwimage < ActiveRecord::Migration
  def self.up
    add_attachment :bwimage :avatar
  end

  def self.down
    remove_attachment :bwimage, :avatar
  end
end
