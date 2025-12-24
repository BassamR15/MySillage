class RemoveReferenceFromSeasonVotes < ActiveRecord::Migration[7.1]
  def change
    remove_column :season_votes, :reference, :string
  end
end
