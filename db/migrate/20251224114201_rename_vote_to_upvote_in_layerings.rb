class RenameVoteToUpvoteInLayerings < ActiveRecord::Migration[7.1]
  def change
    rename_column :layerings, :vote, :upvote
  end
end
