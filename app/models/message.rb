class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :marketplace_profile
end
